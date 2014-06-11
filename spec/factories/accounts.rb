# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    level "free"

    trait :premium do
      level 'premium'
    end

    factory :free_account
    factory :premium_account, traits: [:premium]
  end
end
