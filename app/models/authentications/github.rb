class Authentications::Github < Authentication
  def self.authenticate!(access_token)
    res = Faraday.get("https://api.github.com/user", nil, {
      "Accept"               => "application/vnd.github+json",
      "Authorization"        => "Bearer #{access_token}",
      "X-GitHub-Api-Version" => "2022-11-28",
    })
    raise "GitHub API error" unless res.success?

    user_info = JSON.parse(res.body)
    self.find_or_create_by!(identifier: user_info["id"]) do |auth|
      auth.user = User.create!(
        name:              user_info["login"],
        display_name:      user_info["name"],
        email:             user_info["email"],
        profile_image_url: user_info["avatar_url"],
      )
    end.user
  end
end
