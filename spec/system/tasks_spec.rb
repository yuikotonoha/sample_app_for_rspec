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
        fill_in 'task[title]', with: 'kotonoha2@gmail.com'
        fill_in 'task[content]', with: 'password2'
        select 'todo', from: 'Status'
        fill_in 'task[deadline]', with: Time.new(2020, 01, 02, 12)
        # Updateボタンをクリックする
        click_button("Create Task")
        # タスクの新規作成に成功したことを検証する
        expect(page).to have_content 'Task was successfully created.'
      end
    end
  end

end
