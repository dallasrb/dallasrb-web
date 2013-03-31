module EventsHelper
  include Gmaps4railsHelper
  def address_helper(address)
    simple_format(address)
  end

  def marker_for(event)
    content_tag(:div, :class => "info-window") do
      marker_html = "#{address_helper(event.address).gsub("\n","")}"
      flattened_address = event.address.gsub("\n",',')
      flattened_address = flattened_address.gsub(/\s+/,'+')
      marker_html << "<strong><a href='http://maps.google.com/maps?daddr=#{flattened_address}' title='Get Driving Directions' target='_blank'>Get Directions</a></strong><br>"
      marker_html.html_safe
    end
  end
end
