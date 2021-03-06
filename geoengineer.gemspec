require_relative './lib/geoengineer/version'

Gem::Specification.new do |s|
  s.name        = 'geoengineer'
  s.version     = GeoEngineer::VERSION
  s.summary     = "GeoEngineer can codeify, plan and execute changes to cloud resources."
  s.description = <<-EOF
    GeoEngineer provides a Ruby DSL and command line tool (geo)
    to codeify then plan and execute changes to cloud resources using Hashicorp Terraform.
  EOF
  s.homepage    = "https://coinbase.github.io/geoengineer"
  s.authors     = ['coinbase']
  s.email       = ['graham.jenson@coinbase.com']
  s.license     = 'Apache-2.0'

  s.cert_chain  = ['certs/geoengineer-gem.pem']
  s.signing_key = File.expand_path("~/.ssh/geoengineer-gem-private-key.pem") if $0 =~ /gem\z/

  s.files       = Dir.glob('lib/**/*.rb')
  s.files       << "README.md"
  s.files       << "LICENSE"

  s.test_files = Dir.glob('spec/**/*.rb')
  s.executables << 'geo'

  s.required_ruby_version = '>= 2.2.5'
  s.add_development_dependency "rspec", '~> 3.4'
  s.add_development_dependency "rake", '~> 10.4'
  s.add_development_dependency "yard", '~> 0.8'
  s.add_development_dependency "rubocop", '~> 0.42'
  s.add_development_dependency "pry-byebug", '~> 3.4'

  s.add_dependency 'netaddr',           '~> 1.5'
  s.add_dependency 'aws-sdk',           '~> 2.2'
  s.add_dependency 'commander',         '~> 4.4'
  s.add_dependency 'colorize',          '~> 0.7'
  s.add_dependency 'terminal-table',    '~> 1.5'
end
