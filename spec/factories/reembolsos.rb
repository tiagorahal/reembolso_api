FactoryBot.define do
  factory :reembolso do
    descricao { "Almoço com equipe" }
    valor { 100.0 }
    data { Date.today }
    association :user
  end
end
