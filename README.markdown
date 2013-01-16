Image Sorcery allows you to leverage all three of ImageMagick's command line tools, [mogrify](http://www.imagemagick.org/script/mogrify.php), [convert](http://www.imagemagick.org/script/convert.php), and [identify](http://www.imagemagick.org/script/identify.php), for maximum magickal power and minimum memory consumption! It even lets you use GraphicsMagick, too, if that's your thing.

## Why?

At [Fol.io](http://fol.io), we needed server-side image processing to work well and bend to our will. I wrote this because the ImageMagick libraries we tried suffered from at least one of two problems:

* Large memory consumption/leaking
* Didn't expose the entire ImageMagick API

ImageSorcery doesn't try to be anything more than a wrapper that exposes the full ImageMagick and GraphicsMagick APIs. This makes it small and powerful, eliminating the above problems.

## Installation

    gem install image_sorcery

## Code Examples
```ruby
image = ImageSorcery.new("image.png")
image.identify # => "image.png PNG 500x500 500x500+0+0 8-bit DirectClass 236KB 0.010u 0:00.010\n"
image.manipulate!(scale: "50%") # => true
image.dimensions # => { x: 250, y: 250 }
image.convert("thumbnail.jpg", quality: 80, crop: "100x100>") # => true
```

```ruby
image = ImageSorcery.new("multi-page.pdf")
image.filename_changed? # => false
image.manipulate!(format: "png", layer: 0) # => true
image.filename_changed? # => true
image.file # => "multi-page.png"
```

```ruby
image = ImageSorcery.new("multi-page.pdf")
image.manipulate!(format: "png") # => true
image.filename_changed? # => true

# on ImageMagick it returns all layers as a single file
image.file # => "multi-page-*.png"

# on GrapicksMagick it returns only the fist layer
image.file # => "multi-page.png"
```

# Using GraphicsMagick
Assuming you have GraphicsMagick installed on your box:

```ruby
image = ImageSorcery.gm("image.png")
# use as normal
```

## Todo

* Some more unit tests
* A few more convenience methods (like "dimensions").
