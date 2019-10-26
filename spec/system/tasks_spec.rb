require 'rails_helper'

RSpec.describe 'Tasks', type: :system do

  describe 'ログイン後' do
    let(:kotonoha) { create :user }
    context '入力値が正常' do
      it 'タスクの新規作成ができる' do
        # kotonohaとして操作
        login(kotonoha)
        # タスクの新規作成画面を開く
        visit new_task_path
        # タスクの新規作成画面で入力をする
        fill_in 'task[title]', with: 'RUNTEQ応用課題16'
        fill_in 'task[content]', with: 'systen specを書く'
        select 'todo', from: 'Status'
        fill_in 'task[deadline]', with: Time.new(2020, 01, 02, 12)
        # Create Taskボタンをクリックする
        click_button("Create Task")
        # タスクの新規作成に成功したことを検証する
        expect(page).to have_content 'Task was successfully created.'
      end
    end
  end

  describe 'ログイン後' do
    let(:kotonoha) { create :user }
    let(:test_task) { create :task, user_id: 1 }
    context '入力値が正常' do
      it 'タスクの編集ができる' do
        # kotonohaとして操作
        login(kotonoha)
        # タスクの新規作成画面を開く
        visit edit_task_path(test_task)
        # タスクの新規作成画面で入力をする
        fill_in 'task[title]', with: 'RUNTEQ応用課題16'
        fill_in 'task[content]', with: 'タスクを編集する'
        select 'todo', from: 'Status'
        fill_in 'task[deadline]', with: Time.new(2040, 01, 02, 12)
        # Update Taskボタンをクリックする
        click_button("Update Task")
        # タスクの新規作成に成功したことを検証する
        expect(page).to have_content 'Task was successfully updated.'
      end
    end
  end

  describe 'ログイン後' do
    let(:kotonoha) { create :user }
    context 'タスク一覧で Destroy のリンクをクリックすれば' do
      it 'タスクの削除ができる' do
        # kotonohaとして操作
        login(kotonoha)
        Task.create!(title: '課題16', status: 0, user_id: 1)
        # タスク一覧画面を開く
        visit root_path
        # Destroyボタンをクリックする
        click_link 'Destroy'
        page.driver.browser.switch_to.alert.accept
        # タスクの削除に成功したことを検証する
        expect(page).to have_content 'Task was successfully destroyed.'
      end
    end
  end

  describe 'ログイン前' do
    context 'タスクの新規作成ページ' do
      it 'アクセスが失敗する' do
        # タスクの新規作成画面を開く
        visit new_task_path
        # タスクの新規作成にアクセスできないことを検証する
        expect(page).to have_content 'Login required'
      end
    end
  end

  describe 'ログイン前' do
    context 'タスクの編集ページ' do
      it 'アクセスが失敗する' do
        Task.create!(title: '課題16', status: 0, user_id: 1)
        # タスクの新規作成画面を開く
        visit edit_task_path(1)
        # タスクの新規作成にアクセスできないことを検証する
        expect(page).to have_content 'Login required'
      end
    end
  end

  describe 'ログイン後' do
    let(:kotonoha) { create :user }
    let(:test_task) { create :task, user_id: 2 }
    context '他のユーザーのタスク編集ページ' do
      it 'アクセスが失敗' do
        # kotonohaとして操作
        login(kotonoha)
        # タスクの新規作成画面を開く
        visit edit_task_path(test_task)
        # タスクの新規作成に成功したことを検証する
        expect(page).to have_content 'Forbidden access.'
      end
    end
  end
end
