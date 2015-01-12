FactoryGirl.define do
  factory :user do
    association :organization
    confirmed_at Time.now
    name "Test User"
    sequence(:email) { |n| "test#{n}@example.com" }
    password "please123"
    role :p1
    clearance :Public

    trait :admin do
      role 'admin'
    end

  end
end
