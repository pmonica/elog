FactoryGirl.define do
  factory :situation do
    association :user, factory: :user
    association :organization, factory: :organization

    sequence(:name) { |n| "This is a new situation with ID: #{n}" }
    level :Local
    sensitivity :Secret
  end
end