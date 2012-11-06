Image Sorcery allows you to leverage all three of ImageMagick's command line tools, [mogrify](http://www.imagemagick.org/script/mogrify.php), [convert](http://www.imagemagick.org/script/convert.php), and [identify](http://www.imagemagick.org/script/identify.php), for maximum magickal power and minimum memory consumption! It lets you use GraphicsMagick if that's you're thing, too.

## Why?

At [Fol.io](http://fol.io), we need server-side image processing to work well and bend to our will. I wrote this because the ImageMagick libraries we tried suffered from at least one of two problems:

* Large memory consumption/leaking
* Didn't expose the entire ImageMagick library

Due to the way Image Sorcery was written, it manages to avoid both of these problems.

## Installation

    gem install image_sorcery

## Code Examples
```ruby
image = Sorcery.new("image.png")
image.identify # => "image.png PNG 500x500 500x500+0+0 8-bit DirectClass 236KB 0.010u 0:00.010\n"
image.manipulate!(scale: "50%") # => true
image.dimensions # => { x: 250, y: 250 }
image.convert("thumbnail.jpg", quality: 80, crop: "100x100>") # => true
```
# Using GraphicsMagick
Assuming you have GraphicsMagick installed on your box:

```ruby
image = Sorcery.gm("image.png")
# use as normal
```

## Todo

* Some more unit tests
* A few more convenience methods (like "dimensions").
