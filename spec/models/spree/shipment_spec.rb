require 'spec_helper'

describe Spree::Shipment do
  describe "decorations" do
    describe 'configuration' do
      context "associations" do
        it { should have_many(:packages) }
      end

      context "delegates" do
        let(:shipping_method) { double("shipping_method") }

        before { subject.stub(:shipping_method).and_return shipping_method }

        it { should accept_nested_attributes_for(:packages).allow_destroy(true) }

        it "should delegate :fedex? to :shipping_method" do
          shipping_method.should_receive :fedex?
          subject.fedex?
        end

      end
    end
  end
end
