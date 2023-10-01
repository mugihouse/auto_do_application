FactoryBot.define do
  factory :profile do
    association :user
    dinner_time { '2025-02-12 19:00' }
    bedtime { '2025-02-12 23:00' }
  end
end
