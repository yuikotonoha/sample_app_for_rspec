require 'rails_helper'

RSpec.describe 'Users', type: :system do

  describe 'ログイン前' do
    context '入力値が正常' do
      it 'ユーザーの新規作成ができる' do
        # ユーザー作成画面を開く
        visit new_user_path
        # 入力フォームにEmailとパスワードと、確認用パスワードを入力する
        fill_in 'user[email]', with: 'kotonoha@gmail.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        # SignUpボタンをクリックする
        click_button("SignUp")
        # ユーザー作成が成功したことを検証する
        expect(page).to have_content 'User was successfully created.'
      end
    end
  end

  describe 'ログイン後' do
    let(:kotonoha) { create :user }
    context '入力値が正常' do
      it 'ユーザーの編集ができる' do
        # kotonohaとして操作
        login(kotonoha)
        # プロフィール編集を開く
        visit edit_user_path(kotonoha)
        # プロフィール編集で入力をする
        fill_in 'user[email]', with: 'kotonoha2@gmail.com'
        fill_in 'user[password]', with: 'password2'
        fill_in 'user[password_confirmation]', with: 'password2'
        # Updateボタンをクリックする
        click_button("Update")
        # プロフィール更新に成功したことを検証する
        expect(page).to have_content 'User was successfully updated.'
      end
    end
  end

  describe 'ログイン前' do
    before do
      # ユーザを作成する
      @user = create(:user)
    end
    context '入力値が正常' do
      it 'ログインが成功する' do
        # トップページを開く
        visit login_path
        # ログインフォームにEmailとパスワードを入力する
        fill_in 'email', with: 'kotonoha@gmail.com'
        fill_in 'password', with: 'password'
        # ログインボタンをクリックする
        click_button("Login")
        # ログインに成功したことを検証する
        expect(page).to have_content 'Login successful'
      end
    end
  end


end

