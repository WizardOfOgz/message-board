::FactoryGirl.define do
  factory :post do
    association :author
    title      ::Faker::Hacker.ingverb
    body       ::Faker::Hacker.say_something_smart
  end
end
