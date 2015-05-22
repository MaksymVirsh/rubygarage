angular.module('app').controller 'projectCtrl', [ '$scope', 'ProjectResource'
    , ($scope, ProjectResource) ->

  $scope.editing = no

  this.projects = do ProjectResource.query

  this.create = ->
    unless $scope.editing
      project = new ProjectResource
      project.editing = yes

      $scope.editing = yes
      this.projects.push project

  this.cancel = (project) ->
    if project.id
      project.name = this.old_project_name
    else
      do this.projects.pop

    $scope.editing = no
    project.editing = no
    project.errors = []

  this.save = (project) ->
    if project.form.name.$valid
      if project.id
        ProjectResource.update({ id: project.id }, project).$promise.then (response) ->
          project.editing = no
          $scope.editing = no
        .catch (response) ->
          project.errors = response.data.errors.name
      else
        ProjectResource.save(project).$promise.then (response) ->
          project.id = response.id
          project.editing = no
          project.selected = yes
          $scope.editing = no
        .catch (response) ->
          project.errors = response.data.errors.name

      project.errors = []
    else
      unless project.id
        do this.projects.pop
        $scope.editing = no

  this.edit = (project) ->
    this.old_project_name = project.name
    $scope.editing = yes
    project.editing = yes

  this.delete = (project) ->
    projects = this.projects

    ProjectResource.remove({ id: project.id }).$promise.then ->
      _.remove(projects, project)

]
