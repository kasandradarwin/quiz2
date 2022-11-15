FactoryBot.define do
  RANDOM_CHARS = "This is a really good idea. This is a really good idea. This is a really good idea. This is a really good idea."
  factory :idea do
    title {Faker::Company.bs}
    description { "{RANDOM_CHARS}"}
    association :user, factory: :user
    
  end
end
