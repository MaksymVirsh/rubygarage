app = angular.module('todo')

app.factory 'Project', ['$resource', ($resource) ->
  $resource '/projects/:id', { id: '@id' }, {
    update: { method: 'PATCH' }
  }
]

app.factory 'Task', ['$resource', ($resource) ->
  $resource '/tasks/:id/:action', { id: '@id' }, {
    update:   { method: 'PATCH' },
    done:     { params: { action: 'done' }, method: 'PUT' }
    sort:     { params: { action: 'sort' }, method: 'PUT' }
    deadline: { params: { action: 'deadline' }, method: 'PUT' }
  }
]

app.factory 'Comment', ['$resource', ($resource) ->
  $resource '/comments/:id', { id: '@id' }
]
