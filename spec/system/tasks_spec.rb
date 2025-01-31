RSpec.describe 'Tasks', type: :system do

  let(:user) { create :user }
  let(:other_user) { create :user }
  let(:task) { create :task, user_id: user.id }
  let(:other_user_task) { create :task, user_id: other_user.id }

  describe 'ログイン前' do
    describe 'タスクの新規作成ページ' do
      context '権限がない為' do
        it 'アクセスが失敗する' do
          # タスクの新規作成画面を開く
          visit new_task_path
          # タスクの新規作成にアクセスできないことを検証する
          expect(page).to have_content 'Login required'
          # リダイレクト先のpathが正しいかを検証する
          expect(login_path).to eq current_path
        end
      end
    end

    describe 'タスクの編集ページ' do
      context '権限がない為' do
        it 'アクセスが失敗する' do
          # タスクの新規作成画面を開く
          visit edit_task_path(task)
          # タスクの新規作成にアクセスできないことを検証する
          expect(page).to have_content 'Login required'
          # リダイレクト先のpathが正しいかを検証する
          expect(login_path).to eq current_path
        end
      end
    end
  end

  describe 'ログイン後' do
    describe 'タスクの新規作成画面' do
      context '入力値が正常' do
        it 'タスクの新規作成ができる' do
          # userとして操作
          login(user)
          # タスクの新規作成画面を開く
          visit new_task_path
          # タスクの新規作成画面で入力をする
          fill_in 'task[title]', with: 'RUNTEQ応用課題16'
          fill_in 'task[content]', with: 'systen specを書く'
          select 'todo', from: 'Status'
          fill_in 'task[deadline]', with: Time.new(2020, 01, 02, 12)
          # Create Taskボタンをクリックする
          click_button('Create Task')
          # タスクの新規作成に成功したことを検証する
          expect(page).to have_content 'Task was successfully created.'
          expect(page).to have_content 'RUNTEQ応用課題16'
        end
      end
    end

    describe 'タスク編集画面' do
      context '入力値が正常' do
        it 'タスクの編集ができる' do
          # userとして操作
          login(user)
          # タスクの編集画面を開く
          visit edit_task_path(task)
          # タスクの編集画面で入力をする
          fill_in 'task[title]', with: 'RUNTEQ応用課題16'
          fill_in 'task[content]', with: 'タスクを編集する'
          select 'todo', from: 'Status'
          fill_in 'task[deadline]', with: Time.new(2040, 01, 02, 12)
          # Update Taskボタンをクリックする
          click_button('Update Task')
          # タスクの新規作成に成功したことを検証する
          expect(page).to have_content 'Task was successfully updated.'
        end
      end
      context '権限が無いため' do
        it '他のユーザーのタスク編集ページへアクセスが失敗する' do
          # userとして操作
          login(user)
          # 他のユーザーのタスク編集ページを開く
          visit edit_task_path(other_user_task)
          # 他のユーザーのタスク編集ページにアクセスが失敗したことを検証する
          expect(page).to have_content 'Forbidden access.'
          # リダイレクト先のpathが正しいかを検証する
          expect(root_path).to eq current_path
        end
      end
    end

    describe 'タスク一覧画面' do
      let!(:task) { create :task, user_id: user.id }
      context 'タスク一覧で Destroy のリンクをクリックすれば' do
        it 'タスクの削除ができる' do
          # userとして操作
          login(user)
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
  end
end
