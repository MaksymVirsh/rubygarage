# remove the url word '#_=_' after OmniAuth Facebook login.
if window.location.hash and window.location.hash == '#_=_'
  window.location.hash = ''
  history.pushState('', document.title, window.location.pathname)



################################################################################
#                                 Application                                  #
################################################################################

app = angular.module 'todo', ['angular-loading-bar', 'ui.sortable', 'elastic'
  , 'ngResource']

app.config ['$httpProvider', ($httpProvider) ->
  token = $('meta[name=csrf-token]').attr 'content'

  $httpProvider.defaults.headers.common['X-CSRF-Token'] = token
]

app.config ['cfpLoadingBarProvider', (cfpLoadingBarProvider) ->
  cfpLoadingBarProvider.includeSpinner = false
  cfpLoadingBarProvider.latencyThreshold = 500
]
