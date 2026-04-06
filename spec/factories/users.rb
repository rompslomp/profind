FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:name) { |n| "User #{n}" }
    password { "password123" }
    password_confirmation { "password123" }
    role { :basic }
    provider_status { :not_requested }

    trait :admin do
      role { :admin }
      sequence(:email) { |n| "admin#{n}@example.com" }
      sequence(:name) { |n| "Admin #{n}" }
    end

    trait :provider do
      role { :provider }
      provider_status { :approved }
      sequence(:email) { |n| "provider#{n}@example.com" }
      sequence(:name) { |n| "Provider #{n}" }
      provider_bio { "Experienced professional with 10 years of expertise." }
    end

    trait :pending do
      provider_status { :pending }
      sequence(:email) { |n| "pending#{n}@example.com" }
    end
  end
end
