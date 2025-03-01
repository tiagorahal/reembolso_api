require 'rails_helper'

RSpec.describe "Tags API", type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }

  describe "GET /tags" do
    it "returns all tags" do
      create_list(:tag, 5)

      get "/tags", headers: auth_headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(5)
    end
  end

  describe "POST /tags" do
    it "creates a new tag" do
      params = { tag: { nome: "Transporte" } }

      post "/tags", params: params, headers: auth_headers
      expect(response).to have_http_status(:created)
    end
  end
end
