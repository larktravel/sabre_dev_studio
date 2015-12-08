require File.expand_path("../test_helper", __FILE__)

class SabreDevStudio::Base
  @@token = 1
end

class SabreDevStudio::Base::BaseTests < Minitest::Test
  def setup
    SabreDevStudio.configure do |c|
      c.client_id     = 'V1:arnv648hexlart43:DEVCENTER:EXT'
      c.client_secret = '7WaoU1tB'
      c.uri           = 'https://api.test.sabre.com'
    end
  end

  def test_canned_request_success
    stub_request(:get, "#{SabreDevStudio.configuration.uri}/v1/shop/themes").
      to_return(json_response('air_shopping_themes.json'))
    themes = SabreDevStudio::Base.get('/v1/shop/themes')
    assert_equal 'BEACH', themes['Themes'].first['Theme']
  end

  def test_request_object
    stub_request(:get, "#{SabreDevStudio.configuration.uri}/v1/shop/themes").
      to_return(json_response('air_shopping_themes.json'))
    endpoint = '/v1/shop/themes'
    request  = SabreDevStudio::RequestObject.new(endpoint)
    assert_equal 'self', request.links.first.rel
    assert_equal 'BEACH', request.themes.first.theme
  end

  def test_bfm_request
    WebMock.allow_net_connect!

    options = {destination: "PAR"}
    # endpoint = '/v1.9.0/shop/flights?mode=live'
    # request_data = build_bfm_request(options) #raw_json_from_fixture('bfm_air_request.json')
    # request  = SabreDevStudio::RequestObject.new(endpoint)
    # results = SabreDevStudio::Base.post_bfm(endpoint, {query: request_data.to_json})
    results = SabreDevStudio::Flights.bargain_finder_max(options)
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  def test_instaflights_request
    WebMock.allow_net_connect!

    options = {destination: "PAR"}
    # endpoint = '/v1.9.0/shop/flights?mode=live'
    # request_data = build_bfm_request(options) #raw_json_from_fixture('bfm_air_request.json')
    # request  = SabreDevStudio::RequestObject.new(endpoint)
    # results = SabreDevStudio::Base.post_bfm(endpoint, {query: request_data.to_json})
    results = SabreDevStudio::Flights.instaflights(options)
    WebMock.disable_net_connect!(allow_localhost: true)
  end

end
