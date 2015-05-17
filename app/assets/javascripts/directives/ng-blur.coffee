angular.module('app').directive 'ngBlur', ['$parse', ($parse) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'blur', (event) ->
      enter_key_code = 13

      if scope.editing and event.which is not enter_key_code
        fn = $parse attrs.ngBlur
        scope.$apply( -> fn(scope, { $event: event }) )
]
