
class Genre
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
        Genre.new(name)
    end
    def add_song(song)
        if @songs.include?(song) == false
            @songs << song
        end
    end 
    def songs
        # songs = []
        # Songs.all.each do |song|
        #     if song.genre == self
        #         songs << song
        #     end
        # end
        # songs
        @songs
    end
    def artists
        artists = []
        @songs.each do |song|
            if artists.include?(song.artist) == false
                artists << song.artist
            end
        end
        artists
    end
end