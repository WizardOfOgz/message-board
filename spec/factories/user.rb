::FactoryGirl.define do
  factory :user do
    email          ::Faker::Internet.email
    first_name     ::Faker::Name.first_name
    last_name      ::Faker::Name.last_name
    password               "abcdefg"
    password_confirmation  { |user| user.password }
    confirmed_at   Date.current
  end
end
