class Report
  def initialize
    @title = 'Monthly Report'
    @text = ['Things are going', 'really really well']
  end
  def output_report
    show_header
    show_body
    show_footer
  end
  def show_header
    raise 'Called abstract method: show_header'
  end
  def show_body
    raise 'Called abstract method: show_body'
  end
  def show_footer
    raise 'Called abstract method: show_footer'
  end
end
class HTMLReport < Report
  def show_header
    head = %Q{<html><head>
       <title>#{@title}</title>
       </head>}
    puts head
  end
  def show_body
    puts '<body>'
    @text.each do |line|
      puts '<li>' + line + '</li>'
    end
    puts '</body>'
  end
  def show_footer
    puts '</html>'
  end
end
class PlainTextReport < Report
  def show_header
    puts "***#{@title}***"
  end
  def show_body
    @text.each do |line|
      puts line
    end
  end
  def show_footer
  end
end
rep = HTMLReport.new
rep.output_report
rep = PlainTextReport.new
rep.output_report
