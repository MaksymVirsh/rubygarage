angular.module('todo').filter 'capitalize', ->
  (input, scope) ->
    input.substring(0,1).toUpperCase() + input.substring(1)
