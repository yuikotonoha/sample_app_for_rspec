require 'rails_helper'

RSpec.describe 'Users', type: :system do

  let(:user) { create :user }
  let(:other_user) { create :user }

  describe 'ログイン前' do
    context '入力値が正常' do
      it 'ユーザーの新規作成ができる' do
        # ユーザー作成画面を開く
        visit new_user_path
        # 入力フォームにEmailとパスワードと、確認用パスワードを入力する
        fill_in 'user[email]', with: 'user@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        # SignUpボタンをクリックする
        click_button('SignUp')
        # ユーザー作成が成功したことを検証する
        expect(page).to have_content 'User was successfully created.'
      end
    end
  end

  describe 'ログイン後' do
    context '入力値が正常' do
      it 'ユーザーの編集ができる' do
        # userとして操作
        login(user)
        # プロフィール編集を開く
        visit edit_user_path(user)
        # プロフィール編集で入力をする
        fill_in 'user[email]', with: 'user2@example.com'
        fill_in 'user[password]', with: 'password2'
        fill_in 'user[password_confirmation]', with: 'password2'
        # Updateボタンをクリックする
        click_button('Update')
        # プロフィール更新に成功したことを検証する
        expect(page).to have_content 'User was successfully updated.'
      end
    end
  end

  describe 'ログイン後' do
    context 'マイページにアクセス' do
      it '新規作成したタスクが表示されている' do
        # userとして操作
        login(user)
        # タスクを1件作成
        task_create
        # プロフィール編集を開く
        visit user_path(user)
        # 他のユーザーのプロフィール編集ページへアクセスが失敗したことを検証する
        expect(page).to have_content 'RUNTEQ応用課題16'
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
        click_button('SignUp')
        # ユーザー作成が失敗したことを検証する
        expect(page).to have_content "Email can't be blank"
      end
    end
  end

  describe 'ログイン後' do
    context 'メールアドレスが未入力時に' do
      it 'ユーザーの編集が失敗する' do
        # userとして操作
        login(user)
        # プロフィール編集を開く
        visit edit_user_path(user)
        # プロフィール編集で入力をする
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: 'password2'
        fill_in 'user[password_confirmation]', with: 'password2'
        # Updateボタンをクリックする
        click_button('Update')
        # プロフィール更新が失敗したことを検証する
        expect(page).to have_content "Email can't be blank"
      end
    end
  end

  describe 'ログイン前' do
    context '登録済メールアドレス使用時に' do
      it 'ユーザーの新規作成が失敗する' do
        # ユーザー作成画面を開く
        visit new_user_path
        # 入力フォームにEmailを入力する
        fill_in 'user[email]', with: user.email
        # SignUpボタンをクリックする
        click_button('SignUp')
        # ユーザー作成が失敗したことを検証する
        expect(page).to have_content 'Email has already been taken'
      end
    end
  end

  describe 'ログイン後' do
    context '登録済メールアドレス使用時に' do
      it 'ユーザーの編集が失敗する' do
        # other_userとして操作
        login(other_user)
        # プロフィール編集を開く
        visit edit_user_path(other_user)
        # 入力フォームにEmailを入力する
        fill_in 'user[email]', with: user.email
        # Updateボタンをクリックする
        click_button('Update')
        # プロフィール更新が失敗したことを検証する
        expect(page).to have_content 'Email has already been taken'
      end
    end
  end

  describe 'ログイン前' do
    context '' do
      it 'マイページへアクセスが失敗する' do
        current_user = user
        # ユーザー作成画面を開く
        visit user_path(current_user)
        # マイページへのアクセスが失敗したことを検証する
        expect(page).to have_content 'Login required'
      end
    end
  end

  describe 'ログイン後' do
    context '' do
      it '他のユーザーの編集ページへアクセスが失敗する' do
        # userとして操作
        login(user)
        # プロフィール編集を開く
        visit edit_user_path(other_user)
        # 他のユーザーのプロフィール編集ページへアクセスが失敗したことを検証する
        expect(page).to have_content 'Forbidden access.'
      end
    end
  end

end
