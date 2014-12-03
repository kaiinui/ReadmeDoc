Gem::Specification.new do |s|
  s.name = 'readmedoc'
  s.version = '0.1.0'
  s.summary = 'Inline-documentation to README'
  s.author = 'Kai INUI'
  s.email = 'lied.der.optik@gmail.com'
  s.homepage = 'https://github.com/kaiinui/ReadmeDoc'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.license  = 'MIT'
  s.executables << 'readmedoc'

  s.add_development_dependency 'rspec'
  s.add_runtime_dependency 'slop'
end
