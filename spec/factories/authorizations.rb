FactoryGirl.define do
  factory :authorization do
    user nil
    provider { Faker::Company.name }
    uid { Faker::Internet.password }
  end
end
