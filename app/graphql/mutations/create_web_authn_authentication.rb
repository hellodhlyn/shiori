class Mutations::CreateWebAuthnAuthentication < Mutations::Base::Mutation
  argument :username,   String, required: false
  argument :credential, String, required: true

  field :success, Boolean, null: false

  def resolve(username: nil, credential:)
    unless current_user.present?
      raise GraphQL::ExecutionError.new("Unauthorized") unless username.present?
    end

    user = current_user || User.find_by!(name: username)
    begin
      Authentications::WebAuthn.verify_register!(user, JSON.parse(credential))
    rescue WebAuthn::Error => e
      Rails.logger.warn(e)
      raise GraphQL::ExecutionError.new("Invalid credential")
    end

    { success: true }
  end
end
