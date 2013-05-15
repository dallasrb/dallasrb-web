module EventsHelper
  include Gmaps4railsHelper
  def address_helper(event_address)
    address_array = event_address.address.split(',')
    street = "#{address_array[0]}"
    city = "#{address_array[1]}"
    state_zip = "#{address_array[2]}"

    content_tag(:address) do
      concat "<strong>#{event_address.venue}</strong><br/>".html_safe
      concat "#{street}<br/>".html_safe
      concat "#{city}, #{state_zip}<br/>".html_safe
    end
  end

  def addresses_helper(event)
    content_tag(:div) do
      event.event_addresses.each do |event_address|
        concat address_helper(event_address)
      end
    end
  end


  def marker_for(event_address)
    content_tag(:div, :class => "info-window") do
      marker_html = "#{address_helper(event_address).gsub("\n","")}"
      flattened_address = event_address.address.gsub("\n",',')
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

  def should_display_rsvp?(event)
    (!event.rsvp_url.blank? && !event.event_date.to_date.past?)
  end
end
