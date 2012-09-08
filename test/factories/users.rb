FactoryGirl.define do
  factory :user do
    name                  'peon'
    sequence(:email)      { |n| "person_#{n}@example.com" }
    password              'password'
    password_confirmation { password }

    head_url "/assets/654.jpg"
    complete_info false
    admin false
  end
end
