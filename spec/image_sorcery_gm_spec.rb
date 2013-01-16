require 'fileutils'
require 'image_sorcery'

describe "Image Sorcery with GraphicsMagick" do
  before :each do
    FileUtils.copy "./spec/fixtures/dog.jpeg", "./spec/fixtures/dog-2.jpeg"
    @image = ImageSorcery.gm("./spec/fixtures/dog-2.jpeg") # Who doesn't love dogs?
  end

  it_behaves_like ImageSorcery
end
