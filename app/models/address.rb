require "open-uri"
require "html_whitespace_cleaner"

class Address < ActiveRecord::Base
  belongs_to :search_result

  def rental_average(length_of_stay)

  total_rent = 0

  predicted_increase = 0

  if self.built.to_i < 1973
    predicted_increase = 1.9
  else
    neighborhood = {
      "Bernal Heights" => 18.42,
      "Noe Valley" => 15.21,
      "Hayes Valley" => 13.22,
      "Pacific Heights" => 14.34,
      "Potrero Hill" => 14.78,
      "Western Addition" => 26.78,
      "Central Waterfront - Dogpatch" => 14.52,
      "Outer Sunset" => 17.51,
      "Nob Hill" => 17.01,
      "Downtown" => 21.57,
      "Marina" => 17.36,
      "Mission" => 10.33,
      "South of Market" => 16.42,
      "Twin Peaks" => 6.21,
      "Excelsior" => 13.11,
      "Forest Hill" => 18.63,
      "Merced Manor" => 14.65,
      "Outer Richmond" => 14.44,
      "South Beach" => 10.29,
      "Eureka Valley - Dolores Heights - Castro" => 14.46,
      "Central Richmond" => 12.91,
      "Russian Hill" => 13.18,
      "Stonestown" => 14.65,
      "Sea Cliff" => 12.59,
      "Mission Terrace" => 18.01,
      "Yerba Buena" => 9.85,
      "Midtown Terrace" => 13.77,
      "North Panhandle" => 13.15,
      "Sunnyside" => 13.85,
      "Mission Bay" => 5.87,
      "Telegraph Hill" => 8.46,
      "Corona Heights" => 13.46,
      "Parnassus - Ashbury" => 12.59,
      "Van Ness - Civic Center" => 22.12,
      "Lower Pacific Heights" => 11.57,
      "Inner Richmond" => 12.96,
      "Outer Mission" => 14.17,
      "Ingleside" => 14.59,
      "Lake" =>  4.45,
      "Central Sunset" => 13.7,
      "North Waterfront" => 14.36,
      "Cow Hollow" =>  22.19,
      "Miraloma Park" => 16.18,
      "Lakeshore" => 21.7,
      "Presidio Heights" => 6.64,
      "Bayview" => 18.21,
      "Portola" => 18.36,
      "Haight-Ashbury" => 8.57,
      "Outer Parkside" => 16.87,
      "Inner Sunset" => 18.17,
      "Buena Vista Park" => 15.48,
      "Oceanview" => 16.89,
      "Diamond Heights" => 6.74,
      "Westwood Highlands" => 21.17,
      "Forest Hill Extension" => 24.76,
      "Lone Mountain" => 15.94,
      "Mount Davidson Manor" => 21.39,
      "Golden Gate Heights" => 17.45,
      "Glen Park" => 25.14,
      "North Beach" => 19.32,
      "Visitacion Valley" => 20.24,
      "Parkside" => 19.17
    }
    neighborhood.default = 14.645
    predicted_increase = neighborhood[self.neighborhood]
  end

  # predicted_increase = predicted_increase / 100
  # "predicted increase"
  # predicted_increase

  for i in 0..(length_of_stay -1)
    total_rent += self.price.to_i * ((1 + (predicted_increase / 100)) **i)
  end

  (total_rent/length_of_stay).round(0)
end

# def clean(html)
#   remove_all_white_space_between_tags(condense_whitespace(html)).strip
# end

def self.get_description(url)
  html = File.read(open(url))
  # clean_html = clean(html)
  # nokogiri_document = Nokogiri.parse(clean_html)
  # html_node = nokogiri_document.children.last
  # p nokogiri_document.css(".zsg-content-component")[1].text

  clean_html = HTMLWhitespaceCleaner.clean(html)
  nokogiri_document = Nokogiri.parse(clean_html)
  p html_node = nokogiri_document.children.last
  p nokogiri_document.css(".zsg-content-component")[1].text

# p nokogiri_document.css(".zsg-content-component")[1].inner_html



  # p nokogiri_document.css(".zsg-content-component")[1].inner_html
end

private
  # WHITE_SPACE_BETWEEN_TAGS = /(?<=>)\s+(?=<)/

  # def remove_all_white_space_between_tags(html_string)
  #   html_string.gsub(WHITE_SPACE_BETWEEN_TAGS, "")
  # end

  # def condense_whitespace(html_string)
  #   html_string.gsub(/\s+/, ' ')
  # end

end
