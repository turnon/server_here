module ServerHere

    class EnvInspector
    
      def initialize app
        @app = app
      end
    
      def call env
        puts env.sort.map{|k,v| "#{green(k)} => #{v}"}.join("\n")
        @app.call env
      end
    
      def green str
        "\e[32m#{str}\e[0m"
      end
    end

end
