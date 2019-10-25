require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    # ユーザを作成する
    User.create!(email: 'foo@example.com', password: '123456', password_confirmation: "123456")
  end
  it 'ログインする' do
    # トップページを開く
    visit login_path
    # ログインフォームにEmailとパスワードを入力する
    fill_in 'email', with: 'foo@example.com'
    fill_in 'password', with: '123456'
    # ログインボタンをクリックする
    click_button("Login")
    # ログインに成功したことを検証する
    expect(page).to have_content 'Login successful'
  end
end