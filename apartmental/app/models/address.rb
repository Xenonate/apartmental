class Address < ActiveRecord::Base
def rental_average(length_of_stay)

  total_rent = 0
  if self.built.to_i < 1973
    predicted_increase = 0.019
  else
    predicted_increase = 1
  # hash with neighborhoods and zestimate price increases
  end


    for i in 1..length_of_stay
      total_rent += self.price.to_i * ((1 + predicted_increase) **i)
    end
    p total_rent
    p length_of_stay
    (total_rent/length_of_stay).round(0)
end


end
