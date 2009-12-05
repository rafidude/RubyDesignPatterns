#non-singleton class
class SimpleLogger
  attr_accessor :level
  ERROR = 1; WARNING = 2; INFO = 3
  def initialize
    @log = File.open("log.txt", "a")
    @level = WARNING
  end
  def error(msg)
    puts("Error: " + msg)
    @log.write(msg)
    @log.flush
  end
  def warning(msg)
    puts("Warning: " + msg)
    @log.write(msg) if @level >= WARNING
    @log.flush
  end
  def info(msg)
    puts("Info: " + msg)
    @log.write(msg) if @level >= INFO
    @log.flush
  end
end
#Singleton version of SimpleLogger
class SimpleLogger
  @@instance = SimpleLogger.new
  def self.instance
    @@instance
  end
  private_class_method :new
end
# Same singleton instance returned
puts SimpleLogger.instance
puts SimpleLogger.instance
sl = SimpleLogger.instance
sl.warning("#{Time.now} warning text")
#sl.info("#{Time.now} info text")
#sl.error("#{Time.now} error text")
#Ruby based singleton class
require 'singleton'
class RubySimpleLogger
  include Singleton
  attr_accessor :level
  ERROR = 1; WARNING = 2; INFO = 3
  def initialize
    @log = File.open("log.txt", "a")
    @level = WARNING
  end
  def error(msg)
    puts("Error: " + msg)
    @log.write(msg + "\n")
    @log.flush
  end
  def warning(msg)
    puts("Warning: " + msg)
    @log.write(msg + "\n") if @level >= WARNING
    @log.flush
  end
  def info(msg)
    puts("Info: " + msg)
    @log.write(msg + "\n") if @level >= INFO
    @log.flush
  end
end
r = RubySimpleLogger.instance
r.warning("Some warning")
class ClassBasedLogger
  ERROR = 1; WARNING = 2; INFO = 3
  @@log = File.open('log.txt', 'w')
  @@level = WARNING
  def self.error(msg)
    puts("Error: " + msg)
    @@log.write(msg + "\n")
    @@log.flush
  end
  def self.warning(msg)
    puts("Warning: " + msg)
    @@log.write(msg + "\n") if @@level >= WARNING
    @@log.flush
  end
  def self.info(msg)
    puts("Info: " + msg)
    @@log.write(msg + "\n") if @@level >= INFO
    @@log.flush
  end
  def self.level=(new_level)
    @@level = new_level
  end
  def self.level
    @@level
  end
end
ClassBasedLogger.level = ClassBasedLogger::INFO
ClassBasedLogger.info("Computer wins chess game.")
module ModuleBasedLogger
  ERROR = 1; WARNING = 2; INFO = 3
  @@log = File.open('log.txt', 'w')
  @@level = WARNING
  def self.error(msg)
    puts("Error: " + msg)
    @@log.write(msg + "\n")
    @@log.flush
  end
  def self.warning(msg)
    puts("Warning: " + msg)
    @@log.write(msg + "\n") if @@level >= WARNING
    @@log.flush
  end
  def self.info(msg)
    puts("Info: " + msg)
    @@log.write(msg + "\n") if @@level >= INFO
    @@log.flush
  end
  def self.level=(new_level)
    @@level = new_level
  end
  def self.level
    @@level
  end
end
ModuleBasedLogger.level = ModuleBasedLogger::INFO
ModuleBasedLogger.info("Learning modules in Ruby.")
