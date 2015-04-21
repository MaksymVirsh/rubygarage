# Usage:
#
# Add attributes:
#   ng-confirm-message='Are you sure?'
#   ng-confirm-click='action()'

angular.module('todo').directive 'ngConfirmClick', [ ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'click', ->
      message = attrs.ngConfirmMessage
      scope.$apply(attrs.ngConfirmClick) if message && confirm(message)
]
