Rails.application.routes.draw do
  resources :menu_links
  resources :menus

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :committees

    resources :posts do
      resources :comments, only: [:create, :update, :destroy]
    end

    get 'lunch/feed/' => 'lunch#feed'
    get 'feed' => 'posts#index', defaults: { format: :rss }, as: :feed

    get 'print' => 'print#new', as: :new_print
    post 'print' => 'print#print', as: :prints
    post 'print/pq' => 'print#pq', as: :pq_print

    resources :courses do
        member do
          get 'site'
        end
    end

    get '/' => 'home#index'
  end
  resources :pages
  resources :images, only: [:create, :destroy]

  get 'twitter/feed/:twitter_handle' => 'twitter#feed'

  match 'auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  get 'signout' => 'sessions#destroy', as: :signout

  root 'home#index'
end
