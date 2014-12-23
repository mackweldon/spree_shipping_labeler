module Spree
  class ReturnLabel < ActiveRecord::Base
    default_scope { order "created_at desc" }

    after_create :generate_label!

    def show_tracking_number
      self.tracking_number || 'No tracking number available'
    end

    def pdf_link
      'http://fakelabel'
    end

    def generate_label!
    end
  end
end
