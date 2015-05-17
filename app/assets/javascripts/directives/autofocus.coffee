angular.module('app').directive 'autoFocus', ['$timeout', ($timeout) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    scope.$watch attrs.ngShow, () ->
      $timeout -> do element[0].focus
]
