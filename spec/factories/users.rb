FactoryBot.define do
  factory :user do
    sequence(:line_id) { |n| "test_line_id#{n}" }

    trait :admin do
      sequence(:line_id) { |n| "admin_line_id#{n}" }
      role { :admin }
    end

    trait :general do
      sequence(:line_id) { |n| "general_line_id#{n}" }
      role { :general }
    end
  end
end
