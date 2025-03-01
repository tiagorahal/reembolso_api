require 'rails_helper'

RSpec.describe ReembolsoTag, type: :model do
  it { should belong_to(:reembolso) }
  it { should belong_to(:tag) }
end
