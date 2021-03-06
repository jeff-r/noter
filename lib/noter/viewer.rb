require "noter/note_file"
require "pager"
require "colorize"

module Noter
  class Viewer
    include Pager

    attr_reader :do_paging

    def initialize(options = {})
      @do_paging = options[:paging].nil? ? true : options[:paging]
      @do_colors = options[:colorize].nil? ? true : options[:colorize]
      @grep_string = options[:grep_string]
      @tail_count = options[:tail_count].nil? ? false : options[:tail_count].to_i
    end

    def existing_files
      return @existing_files if @existing_files

      if @grep_string
        @existing_files = `grep -l #{@grep_string} #{NoteFile.dir}/*`.split("\n")
      else
        @existing_files = Dir.glob("#{NoteFile.dir}/*").sort
      end
      if @tail_count
        @existing_files = @existing_files.last(@tail_count)
      end
      @existing_files
    end

    def show_first_lines(options = {})
      existing_files.sort.reverse.each do |filename|
        file = NoteFile.new(filename)
        filename_string = ""
        if options[:with_filename]
          filename_string = "#{filename}: "
        end
        puts "#{file.formatted_time}: #{filename_string}#{file.first_line}"
      end
    end

    def filename_from_index(index)
      existing_files[index.to_i]
    end

    def show_file_from_index(index)
      show_file(filename_from_index(index))
    end

    def show_file(filename)
      contents = File.read(filename)
      page if @do_paging
      puts contents
    end

    def show_files
      existing_files.each do |filename|
        if @do_colors
          puts "\n\n#{filename}".colorize(:red)
        else
          puts "\n\n#{filename}"
        end
        show_file(filename)
      end
    end
  end
end
