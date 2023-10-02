FactoryBot.define do
  factory :notification do
    association :task
    association :user

    delivery_date { '2025-02-12 19:00' }

    trait :send_task do
      status { :send_task }
    end

    trait :done_task do
      status { :done_task }
    end
  end
end
