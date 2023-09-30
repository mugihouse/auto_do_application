FactoryBot.define do
  factory :task do
    association :user
    title { 'test_title' }
    body { 'body' }
    time_required { :short }
  end
end
