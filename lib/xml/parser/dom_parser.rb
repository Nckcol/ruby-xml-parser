module Dom
  require 'happymapper'

  class PlaneItem; end
  class Planes; end
  class PlaneAmmunition; end
  class PlaneParameters; end
  class PlaneType; end
  class HumType; end
  class MilitaryType; end

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

    def set_w w
      unless w > 0
        self.w = w
      end
    end

    def set_h h
      unless h > 0
        self.h = h
      end
    end

    def set_l l
      unless l > 0
        self.l = l
      end
    end
  end

  class MilitaryType
    include HappyMapper
    tag 'militaryType'
    element :places, Integer
    element :radar, Boolean
    element :ammunition, PlaneAmmunition

    def set_places places
      unless places < 1 && places > 2
        self.places = places
      end
    end
  end

  class HumType
    include HappyMapper
    tag 'humType'

    element :places, Integer
    element :radar, Boolean

    def set_places places
      unless places < 1 && places > 2
         self.places = places
      end
    end
  end

  class PlaneType
    include HappyMapper
    tag 'chars'

    element :htype, HumType
    element :mtype, MilitaryType

    def get_type
      if self.htype
        return self.htype
      end
      if self.mtype
        return self.mtype
      end
    end
  end

  class PlaneItem
    include HappyMapper
    tag 'planeItem'

    element :id, Integer
    element :model, String
    element :origin, String
    element :price, Integer
    element :chars, PlaneType


    def set_price price
      unless price >= 0
        self.price = price
      end
    end
  end

  class Parser
    def run(xml)

      parsed = Planes.parse xml, single: true

      puts "Number of devices #{parsed.planes.count}"

      puts 'Sorted by the price:'
      parsed.planes.sort_by(& :price) .each do |plane|
        puts "#{plane.model} with price #{plane.price} Places: #{plane.chars.get_type.places}"
      end

    end
  end
end
