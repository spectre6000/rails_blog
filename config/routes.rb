Rails.application.routes.draw do

  root                        'static_pages#home'
  get     'about'         =>  'static_pages#about'
  get     'author_login'  =>  'author_sessions#new'
  post    'author_login'  =>  'author_sessions#create'
  delete  'author_logout' =>  'author_sessions#destroy'
  resources :authors

end