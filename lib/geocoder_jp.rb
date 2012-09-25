# coding: utf-8
require_relative 'geocoder_jp/version'
require 'active_support/core_ext'
require 'uri'
require 'pp'
require 'net/http'
require 'kconv'

module GeocoderJP
  RequestError    = Class.new(StandardError)
  NotFound        = Class.new(StandardError)
  TooManyRequests = Class.new(StandardError)

  def self.get(address)
    address = address.toutf8 unless address.nil?
    raise ArgumentError, "Please input address." if address.blank?
    url = "http://www.geocoding.jp/api/?v=1.1&q=#{address}".toutf8

    uri = URI.parse(URI.encode(url))

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

    # エラーが存在する場合は例外を発生
    case result["error"]
    when "003"
      raise TooManyRequests, "DO NOT request one or more times in 5 seconds."
    when "004"
      raise NotFound
    else
      # それ以外はエラーコードと共にRequestErrorを返却
      raise RequestError, "Request failed. Error code=#{result['error']}" if result.include?("error")
    end

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
