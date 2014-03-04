module Spree
  module Admin
    module Orders
      class ShipmentsController < Spree::Admin::BaseController
        expose(:order)    { @order }

        before_filter :load_ivars

        rescue_from Utilities::LabelError do |err|
          render json: { error: "Error:\n< #{err.message} >" }, status: 422
        end

        def edit
        end

        def update
          unless @shipment.update_attributes(shipment_params)
            flash[:error] = @shipment.errors.full_messages.join(" ")
          end

          redirect_to edit_admin_order_shipments_url
        end

        def print
          unless @package.persisted?
            return render(
              status: 200,
              json:   { errors: [Spree.t(:cannot_print_unsaved_label)] })
          end

          printer_name = spree_current_user.label_printer_name

          @package.print_label!(printer_name: printer_name)
          render status: 200,
            json: { tracking_code: @package.tracking_number }
        end

        def print_product_labels
          labels = @order.line_items.map(&:generate_variant_label!)
          render json: labels
        end

        private
        def load_ivars
          @order    = Order.find_by_number!(params[:order_id], :include => :adjustments)
          @shipment = @order.shipments.find_by_number(params[:shipment_number])
          @package  = @order.packages.find_by_id(params[:package_id])
        end

        def shipment_params
          params.require(:shipment).permit(
            packages_attributes: [:shipping_method_id, :box_id, :weight, :_destroy, :id])
        end
      end
    end
  end
end
