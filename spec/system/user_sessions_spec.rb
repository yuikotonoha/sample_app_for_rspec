require 'rails_helper'

RSpec.describe 'Users', type: :system do

  describe 'ログイン前' do
    # ユーザを作成する
    let(:user) { create :user }
    context '入力値が正常' do
      it 'ログインが成功する' do
        # トップページを開く
        visit login_path
        # ログインフォームにEmailとパスワードを入力する
        fill_in 'email', with: user.email
        fill_in 'password', with: 'password'
        # ログインボタンをクリックする
        click_button('Login')
        # ログインに成功したことを検証する
        expect(page).to have_content 'Login successful'
      end
    end
  end

  describe 'ログイン前' do
    before do
      # ユーザを作成する
      create(:user)
    end
    context 'フォーム未入力時に' do
      it 'ログインが失敗する' do
        # トップページを開く
        visit login_path
        # ログインフォームにEmailとパスワードを入力する
        fill_in 'email', with: ''
        fill_in 'password', with: ''
        # ログインボタンをクリックする
        click_button('Login')
        # ログインに成功したことを検証する
        expect(page).to have_content 'Login failed'
      end
    end
  end
end
