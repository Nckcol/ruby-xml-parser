require 'rubygems'
require 'nokogiri'

class XmlValidator
  def initialize(xsd)
    @xsd = Nokogiri::XML::Schema xsd
  end

  def validate(xml)
    doc = Nokogiri::XML(xml)

    @xsd.validate(doc).each do |error|
      puts error.message
      return false
    end

    true
  end
end