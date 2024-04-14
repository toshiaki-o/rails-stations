FactoryBot.define do
  factory :screen do
    association :schedule, factory: :schedule
    association :theater, factory: :theater
    sequence(:name) { |n| n }
    sequence(:date) { |n| "2024-04-0#{n}"}
  end
end