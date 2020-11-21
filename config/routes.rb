Rails.application.routes.draw do
  scope :api do
    resources :assets, path: 'assets'

    resources :stores do
      collection do

        Store.subclasses.map(&:name).each do |store_class|
          store_class_suffix = store_class.split("::")[1..].join("::").underscore
          store_type = store_class_suffix.split('_')[0...-1].join('_')
          resources :stores, path: store_type, as: store_class_suffix, type: store_class, controller: 'stores'
        end
      end
    end

    # Tasks
    resources :encoding_tasks, path: 'tasks/encodes', as: 'encoding'
  end
end
