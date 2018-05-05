FactoryBot.define do
  factory :participant do
    lottery_id 1
    user_name "StringName"
    result 10

    trait :invalid do
      user_name nil
    end

  end

  factory :part_one, class: Participant do
    lottery_id 1
    user_name "StringName1"
    result 10
  end

  factory :part_two, class: Participant do
    lottery_id 1
    user_name "StringName2"
    result 20
  end

  factory :part_three, class: Participant do
    lottery_id 1
    user_name "StringName3"
    user_name 10
  end

end
