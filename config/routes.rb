Rails.application.routes.draw do
  resources :recurring_events
  resources :events
  root 'visitors#index'
  get '*path' => redirect('/404')
end
