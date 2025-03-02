require 'rails_helper'

RSpec.describe "Tags API", type: :request do
  let(:user) { create(:user, password: "password123", confirmed_at: Time.now) }
  let(:auth_headers) do
    post "/auth/sign_in", params: { email: user.email, password: "password123" }
    response.headers.slice("client", "access-token", "uid")
  end

  describe "GET /tags" do
    before do
      create_list(:tag, 5)
      get "/tags", headers: auth_headers
    end

    it "returns all tags" do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(5)
    end
  end

  describe "POST /tags" do
    let(:params) { { tag: { nome: "Transporte" } } }

    it "creates a new tag" do
      post "/tags", params: params, headers: auth_headers
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["nome"]).to eq("Transporte")
    end
  end
end
