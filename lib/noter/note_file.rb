module Noter
  class NoteFile
    attr_reader :filename

    def initialize(filename)
      @filename = filename
    end

    def self.dir
      "#{ENV['HOME']}/.notes"
    end

    def formatted_time
      basename = File.basename(@filename, ".txt")
      numbers = basename.split("_")
      "#{numbers[1]}-#{numbers[2]} #{numbers[3]}:#{numbers[4]}"
    end

    def content
      File.read(filename)
    end

    def first_line
      content.split("\n")[0]
    end
  end
end
