# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Joe Example"
    email "example@example.com"
    password "secretsecret"
    password_confirmation "secretsecret"
  end
end
