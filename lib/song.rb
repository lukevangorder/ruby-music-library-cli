
class Song
    include Concerns::Findable
    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []
    def initialize(name, artist=nil, genre=nil)
        @name = name
        if artist != nil
            self.artist = artist
        end
        if genre != nil
            self.genre = genre
        end
        @@all << self
    end
    def self.all
        @@all
    end
    def self.destroy_all
        @@all = []
    end
    def save
        @@all << self
    end
    def self.create(name)
        Song.new(name)
    end
    def add_artist(artist)
        @artist = artist
    end
    def artist=(artist)
        @artist = artist
        @artist.add_song(self)
    end
    def genre=(genre)
        @genre = genre
        @genre.add_song(self)
    end
    def self.find_by_name(name)
        @@all.each do |song|
            if song.name == name
                return song
            end
        end
        return nil
    end
    def self.find_or_create_by_name(name)
        song = Song.find_by_name(name)
        if song == nil
            Song.create(name)
        else
            song
        end
    end
    def self.new_from_filename(file_name)
        file_name.delete_suffix!('.mp3')
        pieces = file_name.split(" - ")
        song = Song.find_or_create_by_name(pieces[1])
        song.artist = Artist.find_or_create_by_name(pieces[0])
        song.genre = Genre.find_or_create_by_name(pieces[2])
        song
    end
    def self.create_from_filename(file_name)
        song = Song.new_from_filename(file_name)
        # @@all << song
    end
end