class Song
    extend Concerns::Findable
        attr_accessor :name
        attr_reader :artist, :genre


        @@all = []

    def initialize (name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def genre=(genre)
        @genre = genre
        if @genre.songs.include?(self)
            @genre.songs
        else
            @genre.songs<< self
        end

    end

    def artist=(artist)
        @artist = artist
        @artist.add_song(self)
    end

    def self.all
        @@all.uniq
    end

    def self.destroy_all
        @@all.clear        
    end

    def save
        @@all << self
    end
    
    def self.create(name)
       new_song = self.new(name)
       new_song.save
       new_song
    end

    def self.find_by_name(name)
        @@all.find{|song| song.name == name}
    end

    def self.find_or_create_by_name(song)
        find_by_name(song) || self.create(song) 
    end

    def self.new_from_filename(filename)
       new_song = filename.split(".mp3")
       data = new_song[0].split(" - ")
       song = Song.find_or_create_by_name(data[1])
       song.artist = Artist.find_or_create_by_name(data[0])
       song.genre = Genre.find_or_create_by_name(data[2])
       song
     end

     def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        song.save
     end

    
end