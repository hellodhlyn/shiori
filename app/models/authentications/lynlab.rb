module Authentications
  class Lynlab < Authentication
    def self.get_or_create_user!(access_key)
      user_info = ::LYnLab::Authenticator.authenticate!(access_key)
      auth = find_by(user_id: user_info["id"])
      return auth.user if auth.present?

      ActiveRecord::Base.transaction do
        create!(
          identifier: user_info["id"],
          user: User.create!(
            name:              user_info["name"],
            display_name:      user_info["displayName"],
            profile_image_url: user_info["profileImage"],
          ),
        ).user
      end
    end
  end
end
