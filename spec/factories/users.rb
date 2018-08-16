FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "username_#{n}" }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { 'password' }
  end
end
