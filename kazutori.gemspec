$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "kazutori/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "kazutori"
  s.version     = Kazutori::VERSION
  s.authors     = ["yalab"]
  s.email       = ["rudeboyjet@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Kazutori."
  s.description = "TODO: Description of Kazutori."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.6"

  s.add_development_dependency "sqlite3"
end
