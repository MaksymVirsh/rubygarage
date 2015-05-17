angular.module('app').directive 'hoverable', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    watcher = (watchScope) ->
      scope.editing

    scope.$watch watcher, (editing) ->
      element.removeClass 'hovered'

      if editing
        element.unbind 'mouseenter'
      else
        element.bind 'mouseenter', ->
          element.addClass 'hovered'
        .bind 'mouseleave', ->
          element.removeClass 'hovered'
