require "xml/parser/version"
require "xml/parser/dom_parser"
require "xml/parser/sax_parser"
require "xml/parser/validator"


module Xml
  module Parser

    xml = File.read('../../res/PlaneList.xml')
    xsd = File.read('../../res/Plane.xsd')

    validator = XmlValidator.new xsd

    unless validator.validate xml
      exit
    end

    puts '==============================='

    dom_parser = Dom::Parser.new
    dom_parser.run xml

    puts '==============================='

    sax_parser = Sax::Parser.new
    sax_parser.run xml

  end
end
