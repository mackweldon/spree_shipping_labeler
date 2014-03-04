require 'spec_helper'

describe Spree::ShippingMethod do
  context "public instance methods" do
    describe ".fedex?" do
      it "should be true if the downcased name includes 'fedex'" do
        subject.stub(:name).and_return('123123fedex324')
        subject.fedex?.should be_true

        subject.stub(:name).and_return('FEDEX!!')
        subject.fedex?.should be_true
      end

      it "should not be true if the downcased name doesn't include 'fedex'" do
        subject.stub(:name).and_return('123123f')
        subject.fedex?.should be_false

        subject.stub(:name).and_return(nil)
        subject.fedex?.should be_false
      end
    end
  end
end
