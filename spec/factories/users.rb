FactoryBot.define do
  factory :user do
    email { 'kotonoha@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
