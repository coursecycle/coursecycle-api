Rails.application.routes.draw do
  root 'pages#index'

  # Course related routes
  get 'courses/:id' => 'courses#view'
  get 'courses/:id/instructors' => 'courses#instructors'
  get 'courses/:id/sections' => 'courses#sections'
  post 'courses/search' => 'courses#search'

  # Instructor related routes
  get 'instructors/:id' => 'instructors#view'
  get 'instructors/:id/courses' => 'instructors#courses'
end
