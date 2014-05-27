# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    title "MyString"
    public false
    image "MyString"
    description "MyText"
    user_id 1
    type ""
    size 1
    slug "MyString"
    views 1
  end
end
