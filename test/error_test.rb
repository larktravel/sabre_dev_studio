require File.expand_path("../test_helper", __FILE__)

class SabreDevStudio::Base
  @@token = 1
end
class SabreDevStudio::ErrorTests < Minitest::Test
  def setup
    SabreDevStudio.configure do |c|
      c.client_id     = 'V1:USER:GROUP:DOMAIN'
      c.client_secret = 'PASSWORD'
      c.uri           = 'https://api.test.sabre.com'
    end
  end
  def test_canned_response_400
    WebMock.allow_net_connect!
    assert_raises SabreDevStudio::BadRequest do
      url = '/v1/shop/flights/fares?origin=ATL&destination=LAS'
      stub_request(:get, SabreDevStudio.configuration.uri + url).
        to_return(status: 400, body: "{\"status\":\"NotProcessed\",\"type\":\"Validation\",\"errorCode\":\"ERR.RAF.VALIDATION\",\"timeStamp\":\"2013-04-19T18:51:45+00:00\",\"message\":\"Parameter 'origin' must be specified\"}")
      response = SabreDevStudio::Base.get(url)
    end
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  def test_401_retry
    WebMock.allow_net_connect!
    url = "/v1/shop/themes?"
    token_url = "https://VjE6VVNFUjpHUk9VUDpET01BSU4%3D:UEFTU1dPUkQ%3D@api.test.sabre.com/v1/auth/token"
    stub_request(:get, SabreDevStudio.configuration.uri + url).to_return(status: 401)
    stub_request(:post, token_url).
      to_return(:status => 200, :body =>"{\"access_token\":\"Shared/IDL:IceSess\\\\/SessMgr:1\\\\.0.IDL/Common/!ICESMS\\\\/ACPCRTD!ICESMSLB\\\\/CRT.LB!-3801964284027024638!507667!0!F557CBE649675!E2E-1\",\"token_type\":\"bearer\",\"expires_in\":1800}")
    # need to assert it eventually gets raised
    assert_raises SabreDevStudio::Unauthorized do
      SabreDevStudio::Base.get(url)
    end
    assert_requested :get, SabreDevStudio.configuration.uri + url, :times => 2
    # assert_requested :post, token_url, :times => 1
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  def test_canned_response_404
    WebMock.allow_net_connect!
    assert_raises SabreDevStudio::NotFound do
      url = '/v1/shop/themessssss?'
      stub_request(:get, SabreDevStudio.configuration.uri + url).
        to_return(status: 404)
      SabreDevStudio::Base.get(url)
    end
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  # def webmock_allow_block
  #   WebMock.allow_net_connect!
  #   yield
  #   WebMock.disable_net_connect!(allow_localhost: true)
  # end

end
