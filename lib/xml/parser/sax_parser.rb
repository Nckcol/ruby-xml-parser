module Sax
  require 'sax-machine'

  class PlaneItem; end
  class Planes; end
  class PlaneAmmunition; end
  class PlaneParameters; end
  class PlaneChars; end

  class Planes
    include SAXMachine

    elements :planeItem, as: :planes, class: PlaneItem
  end

  class PlaneAmmunition
    include SAXMachine

    element :rockets
  end

  class PlaneParameters
    include SAXMachine

    element :h
    element :l
    element :w
  end

  class MilitaryType
    include SAXMachine

    element :places
    element :radar
    element :ammunition, class: PlaneAmmunition
  end

  class HumType
    include SAXMachine

    element :places
    element :radar
  end

  class PlaneType
    include SAXMachine

    element :humType, class: HumType, as: :type
    element :militaryType, class: MilitaryType, as: :type

  end

  class PlaneItem
    include SAXMachine

    element :id
    element :model
    element :origin
    element :price
    element :chars, class: PlaneType
  end

  class Parser
    def run(xml)
      planes_parser = Planes.new
      planes_parser.parse xml

      count = planes_parser.planes.count
      puts count

      planes_parser.planes.sort_by { |plane| plane.chars.type.places.to_f || 0}.each do |plane|
        puts "#{plane.model} with price #{plane.price} and places #{plane.chars.type.places}"
      end
    end
  end

end