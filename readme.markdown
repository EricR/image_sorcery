Image Sorcery allows you to leverage all three of ImageMagick's command line tools, [mogrify](http://www.imagemagick.org/script/mogrify.php), [convert](http://www.imagemagick.org/script/convert.php), and [identify](http://www.imagemagick.org/script/identify.php), for maximum magickal power and minimum memory consumption!

## Installation

    gem install image_sorcery

## Code Examples
```ruby
image = Sorcery.new("image.png")
image.identify # => "image.png PNG 500x500 500x500+0+0 8-bit DirectClass 236KB 0.010u 0:00.010\n"
image.manipulate!(scale: "50%") # => true
image.dimensions #=> { x: 250, y: 250 }
image.convert("thumbnail.jpg", quality: 80, crop: "100x100>") # => true
```

## Todo

Unit tests coming soon! And a few new convenience methods (like "dimensions").