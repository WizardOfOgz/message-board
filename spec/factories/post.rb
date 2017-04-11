::FactoryGirl.define do
  factory :post do
    author
    title      ::Faker::Hacker.ingverb
    body       ::Faker::Hacker.say_something_smart
  end
end
