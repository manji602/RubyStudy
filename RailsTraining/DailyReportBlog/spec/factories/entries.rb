FactoryGirl.define do
  factory :entry do
    title "sample entry"
    body "sample body"
    user
    blog
  end
end
