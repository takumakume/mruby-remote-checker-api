MRuby::Gem::Specification.new('mruby-remote-checker') do |spec|
  spec.license = 'MIT'
  spec.authors = 'takumakume'

  spec.add_dependency 'mruby-fast-remote-check'
  spec.add_dependency 'mruby-uri' , github: 'zzak/mruby-uri'
  spec.add_dependency 'mruby-json'
  spec.add_dependency 'mruby-sleep'
  spec.add_dependency 'mruby-io', github: "pyama86/mruby-io"

  spec.add_test_dependency 'mruby-hash-ext'
end
