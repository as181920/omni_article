OmniArticle::Engine.routes.draw do
  get "welcome/index"

  namespace :admin do
    resources :articles
  end

  namespace :user do
    resources :articles, param: :uid, only: %i[show]
  end

  get ":uid", to: "user/articles#show", as: :article

  root "welcome#index"
end
