# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki do
    title "MyString"
    content "MyText"
    private false
    owner nil
  end
end
