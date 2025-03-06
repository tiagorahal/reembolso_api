require 'rails_helper'

RSpec.describe Reembolso, type: :model do
  let(:user) { User.create(email: "user@example.com", password: "password123") }

  it "is valid with valid attributes" do
    reembolso = user.reembolsos.build(descricao: "Almoço de trabalho", valor: 50.00, data: Date.today)
    expect(reembolso).to be_valid
  end

  it "is not valid without a descricao" do
    reembolso = user.reembolsos.build(descricao: nil, valor: 50.00, data: Date.today)
    expect(reembolso).not_to be_valid
  end

  it "is not valid without a valor" do
    reembolso = user.reembolsos.build(descricao: "Almoço", valor: nil, data: Date.today)
    expect(reembolso).not_to be_valid
  end

  it "is not valid with valor <= 0" do
    reembolso = user.reembolsos.build(descricao: "Almoço", valor: 0, data: Date.today)
    expect(reembolso).not_to be_valid
  end

  it "is not valid without a data" do
    reembolso = user.reembolsos.build(descricao: "Almoço", valor: 50.00, data: nil)
    expect(reembolso).not_to be_valid
  end

  it "can have multiple tags" do
    tag1 = Tag.create(nome: "Alimentação")
    tag2 = Tag.create(nome: "Trabalho")
    reembolso = user.reembolsos.create(descricao: "Almoço", valor: 50.00, data: Date.today, tags: [tag1, tag2])

    expect(reembolso.tags).to include(tag1, tag2)
  end
end
