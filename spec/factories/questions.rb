FactoryBot.define do  
  sequence :title do |n|
    "MyString#{n}"
  end

  factory :question do
    title { "MyString" }
    body { "MyText" }

    trait :invalid do
      title { nil }
    end
  end
  factory :questions, parent: :question do
    title
    body
  end
end
