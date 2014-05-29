# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :leaf do
    title "MyString"
    copy "MyText"
    image "MyString"
    video "MyString"
    audio "MyString"
    url "MyString"
    via_url false
    live false
    plays 1
    views 1
    user_id 1
    type ""
  end
end
