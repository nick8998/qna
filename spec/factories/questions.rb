FactoryBot.define do 
  factory :question do
    sequence(:title) { |n| "Question title #{n}" }
    sequence(:body) { |n| "Question body #{n}" }

    trait :invalid do
      title { nil }
    end

    trait :with_file do
      files { ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"] }
    end
  end
end
