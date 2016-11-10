require 'erb'
require 'pathname'

module ServerHere
  class Ls

    def initialize app
      @app = app
    end

    def call env
      req = Rack::Request.new env
      path = req.path_info

      if not File.exists? in_pwd path
        return [404, {'Content-Type' => 'text/plain'}, ["#{path} does not exist"] ]
      end

      if File.directory? in_pwd path
        return [200, {'Content-Type' => 'text/html'}, [ls_al(path)] ]
      end

      @app.call env
    end

    private

    def ls_al path
      rel_path = relative path
      list = `ls -al #{in_pwd path}`.split("\n")[3..-1]
      parent_dir = parent rel_path
      Tmpl.result binding
    end

    def relative path
      path == '/' ? '' : path#.sub(/\./, '')
    end

    def parent path
      return '/' if no_deeper_than_one? path
      File.join path.split('/')[0..-2]
    end

    def no_deeper_than_one? path
      path.count('/') == 1
    end

    def in_pwd path
      '.' + path
    end

    Tmpl = ERB.new <<-EOS
<pre>
<a href="<%= parent_dir %>">..</a>
<% list.each do |line| %>
  <a href="<%= rel_path %>/<%= line.split[8] %>"><%= line %></a>
<% end%>
</pre>
EOS

  end
end
