FactoryBot.define do
  factory :theater do
    sequence(:name) { |n| "劇場#{n}" }
  end
end