rm *.gem
gem build gemini_ext.gemspec
latest_gem=$(ls -1 *.gem | sort | tail -n 1)
gem install "$latest_gem"
