FactoryBot.define do
  factory :quote do
    message { "I need help with a repair in my home. Please provide a quote." }
    status { :pending }
    association :user
    association :service
  end
end
