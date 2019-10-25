FactoryBot.define do
  factory :task do
    title { 'RSpecの課題' }
    content { 'RSpecかきます' }
    status { 0 }
  end
end
