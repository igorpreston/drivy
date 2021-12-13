class RentalCommission
  attr_reader :rental, :total_fee, :insurance_fee, :assistance_fee, :drivy_fee

  TOTAL_FEE = 0.3
  INSURANCE_FEE = 0.5
  ASSISTANCE_FEE = 100

  def initialize(rental:)
    @rental = rental
  end

  def to_h
    {
      insurance_fee: insurance_fee,
      assistance_fee: assistance_fee,
      drivy_fee: drivy_fee
    }
  end

  def total_fee
    (rental.price * TOTAL_FEE).to_i
  end

  def insurance_fee
    (total_fee * INSURANCE_FEE).to_i
  end

  def assistance_fee
    (rental.duration_days * ASSISTANCE_FEE).to_i
  end

  def drivy_fee
    (total_fee - insurance_fee - assistance_fee).to_i
  end
end
