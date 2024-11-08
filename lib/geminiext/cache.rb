require 'faraday'
require 'json'

module GeminiExt
  module Cache
    def self.create(contents:, display_name:, model: 'gemini-1.5-flash-001', ttl: 600)
      content = {
        model: "models/#{model}",
        display_name:,
        contents:,
        ttl: "#{ttl}s"
      }.to_json
    
      conn = Faraday.new(
        url: 'https://generativelanguage.googleapis.com',
        headers: { 'Content-Type' => 'application/json' }
      )
    
      response = conn.post('/v1beta/cachedContents') do |req|
        req.params['key'] = ENV.fetch('GEMINI_API_KEY')
        req.body = content
      end
    
      return JSON.parse(response.body) if response.status == 200
    
      raise "Erro ao criar cache: #{response.status} - #{response.body}"
    rescue Faraday::Error => e
      raise "Erro na requisição: #{e.message}"
    end

    def self.list
      conn = Faraday.new(
        url: 'https://generativelanguage.googleapis.com',
        headers: { 'Content-Type' => 'application/json' }
      )

      response = conn.get("/v1beta/cachedContents") do |req|
        req.params['key'] = ENV.fetch('GEMINI_API_KEY')
      end
      
      JSON.parse(response.body)['cachedContents'].map do |item|
        def item.delete = GeminiExt::Cache.delete(name: self['name'])
        def item.set_ttl(ttl = 120) = GeminiExt::Cache.update(name: self['name'], content: { ttl: "#{ttl}s" })
        item
      end

    rescue Faraday::Error => e
      raise "Erro na requisição: #{e.message}"
    end
    
    def self.update(name:, content:)
      conn = Faraday.new(
        url: 'https://generativelanguage.googleapis.com',
        headers: { 'Content-Type' => 'application/json' }
      )

      response = conn.patch("/v1beta/#{name}") do |req|
        req.params['key'] = ENV.fetch('GEMINI_API_KEY')
        req.body = content.to_json
      end

      return JSON.parse(response.body) if response.status == 200
      
      raise "Erro ao atualizar cache: #{response.body}"
    rescue Faraday::Error => e
      raise "Erro na requisição: #{e.message}"
    end

    def self.delete(name:)
      conn = Faraday.new(
        url: 'https://generativelanguage.googleapis.com',
        headers: { 'Content-Type' => 'application/json' }
      )

      response = conn.delete("/v1beta/#{name}") do |req|
        req.params['key'] = ENV.fetch('GEMINI_API_KEY')
      end

      return true if response.status == 200
      
      raise "Erro ao deletar cache: #{response.body}"
    rescue Faraday::Error => e
      raise "Erro na requisição: #{e.message}"
    end
  end
end
