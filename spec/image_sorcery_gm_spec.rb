require 'fileutils'
require 'image_sorcery'

describe "Image Sorcery with ImageMagick" do
  it_behaves_like ImageSorcery, "new"
end
