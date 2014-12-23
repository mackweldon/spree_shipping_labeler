Spree::Core::Engine.routes.draw do
  namespace :api do
    resources :orders do
      resources :return_authorizations do
        member do
          post :print_label
        end
      end
    end
  end
end
