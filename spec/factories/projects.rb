FactoryGirl.define do
  sequence :project_name do |n|
    "Project #{n}"
  end

  factory :project do
    name { generate :project_name }
  end

  factory :invalid_project, class: 'Project' do
    name nil
  end
end
