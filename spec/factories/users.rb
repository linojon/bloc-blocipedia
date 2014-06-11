# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Test User#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }

    password "secretsecret"
    password_confirmation "secretsecret"

    factory :user_with_wikis do
      after(:create) do |user, evaluator|
        user.wikis << create(:wiki)
      end
    end

    factory :premium_user do
      after(:create) do |user, evaluator|
        user.account.update_attribute :level, 'premium'
        user.wikis << create(:wiki)
        user.wikis << create(:private_wiki)
      end
    end
  end
end
