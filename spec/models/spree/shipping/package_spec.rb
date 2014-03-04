require 'spec_helper'

describe Spree::Shipping::Package do
  context "database fields" do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:shipment_id).of_type(:integer) }
    it { should have_db_column(:shipping_method_id).of_type(:integer) }
    it { should have_db_column(:box_id).of_type(:integer) }
    it { should have_db_column(:tracking_number).of_type(:string) }
  end

  context "database indexes" do
    it { should have_db_index(:shipment_id).unique(false) }
  end

  context "configuration" do
    describe "associations" do
      it { should belong_to(:shipment) }
      it { should belong_to(:box) }
      it { should have_one(:order).through(:shipment) }
    end

    describe "validations" do
      it { should    validate_presence_of :box_id }
      it { should    validate_presence_of :shipping_method_id }
      it { should    validate_presence_of :weight }
      it { should    validate_numericality_of(:weight) }
    end
  end

  context "public instance methods" do
    let(:shipment) { double("shipment").as_null_object }
    let(:shipping_method) { double("shipping method").as_null_object }
    let(:order)    { double("order") }
    let(:box)      { double("box") }

    before { subject.stub(:shipment).and_return(shipment) }
    before { subject.stub(:shipping_method).and_return(shipping_method) }
    before { subject.stub(:order).and_return(order) }
    before { subject.stub(:box).and_return(box) }

    context "delegates" do
      it "should delegate :fedex? to :shipping_method" do
        shipping_method.should_receive :fedex?
        subject.fedex?
      end

      %i[length width height].each do |dimension|
        it "should delegate :#{dimension} to :box" do
          box.should_receive  dimension
          subject.send        dimension
        end
      end
    end

    describe ".destination" do
      after { subject.destination }

      context "shipment has an address" do
        before { shipment.stub(:address).and_return(Object.new) }

        it "should return the shipment address" do 
          shipment.should_receive(:address)
        end
      end

      context "shipment has no address" do
        before { shipment.stub(:address).and_return(nil) }

        it "should try the order :ship_address as a fallback" do
          order.should_receive(:ship_address)
        end
      end
    end

    describe ".origin" do
      after { subject.origin }

      it "should return the shipment's stock location" do
        shipment.should_recive :stock_location
      end
    end

    describe ".weight_in_ounces" do
      context "package has a :weight greater than zero" do
        let(:weight) { rand(1..1000) / 10.0 }
        before { subject.stub(:weight).and_return weight }

        it "should return :weight * 16.0 rounded up to the nearest 10th" do
          raw = weight * 16.0
          rounded_up_nearest_tenth = (raw * 10).ceil / 10.0
          subject.weight_in_ounces.should == (rounded_up_nearest_tenth)
        end
      end
    end

    describe ".print_label!" do
      let(:printer_name) { Faker::Company.bs }
      let(:zpl_text)     { Faker::Company.bs }
      let(:raw_printer)  { double("raw printer").as_null_object }

      before { subject.stub :save! }
      before { Utilities::RawPrinter.stub(:new) { raw_printer } }
      before { subject.stub(:label_zpl).and_return zpl_text }

      after  { subject.print_label!(printer_name: printer_name) }

      it "should call :generate_label!" do
        subject.should_receive(:generate_label!)
      end

      it "should create a new print job with the appropriate label text and printer name" do
        raw_printer.should_receive(:print).with(zpl_text)
      end
    end
  end
end
