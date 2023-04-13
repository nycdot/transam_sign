source "https://rubygems.org"



# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
gem 'transam_core', git: 'https://github.com/nycdot/transam_core.git', branch: 'rails-6'
# gem 'transam_core', path: "../transam_core"
gem 'transam_spatial', git: 'https://github.com/nycdot/transam_spatial.git', branch: 'rails-6'
# gem 'transam_spatial', path: "../transam-spatial"
gem 'mysql2', '~> 0.5.1' # lock gem for dummy app
gem "capybara", '2.6.2' # lock gem for old capybara behavior on hidden element xpath
gem 'cucumber-rails', group: :test, require: false

# Declare your gem's dependencies in transam_spatial.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec
