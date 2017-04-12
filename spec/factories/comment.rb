::FactoryGirl.define do
  factory :comment do
    post
    association :author, factory: :user
    body       { ::Faker::Hacker.say_something_smart }
  end
end
