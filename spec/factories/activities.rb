# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    action "MyString"
    user_id 1
    other_id 1
    leaf_id 1
  end
end
