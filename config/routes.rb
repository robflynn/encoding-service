Rails.application.routes.draw do
  scope :api do
    resources :assets, path: 'assets'

    resources :stores do
      collection do
        resources :stores, path: 'local', as: 'local_store', type: 'Store::LocalStore', controller: 'stores'
      end
    end

    # Tasks
    resources :encoding_tasks, path: 'tasks/encodes', as: 'encoding'
  end
end
