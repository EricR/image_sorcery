require 'fileutils'
require 'image_sorcery'

describe "Image Sorcery" do
  before :each do
    FileUtils.copy "./spec/fixtures/dog.jpeg", "./spec/fixtures/dog-2.jpeg"
    @image = Sorcery.gm("./spec/fixtures/dog-2.jpeg") # Who doesn't love dogs?
  end
  describe "getting the dimensions of an image" do
    it "returns a hash of dimensions" do
      @image.dimensions.should == {:x => "160", :y => "120"}
    end
  end
  describe "manipulating an image" do
    it "resizes an image" do
      original_dimensions = @image.dimensions
      @image.manipulate!(:resize => "50%")
      @image.dimensions.map {|k,v| v.to_i}.should == original_dimensions.map {|k,v| v.to_i/2}
    end
  end
  describe "converting an image" do
    it "writes the new image out to a file" do
      @image.convert("new_image.png")
      File.exists?("new_image.png").should be_true
    end
  end
  describe "identifying an image" do
    it "returns a list of layers" do
      @image.identify.should include "JPEG 160x120"
    end
  end
end
