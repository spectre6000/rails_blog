Rails.application.routes.draw do

  root                    'static_pages#home'
  get   'about'       =>  'static_pages#about'
  resources :authors

end