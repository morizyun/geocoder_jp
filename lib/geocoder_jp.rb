require "geocoder_jp/version"
require 'nokogiri'
require 'net/http'
require 'uri'
require 'pp'

module GeocoderJP
  def self.get(address)
    uri = URI.parse(URI.encode("http://www.geocoding.jp/api/?v=1.1&q=#{address}"))
    #Net::HTTP.get_print(uri); exit

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    #pp response, response.body

    if response.code == "200"
      xml = Nokogiri(response.body)

      lat = xml.search("lat").inner_text  #緯度
      lng = xml.search("lng").inner_text  #経度
      maps_address = xml.search("google_maps").inner_text  #住所

      unless lat.empty? || lng.empty?
        return {
          :status       => "ok",
          :address      => address,
          :maps_address => maps_address,
          :latitude     => lat.to_f,
          :longitude    => lng.to_f,
        }
      else
        choices = xml.search("choices")
        if choices
          choices.each  do |addr|
            return self.get(addr.inner_text) if addr.inner_text != address
          end
          return {status: "error" , code: nil, message: "not found"}
        else
          return {status: "error" , code: nil, message: "not found"}
        end
      end
    else
      return {status: "error" , code: headers.code, message: headers.message}
    end
  end
end
