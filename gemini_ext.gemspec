Gem::Specification.new do |s|
  s.name          = 'gemini_ext'
  s.version       = '0.0.10'
  s.date          = '2025-06-08'
  s.platform      = Gem::Platform::RUBY
  s.summary       = 'Ruby Gemini Extended'
  s.description   = 'Based on gemini-ai, adds some extra features'
  s.authors       = ['Gedean Dias']
  s.email         = 'gedean.dias@gmail.com'
  s.files         = Dir['README.md', 'lib/**/*']
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 3'
  s.homepage      = 'https://github.com/gedean/geminiext'
  s.license       = 'MIT'
  s.add_dependency 'faraday', '~> 2'
  s.add_dependency 'base64', '~> 0.2.0'
  s.add_dependency 'nokogiri', '~> 1'
  # s.post_install_message = %q{Please check readme file for use instructions.}
end
