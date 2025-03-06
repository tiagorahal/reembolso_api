FactoryBot.define do
  factory :tag do
    sequence(:nome) { |n| "Tag #{n}" }
  end
end
