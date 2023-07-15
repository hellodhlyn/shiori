class Mutations::ChallengeWebAuthnRegister < Mutations::BaseMutation
  argument :username,     String, required: false
  argument :display_name, String, required: false
  argument :email,        String, required: false

  field :options, String, null: false

  def resolve(username: nil, display_name: nil, email: nil)
    unless current_user.present?
      raise GraphQL::ExecutionError.new("Unauthorized") unless username.present?
    end

    ActiveRecord::Base.transaction do
      user = current_user || User.create!(name: username, display_name: display_name, email: email)
      Authentications::WebAuthn.challenge_register(user)
    end => options

    { options: options.to_json }
  end
end
