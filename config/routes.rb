Rails.application.routes.draw do
  root 'pages#index'

  # Course related routes
  get 'courses/:id' => 'courses#view'
  get 'courses/:id/sections' => 'sections#index'

  # Instructor related routes
  get 'instructors/:id' => 'instructors#view'
  get 'instructors/:id/courses' => 'instructors#courses'
end
