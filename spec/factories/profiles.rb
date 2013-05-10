FactoryGirl.define do
  factory :profile do
    sequence(:name) { |n| "Profile #{n}"}
    sequence(:email) { |n| "test#{n}@example.org"}

    trait :approved do
      approved true
    end

    trait :unapproved do
      approved false
    end

    trait :organizer do
      approved
      organizer true
    end

    trait :non_organizer do
      approved
      organizer false
    end
  end
end