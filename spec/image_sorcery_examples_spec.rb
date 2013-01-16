require 'fileutils'
require 'image_sorcery'

shared_examples_for ImageSorcery do |new_instance_method|
  subject(:image) do
    FileUtils.copy "./spec/fixtures/dog.jpeg", "./spec/fixtures/dog-2.jpeg"
    ImageSorcery.send(new_instance_method, "./spec/fixtures/dog-2.jpeg") # Who doesn't love dogs?
  end

  after :each do
    [
        "new_image.png",
        "./spec/fixtures/dog-2.jpeg",
        "./spec/fixtures/dog-2.png",
        "./spec/fixtures/pdf-sample-2.pdf",
        "./spec/fixtures/pdf-sample-2.png",
        "./spec/fixtures/pdf-sample-2-0.png",
        "./spec/fixtures/pdf-sample-2-1.png",
        "./spec/fixtures/pdf-sample-2.png.0",
        "./spec/fixtures/pdf-sample-2.png.1"
    ].each do |file|
      File.exists?(file) && File.delete(file)
    end
  end

  describe "getting the dimensions of an image" do
    it "returns a hash of dimensions" do
      image.dimensions.should == {:x => 160, :y => 120}
    end
  end

  describe "manipulating an image" do
    it "resizes an image" do
      original_dimensions = image.dimensions
      image.manipulate!(:resize => "50%")
      image.dimensions.map {|k,v| v.to_i}.should == original_dimensions.map {|k,v| v.to_i/2}
    end

    it "exposes width and height as integers" do
      image.width.should == 160
      image.height.should == 120
    end

    its(:filename_changed?) { should be_false }

    its(:file) { should eq "./spec/fixtures/dog-2.jpeg" }

    describe "change of format" do
      describe "with image" do
        before :each do
          image.manipulate!(:format => "png")
        end

        it "should delete original file" do
          File.exists?("./spec/fixtures/dog-2.jpeg").should be_false
        end

        it "should create file with new extension" do
          File.exists?("./spec/fixtures/dog-2.png").should be_true
        end

        its(:identify) { should include "PNG 160x120" }

        its(:filename_changed?) { should be_true }

        its(:file) { should eq "./spec/fixtures/dog-2.png" }
      end

      [nil, "0,1"].each do |layer|
        describe "with multi page pdf and :layer => '#{layer}'" do
          before :each do
            image.manipulate!(:format => "png", :layer => layer)
          end

          subject :image do
            FileUtils.copy "./spec/fixtures/pdf-sample.pdf", "./spec/fixtures/pdf-sample-2.pdf"
            ImageSorcery.send(new_instance_method, "./spec/fixtures/pdf-sample-2.pdf")
          end

          it "should delete original file" do
            File.exists?("./spec/fixtures/pdf-sample-2.pdf").should be_false
          end

          it "should create file with new extension" do

            case new_instance_method
              when "new"
                File.exists?("./spec/fixtures/pdf-sample-2-0.png").should be_true
                File.exists?("./spec/fixtures/pdf-sample-2-1.png").should be_true
              when "gm"
                # Inconsistent behaviour of GraphicsMagick
                case subject.file
                  when "./spec/fixtures/pdf-sample-2.png"   # GraphicsMagick 1.3.17 2012-10-13
                    File.exists?("./spec/fixtures/pdf-sample-2.png").should be_true
                  when "./spec/fixtures/pdf-sample-2.png.*" # GraphicsMagick 1.3.12 2010-03-08
                    File.exists?("./spec/fixtures/pdf-sample-2.png.0").should be_true
                    File.exists?("./spec/fixtures/pdf-sample-2.png.1").should be_true
                end
            end
          end

          its(:identify) { should include "PNG 595x842" }

          its(:filename_changed?) { should be_true }

          its(:file) { should eq "./spec/fixtures/pdf-sample-2-*.png" } if new_instance_method == "new"
          # Commented out, because of inconsistent behaviour of GraphicsMagick
          #its(:file) { should eq "./spec/fixtures/pdf-sample-2.png" } if new_instance_method == "gm"
          #its(:file) { should eq "./spec/fixtures/pdf-sample-2.png.*" } if new_instance_method == "gm"
        end
      end
    end
  end

  describe "converting an image" do
    it "writes the new image out to a file" do
      image.convert("new_image.png")
      File.exists?("new_image.png").should be_true
    end
  end

  describe "identifying an image" do
    it "returns a list of layers" do
      image.identify.should include "JPEG 160x120"
    end
  end

end
