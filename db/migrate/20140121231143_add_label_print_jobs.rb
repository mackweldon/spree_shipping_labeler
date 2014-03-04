class AddLabelPrintJobs < ActiveRecord::Migration
  def change
    create_table "label_print_jobs", :force => true do |t|
      t.string   "printer_name",    :null => false
      t.text     "label_plaintext", :null => false
      t.datetime "processed_at"
      t.datetime "created_at",      :null => false
      t.datetime "updated_at",      :null => false
    end

    add_index "label_print_jobs", ["processed_at"], :name => "idx_label_print_jobs_by_processed_at"
  end
end
