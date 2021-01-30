class MusicImporter
    attr_accessor :path
    @@all = []
    def initialize(file_path)
        @path = file_path
    end
    def files
        @files = []
        Dir[@path + '/*'].each do |file|
            file_split = file.split("/")
            @files << file_split[-1]
        end
        @files
    end
    def import
        self.files.each do |file_name|
            Song.create_from_filename(file_name)
        end
    end
end