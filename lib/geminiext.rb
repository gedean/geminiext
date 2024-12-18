require 'gemini-ai'
#require 'faraday'

require 'geminiext/cache'
# require 'geminiext/messages'
# require 'geminiext/response_extender'

module Geminiext
  MAX_TOKENS = ENV.fetch('GEMINI_MAX_TOKENS', 8_192).to_i

  def self.new(model: 'gemini-1.5-flash-8b')
    Gemini.new(load_config(model: model))
  end
 
  def self.load_config(model: 'gemini-1.5-flash-8b')
    {
      credentials: {
        service: 'generative-language-api',
        api_key: ENV.fetch('GEMINI_API_KEY')
      },
      options: { model:}
    }    
  end
end
