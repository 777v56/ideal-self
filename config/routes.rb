Rails.application.routes.draw do

 devise_for :users, skip: [:passwords], controllers:{
    registrations: "user/registrations",
    sessions: 'user/sessions'
 }
 devise_for :admin, skip: [:passwords], controllers:{
    sessions: "admin/sessions"
 }

 namespace :admin do
  root to: "homes#top"
   resources :users, only: [:index,:show,:edit,:update]
   resources :mutters, only: [:index,:show,:update]
 end

 scope module: :user do
  root to: "homes#top"
  resources :mutters, only: [:index,:show,:edit,:create,:destroy,:update] do
  resource :favorites, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update,:destroy]
   resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
 end

end