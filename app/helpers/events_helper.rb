module EventsHelper
  include Gmaps4railsHelper
  def address_helper(event)
    address_array = event.address.split(',')
    street = "#{address_array[0]}"
    city = "#{address_array[1]}"
    state_zip = "#{address_array[2]}"

    content_tag(:address) do
      concat "<strong>#{event.venue}</strong><br/>".html_safe
      concat "#{street}<br/>".html_safe
      concat "#{city}, #{state_zip}<br/>".html_safe
    end
  end

  def marker_for(event)
    content_tag(:div, :class => "info-window") do
      marker_html = "#{address_helper(event).gsub("\n","")}"
      flattened_address = event.address.gsub("\n",',')
      flattened_address = flattened_address.gsub(/\s+/,'+')
      marker_html << "<strong><a href='http://maps.google.com/maps?daddr=#{flattened_address}' title='Get Driving Directions' target='_blank'>Get Directions</a></strong><br>"
      marker_html.html_safe
    end
  end

  def event_timestamp(event)
    event_date = event.event_date
    start_time = event_date.strftime("%l%p")
    end_time = (event_date + 2.hours).strftime("%l%p")
    date = event.event_date.strftime("%A, %B #{event_date.day.ordinalize}, %Y")

    "#{start_time} to #{end_time} on #{date}"
  end
end
