require 'rails_helper'

RSpec.describe "Tags API", type: :request do
  let(:user) { create(:user) }
  let!(:tags) { create_list(:tag, 3) }
  
  let(:auth_headers) do
    user.create_new_auth_token 
  end

  before do
    sign_in user 
  end

  describe "GET /tags" do
    it "returns all tags" do
      get "/tags", headers: auth_headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to be >= 1
    end
  end

  describe "POST /tags" do
    it "creates a new tag" do
      post "/tags",
        params: { tag: { nome: "Alimentação" } },
        headers: auth_headers

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["nome"]).to eq("Alimentação")
    end
  end
end
