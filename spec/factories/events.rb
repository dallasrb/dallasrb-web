FactoryGirl.define do
  factory :event do
    event_type
    event_addresses { [association(:event_address)] }
    event_date Date.today
    sequence(:title) { |n| "Title #{n}"}
    sequence(:description) { |n| "Description #{n}"}

    trait :published do
      published true
    end

    trait :unpublished do
      published false
    end
  end
end