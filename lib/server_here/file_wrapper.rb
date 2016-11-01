require 'server_here/content_type_map'

module ServerHere
  class FileWrapper
    def initialize file
      @f = file
    end
  
    def last_mod
      @last_mod ||= File.mtime(@f).rfc2822
    end
  
    def ext
      File.extname(@f).gsub(/\./, '')
    end
  
    def content_type
      ContentTypeMap[ext] || 'text/plain'
    end
  
    def to_body
      File.new(@f)
    end
  end
end
