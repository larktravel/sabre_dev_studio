require 'hashie'
require File.expand_path("../hashie_key_conversion", __FILE__)

module SabreDevStudio
  ##
  # Base RequestObject that other API objects can inherit from
  #
  # ==== Example:
  #    module SabreDevStudio
  #      module Flight
  #        class TravelThemeLookup < SabreDevStudio::RequestObject
  #        end
  #      end
  #    end
  class RequestObject < Hash
    attr_reader :response

    def initialize(endpoint, options = {})
      @response = SabreDevStudio::Base.get(endpoint, :query => options)
    end

    def method_missing(meth, *args, &block)
      if hashie.respond_to?(meth)
        hashie.send(meth)
      else
        super
      end
    end

    def respond_to?(meth)
      if hashie.respond_to?(meth)
        true
      else
        super
      end
    end

    def to_s
      hashie
    end

    def inspect
      self.to_s
    end

    private
    def hashie
      unless @hashie
        @hashie ||= Hashie::Mash.new(@response.parsed_response).downcase_keys
      end
      @hashie
    end
  end

  class PostRequestObject < Hash
    attr_reader :response

    def initialize(endpoint, options = {})
      Rails.logger.info(options)
      @response = SabreDevStudio::Base.send_post(endpoint, :query => options)
    end

    def method_missing(meth, *args, &block)
      if hashie.respond_to?(meth)
        hashie.send(meth)
      else
        super
      end
    end

    def respond_to?(meth)
      if hashie.respond_to?(meth)
        true
      else
        super
      end
    end

    private
    def hashie
      unless @hashie
        @hashie ||= Hashie::Mash.new(@response.parsed_response).downcase_keys
      end
      @hashie
    end
  end

end
