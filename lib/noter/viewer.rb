require "noter/note_file"

module Noter
  class Viewer
    def existing_files
      Dir.glob("#{NoteFile.dir}/*")
    end

    def show_first_lines
      existing_files.each do |filename|
        file = NoteFile.new(filename)
        puts "#{file.formatted_time}: #{file.first_line}"
      end
    end
  end
end
