FactoryGirl.define do
  factory :blog do
    title "sample blog"
    description "sample description"
    user
  end
end
