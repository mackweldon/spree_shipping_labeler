class AddShipmentPackages < ActiveRecord::Migration
  def change
    create_table "spree_shipping_packages", :force => true do |t|
      t.integer  "shipment_id"
      t.integer  "box_id"
      t.decimal  "weight",             :precision => 8, :scale => 2
      t.datetime "created_at",                                       :null => false
      t.datetime "updated_at",                                       :null => false
      t.text     "label_zpl"
      t.string   "tracking_number"
      t.integer  "shipping_method_id"
    end

    add_index :spree_shipping_packages, [:shipment_id], name: :idx_spree_shipping_packages_on_shipment
  end
end
