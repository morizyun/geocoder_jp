# GeocoderJP

This gem is the best solution for geocoding in Japan.
Backend is [http://www.geocoding.jp/](http://www.geocoding.jp/).

Other geocoding gem, such as [alexreisner/geocoder](https://github.com/alexreisner/geocoder) is awesome but
its backend(Google, Yahoo, Bing, ..etc) is not good especially in Japan.


## Compatibility
The following environments have been tested: ruby 1.9.3p0  + OSX Lion


## Installation

    $ gem install geocoder_jp


## Usage

### In irb:
    $ irb
    > require 'geocoder_jp'
    > GeocoderJP.get("東京タワー")
     => {"version"=>"1.1", "address"=>"東京タワー", "coordinate"=>{"lat"=>"35.658599",  ...
That's it.

### In CLI:

After install this gem, you can use `geojp` command.

    $ geojp "東京タワー"
    Success!
    {"version"=>"1.1",
     "address"=>"東京タワー",
     "coordinate"=>
      {"lat"=>"35.658599",
       "lng"=>"139.745443",
       "lat_dms"=>"35,39,30.956",
       "lng_dms"=>"139,44,43.595"},
     "url"=>
      "http://www.geocoding.jp/?q=%E6%9D%B1%E4%BA%AC%E3%82%BF%E3%83%AF%E3%83%BC",
     "needs_to_verify"=>"yes",
     "google_maps"=>"東京タワー, 〒105-0011 東京都港区芝公園４丁目２−８"}



