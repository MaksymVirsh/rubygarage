angular.module('todo').directive 'ngEnter', ['$parse', ($parse) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'keydown', (event) ->
      if event.which is 13
        do event.preventDefault
        fn = $parse attrs.ngEnter
        scope.$apply( -> fn(scope, { $event: event }) ) unless scope.$$phase
        do element.focus

    element.bind 'blur', (event) ->
      if scope.editing
        fn = $parse attrs.ngEnter
        scope.$apply( -> fn(scope, { $event: event }) ) unless scope.$$phase
]
