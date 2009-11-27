class Report
  attr_reader :title, :text
  attr_accessor :formatter
  def initialize(formatter)
    @title = 'Monthly Report'
    @text = ['Things are going', 'really really well']
    @formatter = formatter
  end
  def output_report
    @formatter.output_report(self)
  end
end
class HTMLFormatter
  def output_report(context)
    puts '<html><head><title>'
    puts "#{context.title}</title></head><body>"
    context.text.each do |line|
      puts "<li>#{line}</li>"
    end
    puts "</body></html>"
  end
end
class PlainTextFormatter
  def output_report(context)
    puts "****#{context.title}*****"
    context.text.each do |line|
      puts line
    end
  end
end
rep = Report.new(HTMLFormatter.new)
rep.output_report
rep.formatter = PlainTextFormatter.new
rep.output_report