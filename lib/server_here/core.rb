module ServerHere
  class Core
  
    def call env
      req = Rack::Request.new env
      path = File.join('.', req.path_info)
  
      file = FileWrapper.new path
  
      header = {
        'Content-Type' => file.content_type,
        'Last-Modified' => file.last_mod
      }
  
      [200, header, file.to_body]
    end
  end
end
