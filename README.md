# Simple TODO List [![Build Status](https://travis-ci.org/timlar/rubygarage.svg?branch=master)](https://travis-ci.org/timlar/rubygarage) [![Coverage Status](https://coveralls.io/repos/timlar/rubygarage/badge.svg?branch=master)](https://coveralls.io/r/timlar/rubygarage?branch=master)

This is a test task for the RubyGarage.

Demo: https://timlar.herokuapp.com/

## Product requirements document

### Task manager

I'm a person who passionate about own productivity. I want to manage my tasks
and projects more effectively. I need simple tool that support me in
controlling my task-flow.

Functional requirements

- I want to be able to sign in/sign up by email/password or Facebook
- I want to be able to create/update/delete projects
- I want to be able to add tasks to my project
- I want to be able to update/delete tasks
- I want to be able to prioritise tasks into a project
- I want to be able to mark a task as 'done'
- I want to be able to choose deadline for my task
- I want to be able to add coments to my tasks
- I want to be able to delete coments
- I want to be able to attache files to coments

### Technical requirements

- It should be a WEB application
  - For the client side must be used: HTML5, CSS3, Twitter Bootstrap, JavaScript, AngularJS, jQuery.
  - For server side Ruby on Rails.
- It should have client side and server side validation.
- It should look like on screens (see attached file ‘rg_test_task_grid.png’).
- It should work like one page WEB application and should use AJAX technology, load and submit data without reloading a page.
- It should have user authentication solution and a user should only have access to their own projects and tasks (Devise, Cancancan gems).
- It should have automated tests for all functionality (models — RSpec, controllers — RSpec, acceptance/functional tests — RSpec + Capybara).
- It should use Carrierwave gem to manage uploaded files

