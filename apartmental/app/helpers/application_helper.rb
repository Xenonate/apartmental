module ApplicationHelper
  def get_weight(type, param)
    if param
      type = param
    else
      type = 0.25
    end
  end
end

# html = File.read(open("http://www.zillow.com/homedetails/592-39th-Ave-San-Francisco-CA-94121/2100661300_zpid/"))#open will turn a website into a file and the read will turn the file into a string.

# clean_html = HTMLWhitespaceCleaner.clean(html)
# nokogiri_document = Nokogiri.parse(clean_html)
# p html_node = nokogiri_document.children.last
# p nokogiri_document.css(".zsg-content-component")[1].text

# p nokogiri_document.css(".zsg-content-component")[1].inner_html
