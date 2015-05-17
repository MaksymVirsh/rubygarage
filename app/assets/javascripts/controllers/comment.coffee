angular.module('app').controller 'commentCtrl', [ '$scope', 'CommentResource'
    , ($scope, CommentResource) ->

  this.add = (task) ->
    if task.comment.length
      task.comments = [] if not task.comments

      comment = new CommentResource
      comment.text = task.comment
      comment.task_id = task.id

      CommentResource.save(comment).$promise.then (response) ->
        task.comments.push response
        task.comment = ''

  this.delete = (task, comment) ->
    CommentResource.remove({ id: comment.id }).$promise.then ->
      _.remove(task.comments, comment)

]
