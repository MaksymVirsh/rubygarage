require 'acceptance_helper'

feature 'Unregistered user' do
  scenario 'can not create a project' do
    visit root_path

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Log in'
  end
end

feature 'Projects' do
  given(:user) { create(:user) }

  background do
    login_as_user user
    visit root_path
  end

  scenario 'presence of a button "add todo list"', js: true do
    expect(page).to have_css('.create-project')
  end

  scenario 'show the form for creating a new todo list', js: true do
    expect(page).to_not have_css('.project-form')
    click_create_project
    expect(page).to have_css('.project-form')
  end

  scenario 'create todo list', js: true do
    click_create_project
    expect(page).to_not have_css('.create-task-header')
    input_project_name 'Project 1'
    expect(page).to have_css('.project-field h2', text: 'Project 1')
    expect(page).to have_css('.create-task-header')
  end

  scenario 'create todo list with same name', js: true do
    click_create_project
    input_project_name 'Project 1'
    click_create_project
    input_project_name 'Project 1'
    expect(page).to have_css('.project-error', text: 'Name has already been taken')
  end

  scenario 'create todo list with empty name', js: true do
    click_create_project
    expect(page).to have_css('.project-form')
    input_project_name
    expect(page).to_not have_css('.project-form')
  end

  scenario 'remove focus from the name field of todo list', js: true do
    click_create_project
    expect(page).to have_css('.project-form')
    project_name_field.trigger(:blur)
    expect(page).to_not have_css('.project-form')
  end

  scenario 'show control buttons for todo list on mouse over', js: true do
    click_create_project
    hover_project
    expect(page).to_not have_css('.project-header .control')
    input_project_name 'Project 1'
    hover_project
    expect(page).to have_css('.project-header .control')
  end

  scenario 'delete a todo list', js: true do
    click_create_project
    input_project_name 'Project 1'
    hover_project
    click_project_delete
    expect(page).to_not have_css('.project-form')
  end

  scenario 'edit todo list', js: true do
    click_create_project
    input_project_name 'Project 1'
    hover_project
    click_project_edit
    expect(page).to_not have_css('.project-field h2')
    expect(page).to have_css('.project-field .project-name-field')
    input_project_name 'New project name'
    expect(page).to have_css('.project-field h2')
    expect(page).to_not have_css('.project-field .project-name-field')
  end

  scenario 'edit todo list with same name', js: true do
    click_create_project
    input_project_name 'Project 1'
    click_create_project
    input_project_name 'Project 2'
    hover_project
    click_project_edit
    clear_project_name
    input_project_name 'Project 2'
    expect(page).to have_css('.project-error', text: 'Name has already been taken')
  end

  scenario 'edit todo list with empty name', js: true do
    click_create_project
    input_project_name 'Project 1'
    hover_project
    click_project_edit
    expect(page).to_not have_css('.project-field h2')
    expect(page).to have_css('.project-field .project-name-field')
    clear_project_name
    expect(page).to_not have_css('.project-field h2')
    expect(page).to have_css('.project-field .project-name-field')
  end

  scenario 'cancel edit when the name field loses focus', js: true do
    click_create_project
    input_project_name 'Project 1'
    hover_project
    click_project_edit
    expect(page).to_not have_css('.project-field h2')
    expect(page).to have_css('.project-field .project-name-field')
    project_name_field.trigger(:blur)
    expect(page).to have_css('.project-field h2')
    expect(page).to_not have_css('.project-field .project-name-field')
  end

  scenario 'show the field for add the task', js: true do
    click_create_project
    expect(page).to_not have_css('.create-task-header')
    input_project_name 'Project 1'
    expect(page).to have_css('.create-task-header')
  end

  feature 'Tasks' do
    background do
      click_create_project
      input_project_name 'Project 1'
    end

    scenario 'add a task with empty name', js: true do
      expect(page).to have_css('.add-task[disabled]')
      input_task_name 'Task 1'
      expect(page).to_not have_css('.add-task[disabled]')
    end

    scenario 'add a task on press enter key', js: true do
      input_task_name 'Task 1'
      press_enter_on_task_name
      expect(page).to have_css('.task-name', text: 'Task 1')
    end

    scenario 'add a task on ckick button', js: true do
      input_task_name 'Task 1'
      click_add_task_button
      expect(page).to have_css('.task-name', text: 'Task 1')
      visit current_path
      click_on_project
      expect(page).to have_css('.task-name', text: 'Task 1')
    end

    scenario 'add a task with the same name', js: true do
      input_task_name 'Task 1'
      press_enter_on_task_name
      input_task_name 'Task 1'
      press_enter_on_task_name
      expect(page).to have_css('.task-name', text: 'Task 1', count: 1)
    end

    scenario 'show task control buttons on mouse over', js: true do
      input_task_name 'Task 1'
      press_enter_on_task_name
      expect(page).to_not have_css('.tasks .control')
      hover_task
      expect(page).to have_css('.tasks .control')
    end

    scenario 'edit task', js: true do
      input_task_name 'Task 1'
      press_enter_on_task_name
      hover_task
      click_task_edit
      expect(page).to_not have_css('.task-name .task-name-text')
      expect(page).to have_css('.task-name .task-name-field')
      input_task_name 'New task name'
      expect(page).to have_css('.task-name .task-name-text')
      expect(page).to_not have_css('.task-name .task-name-field')
    end

    scenario 'edit task with empty name', js: true do
      input_task_name 'Task 1'
      press_enter_on_task_name
      hover_task
      click_task_edit
      expect(page).to_not have_css('.task-name .task-name-text')
      expect(page).to have_css('.task-name .task-name-field')
      clear_task_name
      press_enter_on_task_name
      expect(page).to_not have_css('.task-name .task-name-text')
      expect(page).to have_css('.task-name .task-name-field')
    end

    scenario 'edit task with same name', js: true do
      input_task_name 'Task 1'
      click_add_task_button
      input_task_name 'Task 2'
      click_add_task_button
      hover_task
      click_task_edit
      edit_task_name 'Task 2'
      press_enter_on_editing_task_name
      expect(page).to have_css('.task-error')
    end

    scenario 'delete a task', js: true do
      input_task_name 'Task 1'
      press_enter_on_task_name
      hover_task
      click_task_delete
      expect(page).to_not have_css('.task-name')
    end

    scenario 'mark the task as done', js: true do
      input_task_name 'Task 1'
      press_enter_on_task_name
      task_status_checkbox.set(true)
      expect(page).to have_css('.task-name-text.task-done')
    end
  end
end
