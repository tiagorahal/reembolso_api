require 'rails_helper'

RSpec.describe Reembolso, type: :model do
  let(:user) { create(:user) }

  subject { build(:reembolso, user: user) }

  it { should belong_to(:user) }
  it { should validate_presence_of(:descricao) }
  it { should validate_presence_of(:valor) }
  it { should validate_numericality_of(:valor).is_greater_than(0) }
  it { should validate_presence_of(:data) }
end
