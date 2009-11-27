require 'fileutils'
class Command
  attr_reader :description
  def initialize(description)
    @description = description
  end
  def execute
  end
end
class CreateFile < Command
  def initialize(path, contents)
    super("Create file: #{path}")
    @path, @contents = path, contents
  end
  def execute
    f = File.open(@path, 'w')
    f.write(@contents)
    f.close
  end
  def unexecute
    File.delete(@path) if File.exists?(@path)
  end
end
class DeleteFile < Command
  def initialize(path)
    super("Delete file: #{path}")
    @path = path
  end
  def execute
    if File.exists?(@path)
      @contents = File.read(@path)
      File.delete(@path)
    end
  end
  def unexecute
    f = File.open(@path, 'w')
    f.write(@contents)
    f.close
  end
end
class CopyFile < Command
  include FileUtils
  def initialize(source, target)
    super("Copy #{source} to #{target}")
    @source, @target = source, target
  end
  def execute
    if File.exists?(@source)
      @contents = File.read(@source)
      FileUtils.copy(@source, @target)
    end
  end
  def unexecute
    File.delete(@target) if File.exists?(@target)
    unless File.exists?(@source)
      f = File.open(@source, 'w')
      f.write(@contents)
      f.close
    end
  end
end
class CompositeCommand < Command
  def initialize
    @commands = []
  end
  def add_command(cmd)
    @commands << cmd
  end
  def execute
    @commands.each {|cmd| cmd.execute}
  end
  def unexecute
    @commands.each {|cmd| cmd.unexecute}
  end
  def description
    description = ''
    @commands.each {|cmd| description += cmd.description + "\n"}
    description
  end
end

cmds = CompositeCommand.new
cmds.add_command(CreateFile.new('in.txt', "hello world\n"))
cmds.add_command(CopyFile.new('in.txt', 'out.txt'))
cmds.add_command(DeleteFile.new('in.txt'))
cmds.execute
cmds.unexecute