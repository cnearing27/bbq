FactoryGirl.define do
  factory :event do
    association :user

    title { "Event #{rand(10)}" }

    address { "Ленина, #{rand(100)}"}

    datetime { DateTime.parse("02.11.2022 06:00")}
  end
end
