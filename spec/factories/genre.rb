FactoryBot.define do
  factory :genre do
    name { FFaker::Lorem.word }

    trait :with_movies do
      after(:create) do |genre|
        create_list :movie, 5, genre: genre
      end
    end
  end
end
