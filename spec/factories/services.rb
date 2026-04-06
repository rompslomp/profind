FactoryBot.define do
  factory :service do
    sequence(:title) { |n| "Service #{n}" }
    description { "Professional service with years of expertise." }
    association :user, factory: [ :user, :provider ]
  end
end
