# Route prefixes use a single letter to allow for vanity urls of two or more characters
Rails.application.routes.draw do
  # Email receiver
  mount_griddler
  get "/email_processor", to: proc { [200, {}, ["OK"]] }, as: "mandrill_head_test_request"

  get 'n/:id',  to: 'newsletters#show', as: :newsletter
  get 'n/',     to: 'newsletters#index', as: :newsletters
  resources :newsletters
  get 't/:tag', to: 'newsletters#index', as: :tag
  get 'e/:id',  to: 'emails#show', as: :email
  get 'e/',     to: 'emails#index', as: :emails

  resources :curations

  # Charts
  get 'charts/emails_sent_by_day', to: 'charts#emails_sent_by_day', as: :emails_sent_by_day_chart

  if defined? Sidekiq
    require 'sidekiq/web'
    authenticate :user, lambda {|u| u.is_admin? } do
      mount Sidekiq::Web, at: '/admin/sidekiq/jobs', as: :sidekiq
    end
  end

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin' if defined? RailsAdmin

  # Static pages
  match '/error' => 'pages#error', via: [:get, :post], as: 'error_page'
  get '/terms' => 'pages#terms', as: 'terms'
  get '/privacy' => 'pages#privacy', as: 'privacy'
  get '/about' => 'pages#about', as: 'about'
  get '/status' => 'pages#status', as: 'status'
  get '/contact' => 'pages#contact', as: 'contact'

  # OAuth
  oauth_prefix = Rails.application.config.auth.omniauth.path_prefix
  get "#{oauth_prefix}/:provider/callback" => 'users/oauth#create'
  get "#{oauth_prefix}/failure" => 'users/oauth#failure'
  get "#{oauth_prefix}/:provider" => 'users/oauth#passthru', as: 'provider_auth'
  get oauth_prefix => redirect("#{oauth_prefix}/login")

  # Devise
  devise_prefix = Rails.application.config.auth.devise.path_prefix
  devise_for :users, path: devise_prefix,
    controllers: {registrations: 'users/registrations', sessions: 'users/sessions',
      passwords: 'users/passwords', confirmations: 'users/confirmations', unlocks: 'users/unlocks'},
    path_names: {sign_up: 'signup', sign_in: 'login', sign_out: 'logout'}
  devise_scope :user do
    get "#{devise_prefix}/after" => 'users/registrations#after_auth', as: 'user_root'
  end
  get devise_prefix => redirect('/a/signup')

  # User
  resources :users, path: 'u', only: :show do
    resources :authentications, path: 'accounts'
  end
  get '/home' => 'users#show', as: 'user_home'
  get '/import'         => 'importer#index', as: 'importer'
  post '/import'        => 'importer#import', as: 'importing'

  # Dummy preview pages for testing.
  get '/p/test' => 'pages#test', as: 'test'
  get '/p/email' => 'pages#email' if ENV['ALLOW_EMAIL_PREVIEW'].present?

  get 'robots.:format' => 'robots#index'
  get "sitemap.xml.gz" => "sitemaps#sitemap", format: :xml, as: :sitemap
  get "sitemap1.xml.gz" => "sitemaps#sitemap", format: :xml, as: :sitemap1
  get "sitemap2.xml.gz" => "sitemaps#sitemap", format: :xml, as: :sitemap2
  get "sitemap3.xml.gz" => "sitemaps#sitemap", format: :xml, as: :sitemap3
  get "sitemap4.xml.gz" => "sitemaps#sitemap", format: :xml, as: :sitemap4
  get "sitemap5.xml.gz" => "sitemaps#sitemap", format: :xml, as: :sitemap5

  root 'pages#home'
end
