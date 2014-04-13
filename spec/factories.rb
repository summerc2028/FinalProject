FactoryGirl.define do
  factory :user do
    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    sequence(:fname) { fname }
    sequence(:lname) { lname }
    sequence(:username) { |n| "#{lname}-#{n}" }
    sequence(:email) { |n| "#{fname}#{lname}-#{n}@example.com"}
    height 73
    weight 140
    gender "Male"
    sequence(:birthdate) { |n| Date.current - n }
    sequence(:status) { |n| Faker::Lorem.sentence }
    sequence(:auth_token) { |n| "#{SecureRandom.urlsafe_base64}#{n}" }
    password "password"
    password_confirmation "password"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
end
