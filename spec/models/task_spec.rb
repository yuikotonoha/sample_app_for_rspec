require 'rails_helper'

RSpec.describe Task, type: :model do
  context "titleとstatusを指定しているとき" do
    it "タスクが作られる" do
      task = Task.new(title: "kotonoha", status: 0)
      expect(task).to be_valid
    end
  end

  context "titleを指定してない時" do
    it "エラーが表示" do
      task = Task.new(status: 0)
      task.valid?
      expect(task.errors.messages[:title]).to include "can't be blank"
    end
  end
end
