module ServerHere
  class Core
  
    def call env
      req = Rack::Request.new env
      path = File.join('.', req.path_info)
  
      if not File.exists? path
        return [404, {'Content-Type' => 'text/plain'}, ["#{path} does not exist"] ]
      end
  
      if File.directory? path
        return [200, {'Content-Type' => 'text/plain'}, [`ls -al #{path}`] ]
      end
  
      file = FileWrapper.new path
  
      header = {
        'Content-Type' => file.content_type,
        'Last-Modified' => file.last_mod
      }
  
      [200, header, file.to_body]
    end
  end
end
