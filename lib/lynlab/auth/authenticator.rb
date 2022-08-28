module LYnLab
  class Authenticator
    class Unauthorized < RuntimeError
      def initialize(msg)
        super(msg)
      end
    end

    class << self
      def authenticate(access_key)
        res = client.get("/whoami", nil, {
          "Authorization" => "Bearer #{access_key}",
        })
        raise Unauthorized.new("authentication failed (#{res.status})") unless res.success?

        JSON.parse(res.body)
      end

      private

      def client
        @client ||= Faraday.new("https://auth.lynlab.co.kr", headers: {
          "User-Agent" => "Shiori-CMS/1.0",
        })
      end
    end
  end
end
