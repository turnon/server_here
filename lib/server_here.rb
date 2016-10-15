require 'rack'

lib = File.join(
  File.expand_path('../server_here', __FILE__),
  File::SEPARATOR,
  '*'
)

Dir[lib].each do |f|
  require 'server_here/' + (File.basename f, '.rb')
end

module ServerHere
  App = Rack::Builder.app {
    use Rack::ContentLength
    use EnvInspector
    run Core.new
  }
end
