FactoryGirl.define do
  factory :todo do
    title 'Some Todo'

    factory :complete_todo do
      title 'Some Todo'
      complete true
    end
  end
end
