FactoryGirl.define do
  factory :situation do
    association :user, factory: :user

    sequence(:name) { |n| "This is a new situation with ID: #{n}" }
    level 1
    sensitivity 1
  end
end