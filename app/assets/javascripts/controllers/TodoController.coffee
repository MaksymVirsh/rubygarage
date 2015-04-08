angular.module('todo').controller 'TodoController', ['$rootScope', '$scope'
    , 'Project', 'Task', ($rootScope, $scope, Project, Task) ->

  $scope.editing = no
  $scope.form = {}
  $scope.projects = Project.query()
  $scope.errors = []



  $scope.dragControlListeners =
    containerPositioning: 'relative'
    accept: (sourceItemHandleScope, destSortableScope) ->
      sourceItemHandleScope.itemScope.sortableScope.$id == destSortableScope.$id
    orderChanged: (event) ->
      id = event.source.itemScope.task.id
      position = event.dest.index

      Task.sort({ id: id }, { position: position })



  $scope.addProject = ->
    unless $scope.editing
      project = new Project
      project.editing = yes

      $scope.projects.push project
      $scope.editing = yes



  $scope.saveProject = (project, index)->
    form = $scope.form[index]

    if form.name.$valid
      if project.id
        Project.update({ id: project.id }, project).$promise.then (response) ->
          project.editing = no
          $scope.editing = no
        .catch (response) ->
          project.errors = response.data.errors.name
      else
        Project.save(project).$promise.then (response) ->
          project.id = response.id
          project.editing = no
          project.selected = yes
          $scope.editing = no
        .catch (response) ->
          project.errors = response.data.errors.name

      project.errors = []
    else
      unless project.id
        do $scope.projects.pop
        $scope.editing = no



  $scope.editProject = (project) ->
    $scope.editing = yes
    project.editing = yes



  $scope.deleteProject = (project) ->
    Project.remove({ id: project.id }).$promise.then ->
      _.remove($scope.projects, project)



  $scope.addTask = (project, index) ->
    form = $scope.form[index]

    if form.task_name.$dirty and form.task_name.$valid
      project.tasks = [] if not project.tasks

      task = new Task
      task.name = project.task_name
      task.project_id = project.id

      Task.save(task).$promise.then (response) ->
        project.tasks.push response
        project.task_name = ''
        task.errors = []
      .catch (response) ->
        task.errors = response.data.errors.name



  $scope.editTask = (task) ->
    $scope.editing = yes
    task.editing = yes



  $scope.saveTask = (task) ->
    if task.name
      Task.update({ id: task.id }, task).$promise.then (response) ->
        task.name = response.name
        $scope.editing = no
        task.editing = no
        task.errors = []
      .catch (response) ->
        task.errors = response.data.errors.name



  $scope.deleteTask = (task) ->
    Task.remove({ id: task.id }).$promise.then ->
      _($scope.projects).forEach (project) ->
        _.remove(project.tasks, task)


  $scope.taskDone = (task) ->
    Task.done({ id: task.id }, { done: task.done }).$promise.catch (resp) ->
      task.done = false

]
