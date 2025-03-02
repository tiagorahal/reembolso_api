require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).scoped_to(:provider).case_insensitive }

  context "on create" do
    it "validates presence of password" do
      user = build(:user, password: nil)
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("can't be blank")
    end
  end
end
