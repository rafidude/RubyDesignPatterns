class Encrypter
  def initialize(key)
    @key = key
  end
  def encrypt(reader, writer)
    key_index = 0
    encrypted_string = ''
    while not reader.eof?
      clear_char = reader.getc
      encrypted_char = clear_char ^ @key[key_index]
      writer.putc(encrypted_char)
      encrypted_string += encrypted_char.chr
      key_index = (key_index + 1) % @key.size
    end
    encrypted_string
  end
end
class StringIOAdapter
  def initialize(string)
    @string = string
    @position = 0
  end
  def getc
    if @position >= @string.length
      raise EOFError
    end
    ch = @string[@position]
    @position += 1
    return ch
  end
  def eof?
    return @position >= @string.length
  end
end
e = Encrypter.new('my secret key')
#reader = File.open('in.txt', 'r')     #to test encrypter class
reader = StringIOAdapter.new('Testing Ruby Adapter')   #test stringIO adapter
writer = File.open('out.txt', 'w')
output = e.encrypt(reader, writer)
puts "Encrypted String: "
puts output
reader = StringIOAdapter.new(output)
output = e.encrypt(reader, writer)
puts "Decryption by encrypting the encrypted string: "
puts output
