namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    100.times do |n|
      fname = Faker::Name.first_name
      lname = Faker::Name.last_name
      username = Faker::Internet.user_name("#{n} #{lname}", %w(. _ -))
      email = "test-#{n+1}@example.com"
      password  = "password"
      User.create!( fname: fname,
                    lname: lname,
                    username: username,
                    email: email,
                    gender: "Male",
                    birthdate: Date.new,
                    height: 100,
                    weight: 140,
                    password: password,
                    password_confirmation: password)
    end
  end
end
