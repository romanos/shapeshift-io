module Shapeshift
  
  class ShapeshiftError   < StandardError;    end
  class HTTPError         < ShapeshiftError;  end
  class NoDemandError     < ShapeshiftError;  end

end