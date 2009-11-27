class Report
  attr_reader :title, :text
  def initialize
    @title = 'Monthly Report'
    @text = ['Things are going', 'really really well']
  end
  def output_report(&block)
    block.call(self)
  end
end
HTMLFormatter = lambda do |context|
  puts '<html><head><title>'
  puts "#{context.title}</title></head><body>"
  context.text.each do |line|
    puts "<li>#{line}</li>"
  end
  puts "</body></html>"
end
PlainTextFormatter = lambda do |context|
  puts "****#{context.title}****"
  context.text.each do |line|
    puts line
  end
end
rep = Report.new
rep.output_report &HTMLFormatter
rep.output_report &PlainTextFormatter