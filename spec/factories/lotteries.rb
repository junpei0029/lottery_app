FactoryBot.define do
  factory :lottery do
    name "MyString"
    winning_number 1
    detail "MyText"
    status 10

    trait :invalid do
      name nil
    end

  end

  factory :lot_one, class: Lottery do
    name "MyString1"
    winning_number 1
    detail "MyText1"
    status 10
  end

  factory :lot_two, class: Lottery do
    name "MyString2"
    winning_number 2
    detail "MyText2"
    status 30
  end

end
