FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    name { FFaker::Name.first_name }
    password { FFaker::Internet.password }

    after(:build) { |user| user.password_confirmation = user.password }
  end
end
