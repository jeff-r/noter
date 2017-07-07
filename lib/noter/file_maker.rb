require "fileutils"

module Noter
  class FileMaker
    attr_reader :content, :filename

    def initialize(content = nil, filename = nil)
      @content = content
      @filename = filename
    end

    def dir
      NoteFile.dir
    end

    def new_filename
      @filename ||= "#{dir}/#{Time.now.strftime('%Y_%m_%d_%H_%M_%S.txt')}"
    end

    def save_file
      unless File.exist?(dir)
        FileUtils.mkpath(dir)
      end
      File.write(new_filename, content)
    end

    def make_from_file(filename)
      content = File.read(filename)
      File.write(new_filename, content)
    end

    def create_empty_file
      filename = new_filename
      content = ""
      File.write(filename, content)
      filename
    end
  end
end
