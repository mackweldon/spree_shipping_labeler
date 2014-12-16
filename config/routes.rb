Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :orders do
      resource :shipment, :controller => "orders/shipments", :only => [:update, :edit, :show, :print] do
        member do
          post :print
          post :print_product_labels
        end
      end
    end
  end
end
