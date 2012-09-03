require 'securerandom'

class Url < ActiveRecord::Base
  attr_accessible :long, :short

  before_create :ensure_long_starts_with_http

  validates_presence_of :long, :short
  validates_uniqueness_of :long, :short

  OFFENSIVE_WORDS = %w(foo bar)
  POOR_SPELLING = {'0' => 'O', '1' => 'I'}

  # P U B L I C  C L A S S   M E T H O D S
  class << self

    # Find an existing shortened URL, or shorten it now for the first time
    def find_or_shorten(long_value)
      url = Url.where(:long => long_value).first
      url.present? ? url : Url.create(:long => long_value, :short => Url.generate_short_url)
    end

    # Find a matching URL by the short value, taking into account mistypings such as 0 and O
    def find_by_short_value(short_value)
      Url.find_by_short_poor_spelling(short_value)
    end

  end # End Class Methods

  # P R I V A T E
  private

  class << self

    # Find by the short value, considering mistypings (0 and O for example)
    def find_by_short_poor_spelling(short_value)

      # Let's aim for a perfect match the first time around
      url = Url.where(:short => short_value).first

      # If we don't have a result lets take a look at some spelling mistakes...
      if url.blank?
        possibilities = []
        POOR_SPELLING.each do |key, value|
          possibilities << short_value.gsub(key.downcase, value.downcase) # Downcase these values because we can't count on our source to do it
          possibilities << short_value.gsub(value.downcase, key.downcase)
        end

        url = Url.where{ short.like_any possibilities }.first
      end

      url
    end

    # Generate the short URL, taking into account 'offensive' words and characters in common
    def generate_short_url
      short = nil

      # avoid an infinite loop
      (1..10000).each do

        # Make sure we have a character at the start
        random_string = "#{97.+(SecureRandom.random_number(25)).chr}#{SecureRandom.hex(2)}"

        #Make sure that it doesn't exist already and has safe characters
        if Url.where(:short => random_string).blank? and characters_are_safe(random_string)
          short = random_string
          break
        end
      end

      # No short value exists so we're going to throw an error instead of getting stuck in an infinite loop
      if short.blank?
        raise Exception, "Unable to generate short URL successfully"
      else
        short
      end
    end

    # Handle offensive words and existing similar short urls
    def characters_are_safe(short_value)
      (characters_not_in_common(short_value) and characters_not_offensive(short_value))
    end

    # Determine if there are any other short urls that are within 1 character of the one provided
    def characters_not_in_common(short_value)
      possible_variations = []
      short_value.each_char do |char|
        possible_variations << short_value.gsub(char, '_')
      end

      Url.where{ short.like_any possible_variations }.blank?
    end

    # Make sure we haven't generated a word that is on the offensive list
    def characters_not_offensive(short_value)
      not_offensive = true
      OFFENSIVE_WORDS.each do |word|
        if short_value.include?(word)
          not_offensive = false
          break
        end
      end

      not_offensive
    end
  end

  # H O O K S

  # Make sure that the long value starts with http:// so that we can redirect without any issues
  def ensure_long_starts_with_http
    unless self.long.include?('http://')
      self.long = "http://#{self.long}"
    end
  end

end