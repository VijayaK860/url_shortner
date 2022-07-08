Rails.application.routes.draw do
  root 'urls#index'
  resources :urls, except: :show
  get '/:slug', to: 'urls#show', as: :short
end
