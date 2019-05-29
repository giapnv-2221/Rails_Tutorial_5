User.create!(name:  "giapb",
             email: "giapb@mail.com",
             password:              "Aa123456",
             password_confirmation: "Aa123456",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

49.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "Foobar123456"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
