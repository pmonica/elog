FactoryGirl.define do
  factory :organization do
    sequence(:name) { |n| "Organizacao#{n}" }
    country "Example Country"
  end
end

