require 'spec_helper'

describe Url do

  subject { create(:url) }

  it "has a valid factory" do
    should be_valid
  end

  it { should validate_presence_of :long }
  it { should validate_presence_of :short }

  it { should validate_uniqueness_of :long }
  it { should validate_uniqueness_of :short }

  describe ".find_or_shorten" do
    it "should return an existing shortened URL if one exists already" do
      existing = create(:url, :long => 'http://www.google.com')
      match = Url.find_or_shorten('http://www.google.com')
      match.short.should == existing.short
    end

    it "should should create a newly shortened URL if one doesn't exist" do
      existing = create(:url, :long => 'http://www.google.com')
      new = Url.find_or_shorten('http://www.bing.com')
      new.short.should_not == existing.short
    end
  end

  describe ".find_by_short_value" do
    it "should return an existing URL based on the short URL value" do
      create(:url, :short => 'abcde')
      url = Url.find_by_short_value('abcde')
      url.short.should == 'abcde'
    end
  end

  describe ".find_by_short_poor_spelling" do
    it "should return a match taking into account common spelling mistakes" do
      create(:url, :short => 'abcdo')
      close_match = Url.find_by_short_poor_spelling('abcd0', {'0' => 'o'})
      close_match.short.should == 'abcdo'
    end
  end

  describe ".characters_not_in_common" do
    it "should return true if there are no existing short URL values that are within 1 character" do
      create(:url, :long => 'http://www.google.com', :short => 'abcde')
      Url.characters_not_in_common('abc12').should be_true
    end

    it "should return false if there are existing short URL values that are within 1 character" do
      create(:url, :long => 'http://www.google.com', :short => 'abcde')
      Url.characters_not_in_common('abcd2').should be_false
    end
  end

  describe ".characters_not_offensive" do
    it "should return true if we have a don't have a word that is considered offensive" do
      Url.characters_not_offensive('abcde', ['foo', 'bar']).should be_true
    end

    it "should return false if we have a word that is considered offensive" do
      Url.characters_not_offensive('foo12', ['foo', 'bar']).should be_false
    end
  end

  describe "#ensure_long_starts_with_http" do
    it "should ensure that the long url value starts with http://" do
      url = create(:url, :long => 'www.google.com')
      url.long.should == 'http://www.google.com'
    end
  end

end