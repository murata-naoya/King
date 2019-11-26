Rails.application.routes.draw do
  #user routing
  get 'orders/index'
  get 'order_items/index'
  get 'products/index'
  get 'products/show'
  get "/carts" => "carts#index", as:"carts"
  get "/orders/final" => "order_items#final", as:"order_final"
  get 'orders/done' => "orders#done", as:"order_done"
  get 'users/revive' => 'users#revive_page', as:'revive_page'
  post 'revive' => "users#revive", as:"revive"
  patch "/carts/:id/change" => "carts#change", as:"cart_change"
  root 'users#top'
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  resources :users, only:[:show, :edit, :update, :destroy]
  resources :products, only:[:show, :index] do
    resources :carts, only:[:create, :destroy, :update]
    collection{ get "search" }
  end
  resources :order_items, only:[:index, :create]
  resources :destinations, only:[:create, :update]
  resources :reviews
  resources :orders, only:[:create, :index, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #admin routing
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  namespace :admin do
    resources :users
    resources :products
    resources :artists, only:[:new, :index, :create, :edit, :update, :destroy]
    resources :genres, only:[:new, :index, :create, :edit, :update, :destroy]
    resources :labels, only:[:new, :index, :create, :edit, :update, :destroy]
    resources :arrivals, only:[:new, :create, :index]
    resources :orders, only:[:index, :update, :show]
    get 'reviews/new'
    get 'reviews/edit'
    get 'reviews/_index'
    get 'receive' => 'orders#receive', as:'orders_receive'
    get 'done' => 'orders#done', as:'orders_done'
  end
end
