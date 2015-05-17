angular.module('app').directive 'escapable', ['$parse', ($parse) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'keyup', (event) ->
      esc_key_code = 27

      if event.which is esc_key_code
        fn = $parse attrs.ngEnter
        scope.editing
        scope.$apply( -> fn(scope, { $event: event }) ) unless scope.$$phase

]
