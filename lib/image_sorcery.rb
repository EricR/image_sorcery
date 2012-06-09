require 'subexec'

class Sorcery
  def initialize(file)
    @file = file
  end

  # Runs ImageMagick's 'mogrify'.
  # See http://www.imagemagick.org/script/mogrify.php
  #
 def manipulate!(args={})
    tokens  = ["mogrify"]
    tokens << convert_to_arguments(args) if args
    tokens << " '#{@file}#{"[#{args[:layer].to_s}]" if args[:layer]}'"
    tokens  = convert_to_command(tokens)
    success = run(tokens)[1]
    success
  end

  # Runs ImageMagick's 'convert'.
  # See http://www.imagemagick.org/script/convert.php
  #
  def convert(output, args={})
    tokens  = ["convert"]
    tokens << convert_to_arguments(args) if args
    tokens << " '#{@file}#{"[#{args[:layer].to_s}]" if args[:layer]}'"
    tokens << " #{output}"
    tokens  = convert_to_command(tokens)
    success = run(tokens)[1]
    success
  end

  # Runs ImageMagick's 'identify'.
  # See http://www.imagemagick.org/script/identify.php
  #
  def identify(args={})
    tokens = ["identify"]
    tokens << convert_to_arguments(args) if args
    tokens << " '#{@file}#{"[#{args[:layer].to_s}]" if args[:layer]}'"
    tokens  = convert_to_command(tokens)
    output  = run(tokens)[0]
    output
  end

  # Return the x and y dimensions of an image as a hash.
  #
  def dimensions
    dimensions = identify(layer: 0, format: "%wx%h").chomp.split("x")
    { x: dimensions[0],
      y: dimensions[1] }
  end

  private

  def convert_to_command(tokens)
    tokens.flatten.join("")
  end

  def convert_to_arguments(args)
    args.reject {|k, v| k == :layer }.map {|k, v| " -#{k} '#{v}'"}
  end

  def run(cmds)
    sub = Subexec.run(cmds.to_s)
    success = sub.exitstatus == 0 ? true : false
    [sub.output,success]
  end
end