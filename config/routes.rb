Rails.application.routes.draw do

 devise_for :users, skip: [:passwords], controllers:{
  registrations: "user/registrations",
  sessions: 'user/sessions'
 }
 devise_for :admin, skip: [:passwords], controllers:{
  sessions: "admin/sessions"
 }

 devise_scope :user do
  post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
 end

 namespace :admin do
  root to: "mutters#index"
  get "search" => "searches#search"
  resources :mutters, only: [:index,:destroy]
 end

 scope module: :user do
  root to: "homes#top"
  get "search" => "searches#search"
  get "mutters/timeline"
  resources :records, only: [:show,:edit,:create,:destroy,:update]
  resources :mutters, only: [:index,:show,:edit,:create,:destroy,:update] do
   resource :favorites, only: [:create, :destroy]
   resources :comments, only: [:create, :destroy]
  end
  resources :favorites, only: [:show]
  resources :users do
   resource :relationships, only: [:create, :destroy]
   get 'followings' => 'relationships#followings', as: 'followings'
   get 'followers' => 'relationships#followers', as: 'followers'
  end
 end

end