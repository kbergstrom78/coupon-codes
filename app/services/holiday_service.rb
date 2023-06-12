require "httparty"
require "json"
require "./app/poros/holiday"

class HolidayService

  def self.upcoming_holidays
    response = HTTParty.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
    parsed = JSON.parse(response.body)

    holidays = parsed.first(3).map do |info|
      Holiday.new(info)
    end
  holidays
  end
end