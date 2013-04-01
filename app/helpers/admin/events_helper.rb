module Admin::EventsHelper
  def condensed_address(address)
    address.gsub(/\n+/, ', ')
  end
end
