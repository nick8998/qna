FactoryBot.define do
  factory :subscription do
    user_id { create(:user).id }
    question_id { create(:question).id }
  end
end
