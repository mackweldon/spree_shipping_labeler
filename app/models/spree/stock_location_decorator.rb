Spree::StockLocation.class_eval do
  def company
    "Working Title"
  end

  def fedex_formatted
    {
      company:       company,
      phone_number:  phone,
      address:       [address1, address2].compact.join(' '),
      city:          city,
      state:         state && state.abbr,
      postal_code:   zipcode,
      country_code:  country && country.iso,
      residential:   !company.blank?,
    }
  end
end
