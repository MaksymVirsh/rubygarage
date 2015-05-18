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
      uploaded_count = 0
      $scope.uploading = yes

      for file, index in files
        Upload.upload
          url: '/attachments'
          file: file
        .success (data, status, headers, config) ->
          $scope.attachments.push
            id: data.id
            file:
              name: data.file.name
              url: data.file.url
              size: data.file.size

          uploaded_count++
          $scope.uploading = no if uploaded_count == files.length

  this.removeAttachment = (attachment) ->
    _.remove($scope.attachments, attachment)

]
