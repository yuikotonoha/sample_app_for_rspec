module TaskMacros
  def task_create
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