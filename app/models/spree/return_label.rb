module Spree
  class ReturnLabel < ActiveRecord::Base
    after_create :generate_label!

    belongs_to :return_authorization
    has_one :order, through: :return_authorization

    default_scope { order "created_at desc" }

    def show_tracking_number
      self.tracking_number || 'No tracking number available'
    end

    def generate_label!
      generated_label = addressor.generate_label!
      self.pdf_text        = generated_label[:label]
      self.tracking_number = generated_label[:tracking_number]
      save!
    end

    def addressor
      Spree::ReturnAddressor.new(self)
    end
  end
end
