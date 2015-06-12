FactoryGirl.define do
  factory :user do
    name     "test user"
    email    "test@user.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
