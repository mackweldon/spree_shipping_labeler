class AddLabelPrinterNameToUser < ActiveRecord::Migration
  def change
    add_column :spree_users, :label_printer_name, :string
  end
end
