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

  describe 'ログイン後' do
    let(:kotonoha) { create :user }
    context 'マイページにアクセス' do
      it '新規作成したタスクが表示されている' do
        # kotonohaとして操作
        login(kotonoha)
        # タスクを1件作成
        task_create
        # プロフィール編集を開く
        visit user_path(kotonoha)
        # 他のユーザーのプロフィール編集ページへアクセスが失敗したことを検証する
        expect(page).to have_content "RUNTEQ応用課題16"
      end
    end
  end

  describe 'ログイン前' do
    context 'メールアドレスが未入力時に' do
      it 'ユーザーの新規作成が失敗する' do
        # ユーザー作成画面を開く
        visit new_user_path
        # 入力フォームにパスワードと、確認用パスワードを入力する
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        # SignUpボタンをクリックする
        click_button("SignUp")
        # ユーザー作成が失敗したことを検証する
        expect(page).to have_content "Email can't be blank"
      end
    end
  end

  describe 'ログイン後' do
    let(:kotonoha) { create :user }
    context 'メールアドレスが未入力時に' do
      it 'ユーザーの編集が失敗する' do
        # kotonohaとして操作
        login(kotonoha)
        # プロフィール編集を開く
        visit edit_user_path(kotonoha)
        # プロフィール編集で入力をする
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: 'password2'
        fill_in 'user[password_confirmation]', with: 'password2'
        # Updateボタンをクリックする
        click_button("Update")
        # プロフィール更新が失敗したことを検証する
        expect(page).to have_content "Email can't be blank"
      end
    end
  end

  describe 'ログイン前' do
    context '登録済メールアドレス使用時に' do
      it 'ユーザーの新規作成が失敗する' do
        User.create!(email: 'kotonoha@gmail.com', password: 'password', password_confirmation: 'password' )
        # ユーザー作成画面を開く
        visit new_user_path
        # 入力フォームにEmailを入力する
        fill_in 'user[email]', with: 'kotonoha@gmail.com'
        # SignUpボタンをクリックする
        click_button("SignUp")
        # ユーザー作成が失敗したことを検証する
        expect(page).to have_content "Email has already been taken"
      end
    end
  end

  describe 'ログイン後' do
    let(:kotonoha) { create :user }
    context '登録済メールアドレス使用時に' do
      it 'ユーザーの編集が失敗する' do
        User.create!(email: 'yukinoha@gmail.com', password: 'password', password_confirmation: 'password' )
        # kotonohaとして操作
        login(kotonoha)
        # プロフィール編集を開く
        visit edit_user_path(kotonoha)
        # 入力フォームにEmailを入力する
        fill_in 'user[email]', with: 'yukinoha@gmail.com'
        # Updateボタンをクリックする
        click_button("Update")
        # プロフィール更新が失敗したことを検証する
        expect(page).to have_content "Email has already been taken"
      end
    end
  end

  describe 'ログイン前' do
    context 'マイページ' do
      it 'アクセスが失敗' do
        current_user = User.create!(email: 'kotonoha@gmail.com', password: 'password', password_confirmation: 'password' )
        # ユーザー作成画面を開く
        visit user_path(current_user)
        # マイページへのアクセスが失敗したことを検証する
        expect(page).to have_content "Login required"
      end
    end
  end

  describe 'ログイン後' do
    let(:kotonoha) { create :user }
    context '他のユーザーの編集ページ' do
      it 'アクセスが失敗' do
        yukinoha = User.create!(email: 'yukinoha@gmail.com', password: 'password', password_confirmation: 'password' )
        # kotonohaとして操作
        login(kotonoha)
        # プロフィール編集を開く
        visit edit_user_path(yukinoha)
        # 他のユーザーのプロフィール編集ページへアクセスが失敗したことを検証する
        expect(page).to have_content "Forbidden access."
      end
    end
  end

end
