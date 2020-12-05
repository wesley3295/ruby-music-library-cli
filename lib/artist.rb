class Artist 
    extend Concerns::Findable
    attr_accessor :name, :songs, :genre
    @@all = []
    def initialize (name)
        @songs = []
        @name = name
    end


    def add_song(song)
        if song.artist
            song.artist
        else 
            song.artist = self
        end

        if @songs.include?(song)
            song.artist
        else 
            @songs << song
        end


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
        artist_name = self.new(name)
        artist_name.save
        artist_name
    end

    def genres
    collection = @songs.collect { |song| song.genre }
        collection.uniq
    end
end