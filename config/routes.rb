Spree::Core::Engine.routes.draw do
  namespace :api do
    resources :orders do
      resources :return_authorizations do
        member do
          post :generate_return_label, to: 'shipping_labels#generate_return_label'
        end
      end
    end
  end
end
