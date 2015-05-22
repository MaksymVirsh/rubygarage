angular.module('app').controller 'taskCtrl', [ '$scope', 'TaskResource'
    , ($scope, TaskResource) ->

  this.dragControlListeners =
    containerPositioning: 'relative'
    accept: (sourceItemHandleScope, destSortableScope) ->
      sourceItemHandleScope.itemScope.sortableScope.$id == destSortableScope.$id
    orderChanged: (event) ->
      id = event.source.itemScope.task.id
      position = event.dest.index

      TaskResource.sort({ id: id }, { position: position })

  this.add = (project) ->
    form = project.task_form

    if form.task_name.$dirty and form.task_name.$valid
      project.tasks = [] if not project.tasks

      task = new TaskResource
      task.name = project.task_name
      task.project_id = project.id

      TaskResource.save(task).$promise.then (response) ->
        project.tasks.push response
        project.task_name = ''
        task.errors = []
      .catch (response) ->
        task.errors = response.data.errors.name

  this.edit = (task) ->
    this.old_task_name = task.name
    $scope.editing = yes
    task.editing = yes

  this.cancel = (task) ->
    task.name = this.old_task_name if task.id

    $scope.editing = no
    task.editing = no

  this.save = (task) ->
    if task.name
      TaskResource.update({ id: task.id }, task).$promise.then (response) ->
        task.name = response.name
        task.editing = no
        task.errors = []

        $scope.editing = no
      .catch (response) ->
        task.errors = response.data.errors.name

  this.setDone = (task) ->
    TaskResource.done({ id: task.id }, { done: task.done }).$promise.catch (response) ->
      task.done = false

  this.delete = (task) ->
    TaskResource.remove({ id: task.id }).$promise.then ->
      _.remove($scope.project.tasks, task)

  this.onNameClick = (task) ->
    task.active = !task.active

    _($scope.$parent.projectCtrl.projects).forEach (project) ->
      _.map project.tasks, (item) ->
        item.active = no if item.id != task.id

  this.setDeadline = (task, date) ->
    TaskResource.deadline({ id: task.id }, { deadline: date }).$promise.then (response) ->
      task.deadline = response.deadline
    .catch (response) ->
      task.deadline = null

]
