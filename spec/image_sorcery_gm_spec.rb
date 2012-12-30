require 'fileutils'
require 'image_sorcery'

describe "Image Sorcery with GraphicsMagick" do
  it_behaves_like Sorcery, "gm"
end
