angular.module('app').filter 'capitalize', ->
  (input, scope) ->
    input.substring(0,1).toUpperCase() + input.substring(1)
