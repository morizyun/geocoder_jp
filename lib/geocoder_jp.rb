# coding: utf-8
require 'geocoder_jp/version'
require 'active_support/core_ext'
require 'uri'
require 'pp'
require 'net/http'
require 'kconv'

module GeocoderJP
  RequestError = Class.new(StandardError)
  NotFound     = Class.new(StandardError)

  def self.get(address)
    raise ArgumentError if address.blank?
    uri = URI.parse(URI.encode("http://www.geocoding.jp/api/?v=1.1&q=#{address}"))

    # GETリクエスト送出
    #Net::HTTP.get_print(uri); exit
    http     = Net::HTTP.new(uri.host, uri.port)
    request  = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    #pp response, response.body
    raise RequestError if response.code != "200"

    #レスポンスの解析
    xml    = Hash.from_xml(response.body)
    result = xml["result"]

    # 存在しない場合は004が返却
    raise NotFound if result["error"] == "004"

    # それ以外はエラーコードと共にRequestErrorを返却
    raise RequestError, "Request failed. Error code=#{result['error']}" if result.include?("error")

    return result

  end

  def self.escape_xml(input)
    result = input.dup
    {
       '&' => '&amp;',
       "'" => '&apos;',
       '"' => '&quot;',
       #'<' => '&lt;',
       #'>' => '&gt;',
    }.each{ |key, val|
      result.gsub!(key, val)
    }
    result
  end

end
