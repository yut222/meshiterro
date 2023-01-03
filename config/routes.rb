Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"
  
  get 'postimages/new'
  get 'postimages/index'
  get 'postimages/show'

  get 'homes/about' => 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end