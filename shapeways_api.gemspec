
Gem::Specification.new do |spec|
  spec.name          = 'shapeways_api'
  spec.version       = '0.1.0'
  spec.authors       = ['Dmitry Ro']
  spec.email         = ['dmitry@falsetrue.io']
  spec.summary       = 'A Ruby wrapper for the Shapeways API'
  spec.description   = 'This gem provides an easy-to-use interface to interact with the Shapeways API, including authentication, model management, and order processing.'
  spec.homepage      = 'https://github.com/noroot/shapeways_api'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_dependency 'stringio', '~> 3.1.3'
  spec.add_runtime_dependency 'json', '~> 2.10'
  spec.add_runtime_dependency 'net-http', '~> 0.6'
end
