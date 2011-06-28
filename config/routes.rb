SampleApp::Application.routes.draw do
  get "sessions/new"

    resources :users

    match '/contact', :to => 'pages#contact'
    match '/about', :to => 'pages#about'
    match '/help', :to => 'pages#help'
    match '/notitle', :to => 'pages#notitle'
    match '/signup', :to => 'users#new'

    root :to => 'pages#home'
end
