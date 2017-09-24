require 'nokogiri'

class GoodReadsAPI
  URL = "https://www.goodreads.com/search/index.xml?key=6jzygtEpDcmTEDPbhKz2sA&q="
  DESCRIPTION_URL = "https://www.goodreads.com/book/show/"
  KEY_EXTENSION = ".xml?key=6jzygtEpDcmTEDPbhKz2sA"

  attr_reader :title

  def self.book_title(title)
    new(title).book_title
  end

  def self.book_author(title)
    new(title).book_author
  end

  def self.book_img(title)
    new(title).book_img
  end

  def self.book_id(title)
    new(title).book_id
  end

  def self.book_description(title)
    new(title).book_description
  end

  def initialize(title)
    @title = title
  end

  def book_title
    parse_response('//title')
  end

  def book_author
    parse_response('//name')
  end

  def book_id
    parse_id_response
  end

  def book_img
    sub_or_pattern = "m"
    replacement = "l"
    string = parse_response('//image_url')

    array_of_pieces = string.rpartition sub_or_pattern
    ( array_of_pieces[(array_of_pieces.find_index sub_or_pattern)] =  replacement ) rescue nil
    return array_of_pieces.join
    # parse_response('//image_url')
  end

  def book_description
    parse_description_response('//description')
  end

  private

  def httparty_api(title)
    HTTParty.get(URL+title).parsed_response
  end

  def call_api(title)
    Nokogiri::XML(open(URL+title))
  end

  def call_description_api()
    Nokogiri::XML(open(DESCRIPTION_URL+self.book_id.to_s+KEY_EXTENSION))
  end

  def parse_id_response
    httparty_api(title)["GoodreadsResponse"]["search"]["results"]["work"].first["best_book"]["id"]
  end

  def parse_response(xml_tag)
    call_api(title).xpath(xml_tag).first.children.first.text
  end

  def parse_description_response(description)
    call_description_api.xpath(description).first.children.first.text
  end
end
