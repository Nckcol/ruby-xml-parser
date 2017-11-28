module Dom
  require 'happymapper'

  class PlaneItem; end
  class Planes; end
  class PlaneAmmunition; end
  class PlaneParameters; end
  class PlaneChars; end

  class Planes
    include HappyMapper
    tag 'planes'

    attribute :xmlns, String
    has_many :planes, PlaneItem, tag: 'planeItem'
  end

  class PlaneAmmunition
    include HappyMapper
    tag 'ammunition'

    element :rockets, Integer
  end

  class PlaneParameters
    include HappyMapper
    tag 'parameters'

    element :h, Integer
    element :l, Integer
    element :w, Integer
  end

  class PlaneChars
    include HappyMapper
    tag 'chars'

    element :type, String
    element :places, Integer
    element :radar, Boolean
    element :ammunition, PlaneAmmunition
  end

  class PlaneItem
    include HappyMapper
    tag 'planeItem'

    element :id, Integer
    element :model, String
    element :origin, String
    element :price, Integer
    element :chars, PlaneChars
  end

  class Parser
    def run(xml)

      parsed = Planes.parse xml, single: true

      puts "Number of devices #{parsed.planes.count}"

      puts 'Sorted by the price:'
      parsed.planes.sort_by(& :price) .each do |plane|
        puts "#{plane.model} with price #{plane.price}"
      end

    end
  end
end
