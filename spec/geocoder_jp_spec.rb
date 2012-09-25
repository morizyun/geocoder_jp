# coding: utf-8
require_relative 'spec_helper'
require_relative '../lib/geocoder_jp'

# STDOUT.should_receive(:puts).with("foo")
describe "GeocoderJP module" do

  describe "誤入力に対する動作" do
    it "空入力したときエラーが返るか" do
      [
        nil,
        "",
        " ",
        "     ",
        "　",
        "　　　",
      ].each{ |input|
        expect {
          GeocoderJP.get(input)
        }.to raise_exception(ArgumentError)
      }
    end
    it "存在しないものに対してエラーが返るか" do
      expect {
        GeocoderJP.get("404")
      }.to raise_exception
    end
  end

  describe "正しい入力に対する動作" do
    it "東京タワー" do
      response = GeocoderJP.get("東京タワー")
      response["coordinate"]["lat"].should_not be_empty
    end
  end

end