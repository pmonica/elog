FactoryGirl.define do
  factory :event do
    association :situation, factory: :situation
    association :user, factory: :user

    sequence(:title) { |n| "This is a new event with ID: #{n}" }
    level :Local
    sensitivity :Secret
  end
end