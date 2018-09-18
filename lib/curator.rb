class Curator
  attr_reader :artists, :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist[:id] == id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photograph|
      photograph[:id] == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.select do |photograph|
      photograph[:artist_id] == artist[:id]
    end
  end

  # def artists_with_multiple_photographs
  #   grouped_photographs = @photographs.max_by{|photograph|photograph[:artist_id]}
  # end

  # def photographs_taken_by_artists_from(string)
  #   @photographs.select do |photograph|
  #     photograph[:country] == string
  # end
end
