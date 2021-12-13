class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance

  def initialize(id:, car:, start_date:, end_date:, distance:)
    @id = id
    @car = car
    @start_date = start_date
    @end_date = end_date
    @distance = distance
  end

  def price
    price_over_time + price_over_distance
  end

  def to_h
    {
      id: id,
      price: price
    }
  end

  private

  def duration_days
    (start_date..end_date).map(&:mday).size
  end

  def price_over_time
    @price_over_time ||= (car.price_per_day * duration_days).to_i
  end

  def price_over_distance
    @price_over_distance ||= (car.price_per_km * distance).to_i
  end
end
