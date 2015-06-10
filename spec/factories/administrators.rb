FactoryGirl.define do
  factory :administrator do
    sequence(:email) {|n| "admin#{n}@example.com"}
    password 'pw'
    suspend false
  end
end
#should be suspended - fixed
