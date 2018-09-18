require './lib/curator'
require './lib/photograph'
require './lib/artist'
require 'minitest/autorun'
require 'minitest/pride'

class CuratorTest < Minitest::Test
  def setup
    @curator = Curator.new

    @photo_1 = {id: "1",
                name: "Rue Mouffetard, Paris (Boy with Bottles)",
                artist_id: "1",
                year: "1954"
              }

    @photo_2 = {id: "2",
              name: "Moonrise, Hernandez",
              artist_id: "2",
              year: "1941"
              }

    @photo_3 = {id: "3",
              name: "Identical Twins, Roselle, New Jersey",
              artist_id: "3",
              year: "1967"
            }

    @photo_4 = {id: "4",
              name: "Child with Toy Hand Grenade in Central Park",
              artist_id: "3",
              year: "1962"
            }

    @artist_1 = {id: "1", name: "Henri Cartier-Bresson", born: "1908", died: "2004", country: "France"}

    @artist_2 = {id: "2", name: "Ansel Adams", born: "1902", died: "1984", country: "United States"}

    @artist_3 = {id: "3", name: "Diane Arbus", born: "1923", died: "1971", country: "United States"}
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_artists_and_photographs_start_empty
    assert_equal [], @curator.artists
    assert_equal [], @curator.photographs
  end

  def test_it_can_add_photographs
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal [@photo_1, @photo_2], @curator.photographs
  end

  def test_it_list_the_first_photograph_added
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal @photo_1, @curator.photographs.first
  end

  def test_it_can_list_name_of_photographer
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", @curator.photographs.first[:name]
  end

  def test_it_can_add_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal [@artist_1, @artist_2], @curator.artists
  end

  def test_it_lists_the_first_artist_added
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal @artist_1, @curator.artists.first
  end

  def test_it_can_list_artist_name
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal "Henri Cartier-Bresson", @curator.artists.first[:name]
  end

  def test_it_can_find_artist_or_photo_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal @artist_1, @curator.find_artist_by_id("1")
    assert_equal @photo_2, @curator.find_photograph_by_id("2")
  end

  def test_it_can_find_photographs_by_artist
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    diane_arbus = @curator.find_artist_by_id("3")

    assert_equal [@photo_3, @photo_4], @curator.find_photographs_by_artist(diane_arbus)
  end

  def test_it_can_find_artists_with_multiple_photographs
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    assert_equal [@artist_3], @curator.artists_with_multiple_photographs
  end

  def test_it_can_find_photos_based_on_country
    skip
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    assert_equal [@photo_2, @photo_3, @photo_4], @curator.photographs_taken_by_artists_from("United States")
  end
end
