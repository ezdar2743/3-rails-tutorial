# メインのサンプルユーザーを1人作成する
User.create!(name: 'Ezdar',
             email: 'ezdar2743@gmail.com',
             password: '1234',
             password_confirmation: '1234',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'
  User.create!(name:,
               email:,
               password:,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
