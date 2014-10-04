require "noter/note_file"
require "pager"

module Noter
  class Viewer
    include Pager

    attr_reader :do_paging

    def initialize(options = {})
      @do_paging = options[:paging].nil? ? true : options[:paging]
    end

    def existing_files
      @existing_files ||= Dir.glob("#{NoteFile.dir}/*")
    end

    def show_first_lines(options = {})
      existing_files.each do |filename|
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

    def show_last_n_files(num_files)
      existing_files.last(num_files.to_i).each do |filename|
        puts "\n\n#{filename}"
        show_file(filename)
      end
    end
  end
end
