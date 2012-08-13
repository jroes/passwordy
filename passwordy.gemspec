Gem::Specification.new do |s|
  s.name        = 'passwordy'
  s.version     = '0.0.1'
  s.date        = '2012-08-12'
  s.summary     = "A password manager without a password manager."
  s.description = "Generates passwords for you without a password database."
  s.authors     = ["Jon Roes"]
  s.email       = 'jroes@jroes.net'
  s.files       = ["lib/passwordy.rb", "lib/passwordy/generator.rb"]
  s.executables << 'passwordy'
  s.homepage    = 'http://github.com/jroes/passwordy'

  s.add_development_dependency('rake', "~> 0.9")
  s.add_development_dependency('redgreen', "~> 1.2")
  s.add_development_dependency('shoulda', "~> 2.11")
  s.add_development_dependency('rr', "~> 1.0")
end
