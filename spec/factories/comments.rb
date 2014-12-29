FactoryGirl.define do
  factory :comment do
    association :event, factory: :event
    association :user, factory: :user

    body 'This is a cool comment!'
    level :local
    sensitivity :secreto
 end

  trait :with_comments do
    after :create do |event|
      FactoryGirl.create_list :comment, 3, :event => event
    end
  end
end
