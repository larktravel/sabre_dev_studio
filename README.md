# SabreDevStudio

This is the base gem for a suite of API wrappers for the Sabre Dev Studio APIs.

This gem includes the token authentication and basic error handling.

[![Build Status](https://travis-ci.org/SabreDevStudio/sabre_dev_studio.svg?branch=master)](https://travis-ci.org/SabreDevStudio/sabre_dev_studio)

## Installation

Add this line to your application's Gemfile:

    gem 'sabre_dev_studio'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sabre_dev_studio

## Usage

Register for an account at http://developer.sabre.com

Require this gem and whatever other sabre_dev_studio gem(s) that you need.

Configuration block (required, use your credentials):

    SabreDevStudio.configure do |c|
      c.client_id     = 'V1:1234:ABCD:XYZ'
      c.client_secret = 'SeKr1T'
      c.uri           = 'https://api.test.sabre.com'
    end

To see an access token:

    token = SabreDevStudio::Base.get_access_token

An example request:

    themes = SabreDevStudio::Base.get('/v1/shop/themes')

cURL to test the account token dance:

    curl \
    -X POST \
    --header "Content-Type: application/x-www-form-urlencoded" \
    --header "Authorization:Basic VmpFNk1UQTBNanBUVkZCVE9rVllWQT09OlFrdENRVzh6V0RNPQ==" \
    --data "grant_type=client_credentials" \
    https://api.test.sabre.com/v1/auth/token

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

See LICENSE.txt

## Disclaimer of Warranty and Limitation of Liability

This software and any compiled programs created using this software are furnished “as is” without warranty of any kind, including but not limited to the implied warranties of merchantability and fitness for a particular purpose. No oral or written information or advice given by Sabre, its agents or employees shall create a warranty or in any way increase the scope of this warranty, and you may not rely on any such information or advice.
Sabre does not warrant, guarantee, or make any representations regarding the use, or the results of the use, of this software, compiled programs created using this software, or written materials in terms of correctness, accuracy, reliability, currentness, or otherwise. The entire risk as to the results and performance of this software and any compiled applications created using this software is assumed by you. Neither Sabre nor anyone else who has been involved in the creation, production or delivery of this software shall be liable for any direct, indirect, consequential, or incidental damages (including damages for loss of business profits, business interruption, loss of business information, and the like) arising out of the use of or inability to use such product even if Sabre has been advised of the possibility of such damages.
