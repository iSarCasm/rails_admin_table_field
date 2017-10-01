$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_table_field/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_table_field"
  s.version     = RailsAdminTableField::VERSION
  s.authors     = ["SarCasm"]
  s.email       = ["sarcasm008@gmail.com"]
  s.homepage    = "https://github.com/iSarCasm/rails_admin_table_field"
  s.summary     = "Adds Table view of Nested Models inside Rails Admin (instead of tabs)"
  s.description = "Adds Table view of Nested Models inside Rails Admin (instead of tabs)"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.2"

  s.add_development_dependency "sqlite3"
end
