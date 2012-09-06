FactoryGirl.define do
  factory :user do
    name                  'peon'
    sequence(:email)      { |n| "person_#{n}@example.com" }
    password              'password'
    password_confirmation { password }

    complete_info false
  end
end
