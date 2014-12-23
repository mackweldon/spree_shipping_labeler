Spree::Api::ReturnAuthorizationsController.class_eval do
  def print_label
    @return_authorization = Spree::ReturnAuthorization.find(params[:id])
  end
end
