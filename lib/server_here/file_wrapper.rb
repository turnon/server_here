module ServerHere
  class FileWrapper
    def initialize file
      @f = file
    end
  
    def last_mod
      @last_mod ||= File.mtime(@f).strftime '%a, %d %b %Y %T GMT'
    end
  
    def ext
      File.extname(@f).gsub(/\./, '')
    end
  
    def content_type
      'text/' + (%w{html css}.include?(ext) ? ext : 'plain')
    end
  
    def to_body
      [File.read(@f)]
    end
  end
end
