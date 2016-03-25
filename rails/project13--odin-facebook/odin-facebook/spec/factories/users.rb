FactoryGirl.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    password { Faker::Internet.password }
    email { Faker::Internet.email }
    sequence(:age) { |n| n }

    # factory :user_with_requesting_friendships do


    # 	after(:build) do |user, evaluator|
    #     .each do |phone|
    #     user_with_requesting_friendships.requesting_friendships << build(:friendship, , contact: contact)
    #   end
    # end
  end
end
