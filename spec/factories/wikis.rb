# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki do
    sequence(:title) { |n| "Page #{n}" }
    content "MyText"
    private false
  end
end
