# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki do
    sequence(:title) { |n| "Wiki #{n}" }
    content "**MyText**"
    private false

    trait :private do
      private true
    end

    factory :private_wiki, traits: [:private]
  end


end
