class Url < ActiveRecord::Base
  attr_accessible :long, :short

  validates_presence_of :long, :short
  validates_uniqueness_of :long, :short
  before_create :ensure_long_starts_with_http

  # C L A S S   M E T H O D S
  class << self

    def find_or_shorten(long_value)
      # TODO: look for existing url that matches this
      url = Url.where(:long => long_value).first

      if url.blank?
        # TODO: Otherwise create with short value which doesn't have more than 1 character in common

        # TODO: Generated short values need to exclude 'swear words'

        url = Url.create(:long => long_value, :short => '1234')
      end
      url
    end

    def find_by_short_value(short_value)

      # TODO: find the short value, considering mistypings (0 and O)
      Url.first
    end

  end # End Class Methods


  # Hooks
  def ensure_long_starts_with_http
     
  end



end