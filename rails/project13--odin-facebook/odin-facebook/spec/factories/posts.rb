FactoryGirl.define do
  factory :post do
    author_id 1
    content Faker::Lorem.sentence
  end
end
