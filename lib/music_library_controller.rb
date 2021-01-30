class MusicLibraryController
    attr_accessor :path
    def initialize(path='./db/mp3s')
        @path = path
        @library = MusicImporter.new(@path)
        @library.import
    end
    def call
        input = ''
        until input == 'exit'
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            input = gets.strip
            if input == 'list songs'
                self.list_songs
            elsif input == 'list artists'
                self.list_artists
            elsif input == 'list genres'
                self.list_genres
            elsif input == 'list artist'
                self.list_songs_by_artist
            elsif input == 'list genre'
                self.list_songs_by_genre
            elsif input == 'play song'
                self.play_song
            else
            end
        end
    end
    def list_songs
        @songs1 = []
        Song.all.each do |song|
            @songs1 << song
        end
        @songs1.sort! { |a,b| a.name <=> b.name}
        @songs1.each do |song|
            puts "#{@songs1.index(song)+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end
    def list_artists
        @artists = []
        Artist.all.each do |artist|
            if @artists.include?(artist.name) == false
                @artists << artist.name
            end
        end
        @artists.sort!
        @artists.each do |artist|
            puts "#{@artists.index(artist)+1}. #{artist}"
        end
    end
    def list_genres
        @genres = []
        Song.all.each do |song|
            if @genres.include?(song.genre.name) == false
                @genres << song.genre.name
            end
        end
        @genres.sort!
        @genres.each do |genre|
            puts "#{@genres.index(genre)+1}. #{genre}"
        end
    end
    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        exists = false
        @works = []
        Artist.all.each do |artist|
            if artist.name == input
                exists = true
                @target_artist = artist
            end
        end
        if exists
            @target_artist.songs.each do |song|
                @works << "#{song.name} - #{song.genre.name}"
            end
            @works.sort!
            @works.each do |song|
                puts "#{@works.index(song)+1}. #{song}"
            end
        end
    end
    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        exists = false
        @works = []
        Genre.all.each do |genre|
            if genre.name == input
                exists = true
                @target_genre = genre
            end
        end
        if exists
            @target_genre.songs.each do |song|
                @works << [song.name, song.artist.name]
            end
            @works.sort!
            @works.each do |song|
                puts "#{@works.index(song)+1}. #{song[1]} - #{song[0]}"
            end
        end
    end
    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip
        valid = false
        if input.to_i >= 1 && input.to_i <= Song.all.length
            @songsartists = []
            Song.all.each do |song|
                @songsartists << [song.name, song.artist.name]
            end
            @songsartists.sort!
            puts "Playing #{@songsartists[input.to_i - 1][0]} by #{@songsartists[input.to_i - 1][1]}"
        end
    end
end
