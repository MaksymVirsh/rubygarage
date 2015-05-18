angular.module('app').controller 'commentCtrl', [ '$scope', 'CommentResource'
    , 'Upload', ($scope, CommentResource, Upload) ->

  this.add = (task) ->
    if task.comment.length
      task.comments = [] if not task.comments

      comment = new CommentResource
      comment.text = task.comment
      comment.task_id = task.id
      comment.attachments = _.map($scope.attachments, (file) -> file.id)

      CommentResource.save(comment).$promise.then (response) ->
        response.attachments = $scope.attachments
        task.comments.push response
        task.comment = ''
        $scope.attachments = []

  this.delete = (task, comment) ->
    CommentResource.remove({ id: comment.id }).$promise.then ->
      _.remove(task.comments, comment)

  $scope.attachments = []

  $scope.upload = (files)->
    if files and files.length
      for file, index in files
        Upload.upload
          url: '/attachments'
          file: file
        .progress (event) ->
          progressPercentage = parseInt(100.0 * event.loaded / event.total)
        .success (data, status, headers, config) ->
          $scope.attachments.push {
            id: data.id
            file:
              name: config.file.name
              url: data.file.url
          }

]
