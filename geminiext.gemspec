Gem::Specification.new do |s|
  s.name          = 'geminiext'
  s.version       = '0.0.7'
  s.date          = '2024-11-08'
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
  s.add_dependency 'gemini-ai', '~> 4'
  s.add_dependency 'oj', '~> 3'
  # s.post_install_message = %q{Please check readme file for use instructions.}
end
