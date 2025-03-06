require 'rails_helper'

RSpec.describe "Reembolsos API", type: :request do
  let(:user) { User.create!(email: "user@example.com", password: "password123") }
  let(:tag) { Tag.create!(nome: "Transporte") }
  let(:reembolso) { user.reembolsos.create!(descricao: "Táxi", valor: 35.00, data: Date.today, tags: [tag]) }

  let(:auth_headers) do
    post "/auth/sign_in", params: { email: user.email, password: "password123" }
    {
      "access-token" => response.headers["access-token"],
      "client" => response.headers["client"],
      "uid" => response.headers["uid"]
    }
  end

  describe "GET /reembolsos" do
    it "returns all reembolsos for the user" do
      get "/reembolsos", headers: auth_headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /reembolsos" do
    it "creates a new reembolso" do
      post "/reembolsos",
        params: { reembolso: { descricao: "Táxi", valor: 35.00, data: Date.today, tag_ids: [tag.id] } },
        headers: auth_headers

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["descricao"]).to eq("Táxi")
    end
  end

  describe "PUT /reembolsos/:id" do
    it "updates an existing reembolso" do
      put "/reembolsos/#{reembolso.id}",
        params: { reembolso: { descricao: "Táxi Editado", valor: 40.00, data: Date.today } },
        headers: auth_headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["descricao"]).to eq("Táxi Editado")
    end
  end

  describe "DELETE /reembolsos/:id" do
    it "deletes a reembolso" do
      delete "/reembolsos/#{reembolso.id}", headers: auth_headers
      expect(response).to have_http_status(:ok)
    end
  end
end
