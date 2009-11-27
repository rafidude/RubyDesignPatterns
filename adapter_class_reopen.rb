class TextObject
  attr_reader :text, :size_inches, :color
  def initialize(text, size_inches, color)
    @text = text
    @size_inches = size_inches
    @color = color
  end
end
class BritishTextObject
  attr_reader :string, :size_mm, :colour
  def initialize(string, size_mm, colour)
    @string = string
    @size_mm = size_mm
    @colour = colour
  end
end
## Using inheritance based adapter approach
#class BritishTextObjectAdapter < TextObject
#  def initialize(bto)
#    @bto = bto
#  end
#  def text
#    @bto.string
#  end
#  def size_inches
#    @bto.size_mm/25.4
#  end
#  def color
#    @bto.colour
#  end
#end
# Ruby allows reopening classes or objects
class BritishTextObject
  def color
    colour
  end
  def text
    string
  end
  def size_inches
    size_mm/25.4
  end
end

bto = BritishTextObject.new('string', 50.84, 'Red')
#bto = BritishTextObjectAdapter.new(bto1)
puts bto.text
puts bto.color
puts bto.size_inches
