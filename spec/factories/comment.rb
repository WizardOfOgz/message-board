::FactoryGirl.define do
  factory :comment do
    post
    author
    body       ::Faker::Hacker.say_something_smart
  end
end
