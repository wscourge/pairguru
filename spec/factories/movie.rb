FactoryBot.define do
  factory :movie do
    title { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence(3) }
    released_at { FFaker::Time.between(40.years.ago, Time.zone.today) }
    genre
  end
end
