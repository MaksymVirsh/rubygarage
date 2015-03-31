FactoryGirl.define do
  factory :authorization do
    user nil
    provider 'Custom provider'
    uid 'uid1234567890'
  end
end
