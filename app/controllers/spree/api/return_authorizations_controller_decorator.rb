Spree::Api::ReturnAuthorizationsController.class_eval do
  def print_label
    @return_authorization = order.return_authorizations.find(params[:id])
    binding.pry
  end
end
