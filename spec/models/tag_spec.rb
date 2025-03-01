require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { build(:tag) }

  it { should validate_presence_of(:nome) }
  it { should validate_uniqueness_of(:nome).case_insensitive }
end
