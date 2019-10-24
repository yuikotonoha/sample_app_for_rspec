require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { build(:task, title: title, status: status) }
  context 'titleが空の時に' do
    let(:status) { 1 }
    let(:title) { }
    it 'エラーになる' do
      expect(task).not_to be_valid
      expect(task.errors.messages[:title]).to include "can't be blank"
    end
  end

  context 'statusが空の時に' do
    let(:status) { }
    let(:title) { 'ことのはのタスクタイトル' }
    it 'エラーになる' do
      expect(task).not_to be_valid
      expect(task.errors.messages[:status]).to include "can't be blank"
    end
  end

  context 'titleが重複した時に' do
    let(:title) { 'ことのはのタスクタイトル' }
    let(:status) { 1 }
    it 'エラーになる' do
      Task.create!(title: title, status: 0)
      expect(task).not_to be_valid
      expect(task.errors.messages[:title]).to include "has already been taken"
    end
  end
end