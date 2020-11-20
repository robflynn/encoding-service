Rails.application.routes.draw do
  resources :stores do
    collection do
      resources :stores, path: 'local', as: 'local_store', type: 'Store::LocalStore', controller: 'stores'
    end
  end
end
