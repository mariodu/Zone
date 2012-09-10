FactoryGirl.define do
  factory :topic do
    title   'Topic title'
    content 'Topic Content'
    fonder  { FactoryGirl.create(:user) }
    tag_string 'wow, dota'
  end
end