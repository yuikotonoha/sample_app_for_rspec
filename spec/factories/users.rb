FactoryBot.define do
  factory :user do
    email { 'kotonoha@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :yukinoha, class: User do
    email { 'yukinoha@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
