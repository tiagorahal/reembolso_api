require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "is valid with a unique nome" do
    tag = Tag.new(nome: "Transporte")
    expect(tag).to be_valid
  end

  it "is not valid without a nome" do
    tag = Tag.new(nome: nil)
    expect(tag).not_to be_valid
  end

  it "is not valid with a duplicate nome (case insensitive)" do
    Tag.create(nome: "Transporte")
    duplicate_tag = Tag.new(nome: "transporte")
    expect(duplicate_tag).not_to be_valid
  end
end
