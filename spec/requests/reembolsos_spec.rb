require 'rails_helper'

RSpec.describe "Reembolsos API", type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }

  describe "GET /reembolsos" do
    it "returns a list of reembolsos for the authenticated user" do
      create_list(:reembolso, 3, user: user)

      get "/reembolsos", headers: auth_headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "POST /reembolsos" do
    it "creates a new reembolso" do
      params = {
        reembolso: {
          descricao: "Almoço com cliente",
          valor: 75.50,
          data: "2025-01-10"
        }
      }

      post "/reembolsos", params: params, headers: auth_headers
      expect(response).to have_http_status(:created)
    end
  end
end
