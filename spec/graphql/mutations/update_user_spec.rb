RSpec.describe Mutations::UpdateBlob, type: :graphql do
  let(:mutation_string) do
    <<~GQL
      mutation($input: UpdateUserInput!) {
        updateUser(input: $input) {
          user {
            displayName
            description
          }
        }
      }
    GQL
  end

  let(:user) { create :user }
  let(:input) { { description: Faker::Lorem.paragraph } }

  context "valid request" do
    subject do
      execute_graphql(mutation_string, context: { current_user: user }, variables: { input: input })
    end

    it "should update only given fields" do
      expect { subject }
        .to change { user.reload.description }.from(user.description).to(input[:description])
       .and not_change { user.display_name }
    
      expect(subject["data"]["updateUser"]["user"]["displayName"]).to eq user.display_name
      expect(subject["data"]["updateUser"]["user"]["description"]).to eq input[:description]
    end
  end

  context "unauthorized request" do
    subject do
      execute_graphql(mutation_string, context: { current_user: nil }, variables: { input: input })
    end

    it "should return an error" do
      expect(subject["errors"]).not_to be_nil
    end
  end
end
