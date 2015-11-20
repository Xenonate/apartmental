class Address < ActiveRecord::Base
def rental_average
  total_rent = 0
  if self.built.to_i < 1973
    increase = 1.019
  else
    increase = 6
  end
     rent = 0
  for i in 0..2 do
     rent += 100*(increase ** i)
  end
    rent
end

def find_increase(neighborhood)
  case neighborhood
    when ""
    when ""
    end
end


  def total

  end
end
