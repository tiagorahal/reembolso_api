require 'rails_helper'

RSpec.describe "Reembolsos API", type: :request do
  let(:user) { create(:user, password: "password123", confirmed_at: Time.now) } # Ensure user is confirmed
  let(:auth_headers) do
    post "/auth/sign_in", params: { email: user.email, password: "password123" }
    response.headers.slice("client", "access-token", "uid")
  end

  describe "GET /reembolsos" do
    before { get "/reembolsos", headers: auth_headers }

    it "returns a list of reembolsos for the authenticated user" do
      create_list(:reembolso, 3, user: user)
      get "/reembolsos", headers: auth_headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "POST /reembolsos" do
    let(:params) do
      { reembolso: { descricao: "Almoço com cliente", valor: 75.50, data: "2025-01-10" } }
    end

    it "creates a new reembolso" do
      post "/reembolsos", params: params, headers: auth_headers
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["descricao"]).to eq("Almoço com cliente")
    end
  end
end
