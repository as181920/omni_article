OmniArticle::Engine.routes.draw do
  get "welcome/index"
  get "api-docs", to: "api_docs#index", as: :api_docs
  get "api-docs/openapi.json", to: "api_docs#openapi", as: :openapi_spec
  get "api-docs/openapi/*path", to: "api_docs#openapi_file", as: :openapi_spec_file, format: false

  namespace :admin do
    resources :articles do
      scope module: :articles do
        resource :entry, only: %i[show]
      end
    end
  end

  namespace :user do
    concern :article_container do
      resources :articles, param: :uid, only: %i[index show], controller: "owner_articles"
    end

    resources :tenants, param: :uid, only: [], concerns: :article_container
    resources :organizations, param: :uid, only: [], concerns: :article_container
    resources :articles, param: :uid, only: %i[show]
  end

  get ":uid", to: "user/articles#show", as: :article

  root "welcome#index"
end
