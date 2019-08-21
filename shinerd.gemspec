$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "shinerd/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "shinerd"
  spec.version     = Shinerd::VERSION
  spec.authors     = ["masakazutakewaka"]
  spec.email       = ["takewakamma@gmail.com"]
  spec.homepage    = "https://github.com/masakazutakewaka/shinerd"
  spec.summary     = "Shiny erd generator"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "selenium-webdriver"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "byebug"
end
