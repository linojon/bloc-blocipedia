# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Test User"
    email "test@example.com"
    password "secretsecret"
    password_confirmation "secretsecret"

    factory :user_with_wikis do
      after(:create) do |user, evaluator|
        user.wikis << create( :wiki)
        user.wikis << create( :wiki)
        user.wikis << create( :private_wiki)
      end
    end
  end
end
