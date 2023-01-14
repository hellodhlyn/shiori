RSpec.describe ApiToken, type: :model do
  let(:user)      { create :user }
  let(:api_token) { ApiToken.generate(user) }

  describe ".generate" do
    it "successfully generates a new token" do
      expect { api_token }.not_to raise_error
      expect(api_token.access_key).not_to be_nil
      expect(api_token.refresh_key).not_to be_nil
    end
  end

  describe ".validate_key" do
    context "when the key is valid" do
      it "returns the user id" do
        expect(ApiToken.validate_key(api_token.access_key, ApiToken::KeyTypes::ACCESS_KEY)).to eq(user.uuid)
      end
    end

    context "when the key is expired" do
      it "raises an exception" do
        expect { ApiToken.validate_key(api_token.access_key, ApiToken::KeyTypes::ACCESS_KEY) }.not_to raise_error
        Timecop.travel(ApiToken::ACCESS_KEY_VALID_HOURS.hours.from_now + 1.hour) do
          expect { ApiToken.validate_key(api_token.access_key, ApiToken::KeyTypes::ACCESS_KEY) }.to raise_error(ApiToken::Exceptions::Expired)
        end
      end
    end

    context "when the key is invalid" do
      it "raises an exception" do
        expect { ApiToken.validate_key("invalid", ApiToken::KeyTypes::ACCESS_KEY) }.to raise_error(ApiToken::Exceptions::InvalidToken)
      end
    end

    context "when the key type is invalid" do
      it "raises an exception" do
        expect { ApiToken.validate_key(api_token.access_key, ApiToken::KeyTypes::REFRESH_KEY) }.to raise_error(ApiToken::Exceptions::InvalidType)
      end
    end
  end
end
