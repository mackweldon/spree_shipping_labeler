require 'spec_helper'

describe Spree::Order do

  describe "configuration" do
    describe "associations" do
      it { should have_many(:packages).through(:shipments) }
    end
  end
end
