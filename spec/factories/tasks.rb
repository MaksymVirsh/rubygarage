FactoryGirl.define do
  sequence :task_name do |n|
    "Task #{n}"
  end

  factory :task do
    done false
    name { generate :task_name }
  end

  factory :invalid_task, class: 'Task' do
    name nil
  end

  factory :task_done, class: 'Task' do
    done true
  end
end
