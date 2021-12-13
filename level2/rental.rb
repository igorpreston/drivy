class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance, :price

  def initialize(id:, car:, start_date:, end_date:, distance:)
    @id = id
    @car = car
    @start_date = start_date
    @end_date = end_date
    @distance = distance

    calculate_price!
  end

  def with_discount
    @price_over_time = (1..duration_days).map do |day|
      (car.price_per_day * apply_discount(day)).to_i
    end.sum

    calculate_price!

    self
  end

  def to_h
    {
      id: id,
      price: price
    }
  end

  private

  def calculate_price!
    @price = price_over_time + price_over_distance
  end

  def duration_days
    (start_date..end_date).map(&:mday).size
  end

  def price_over_time
    @price_over_time ||= (car.price_per_day * duration_days).to_i
  end

  def price_over_distance
    @price_over_distance ||= (car.price_per_km * distance).to_i
  end

  def apply_discount(day)
    case day
    when 1..1 then 1
    when 2..4 then 0.9
    when 4..10 then 0.7
    else
      0.5
    end
  end
end
