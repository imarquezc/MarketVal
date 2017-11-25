Rails.application.routes.draw do
  resources :products, defaults: { format: 'json' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :images, defaults: { format: 'json' }

end
