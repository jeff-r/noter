require "noter/note_file"

module Noter
  class Viewer
    def existing_files
      Dir.glob("#{NoteFile.dir}/*")
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
  end
end
