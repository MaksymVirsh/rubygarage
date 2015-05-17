angular.module('app').directive 'ngEnter', ['$parse', ($parse) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'keydown', (event) ->
      enter_key_code = 13

      if event.which is enter_key_code
        do event.preventDefault
        fn = $parse attrs.ngEnter
        scope.$apply( -> fn(scope, { $event: event }) )
        do element.focus
]
