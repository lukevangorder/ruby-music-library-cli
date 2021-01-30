
class Artist
    extend Concerns::Findable
    attr_accessor :name
    @@all = []
    def initialize(name)
        @name = name
        @songs = []
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
        Artist.new(name)
    end
    def add_song(song)
        if @songs.include?(song) == false
            @songs << song
            song.add_artist(self)
        end
    end 
    def songs
        # songs = []
        # Songs.all.each do |song|
        #     if song.artist == self
        #         songs << song
        #     end
        # end
        # songs
        @songs
    end
    def genres
        genres = []
        @songs.each do |song|
            if genres.include?(song.genre) == false
                genres << song.genre
            end
        end
        genres
    end
end