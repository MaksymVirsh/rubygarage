module AcceptanceHelpers
  def click_create_project
    find('.create-project').click
  end

  def project_name_field
    find('.project-name-field')
  end

  def new_task_name_field
    find('.create-task-name-field')
  end

  def task_name_field
    find('.task-name-field')
  end

  def task_status_checkbox
    find('input[name=status]')
  end

  def clear_project_name
    project_name_field.set('')
    project_name_field
  end

  def input_project_name(name = '')
    project_name_field.native.send_key(name, :Enter)
    wait_for_ajax
  end

  def hover_project
    all('.project-header').first.trigger(:mouseover)
  end

  def click_project_edit
    all('.edit-project').first.click
  end

  def click_project_delete
    find('.delete-project').click
    wait_for_ajax
  end

  def click_on_project
    find('.project-field h2').click
  end

  def input_task_name(name = '')
    new_task_name_field.native.send_key(name)
  end

  def clear_task_name
    task_name_field.set('')
    task_name_field
  end

  def edit_task_name(name = '')
    clear_task_name
    task_name_field.native.send_key(name)
  end

  def click_add_task_button
    find('.add-task').click
    wait_for_ajax
  end

  def press_enter_on_task_name
    new_task_name_field.native.send_key(:Enter)
    wait_for_ajax
  end

  def press_enter_on_editing_task_name
    task_name_field.native.send_key(:Enter)
    wait_for_ajax
  end

  def hover_task
    all('.task-name').first.trigger(:mouseover)
  end

  def click_task_edit
    find('.edit-task').click
  end

  def click_task_delete
    find('.delete-task').click
    wait_for_ajax
  end

  def click_on_task
    find('.task-name').click
  end
end
