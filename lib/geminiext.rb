require 'gemini-ai'

module GeminiExt
  MAX_TOKENS = ENV.fetch('GEMINI_MAX_TOKENS', 8_192).to_i

  ACCURATE_MODE_CONFIG = {
    temperature: 0.0,
    top_p: 0.0,
    top_k: 1,
    max_output_tokens: MAX_TOKENS,
    response_mime_type: 'text/plain'
  }.freeze

  def self.new(model: 'gemini-1.5-flash-8b')
    Gemini.new(load_config(model: model))
  end
 
  def self.load_config(model: 'gemini-1.5-flash-8b', generation_config: nil)
    default_config = {
      temperature: 1.0,
      top_p: 0.95,
      top_k: 40,
      max_output_tokens: MAX_TOKENS,
      response_mime_type: 'text/plain'
    }

    config = if generation_config == :accurate_mode
               ACCURATE_MODE_CONFIG
             elsif generation_config.is_a?(Hash)
               default_config.merge(generation_config)
             else
               default_config
             end

    {
      credentials: {
        service: 'generative-language-api',
        api_key: ENV.fetch('GEMINI_API_KEY')
      },
      options: { 
        model:,
        generation_config: config
      }
    }    
  end

  def self.chat(prompt, model: 'gemini-1.5-flash-8b', generation_config: nil)
    client = new(model: model, generation_config: generation_config)
    chat = client.chat
    response = chat.send_message(content: prompt)
    response.text
  end

  def self.single_prompt(prompt:, model: 'gemini-1.5-flash-8b', generation_config: :accurate_mode)
    chat(prompt, model: model, generation_config: generation_config)
  end
end
