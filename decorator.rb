class SimpleWriter
  def initialize(path)
    @path = path
  end
  def write_line(line)
    f = File.open(@path, 'w')
    f.write(line + "\n")
    f.close
  end
end
module TimeStampingWriter
  def write_line(line)
    super("#{Time.new}: #{line}")
  end
end
module NumberingWriter
  attr_reader :line_number
  def write_line(line)
    @line_number = 1 unless @line_number
    super("#{@line_number}: #{line}")
    @line_number += 1
  end
end
w = SimpleWriter.new('out.txt')
w.extend(NumberingWriter)
w.extend(TimeStampingWriter)
w.write_line("Hello Decorator!")

puts File.read('out.txt')