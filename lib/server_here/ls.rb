require 'erb'

module ServerHere
  class Ls

    def initialize app
      @app = app
    end

    def call env
      req = Rack::Request.new env
      path = '.' + req.path_info

      if not File.exists? path
        return [404, {'Content-Type' => 'text/plain'}, ["#{path} does not exist"] ]
      end

      if File.directory? path
        return [200, {'Content-Type' => 'text/html'}, [ls_al(path)] ]
      end

      @app.call env
    end

    private

    def ls_al path
      rel_path = path.sub(/\.\//, '')
      list = `ls -al #{path}`.split("\n")[1..-1]
      Tmpl.result binding
    end

    Tmpl = ERB.new <<-EOS
<% list.each do |line| %>
  <a href="<%= rel_path %>/<%= line.split[8] %>"><%= line %></a><br>
<% end%>
EOS

  end
end
