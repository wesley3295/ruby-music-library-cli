class Genre
    attr_accessor :name, :songs
    extend Concerns::Findable

    @@all = []
    def initialize (name)
        @songs = []
        @name = name
    end

    def artists
        collection = @songs.collect { |song| song.artist }
        collection.uniq
    end
    # def songs
    #     @songs
    # end
    
    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        genre_name = Genre.new(name)
        genre_name.save
        genre_name
    end
end