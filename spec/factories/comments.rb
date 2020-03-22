FactoryBot.define do
  factory :comment do
    user
    movie
    content { FFaker::Lorem.paragraph(5) }
  end
end
