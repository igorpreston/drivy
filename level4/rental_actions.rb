require './rental_action'

class RentalActions
  attr_reader :rental, :actions

  def initialize(rental:)
    @rental = rental
    @actions = []
  end

  def call
    debit_driver!
    credit_owner!
    credit_insurance!
    credit_assistance!
    credit_drivy!

    self
  end

  def to_h
    actions.map(&:to_h)
  end

  private

  def debit_driver!
    actions.push(RentalAction.new(who: 'driver', type: 'debit', amount: rental.price))
  end

  def credit_owner!
    actions.push(RentalAction.new(who: 'owner', type: 'credit', amount: rental.price - rental.commission.total_fee))
  end

  def credit_insurance!
    actions.push(RentalAction.new(who: 'insurance', type: 'credit', amount: rental.commission.insurance_fee))
  end

  def credit_assistance!
    actions.push(RentalAction.new(who: 'assistance', type: 'credit', amount: rental.commission.assistance_fee))
  end

  def credit_drivy!
    actions.push(RentalAction.new(who: 'drivy', type: 'credit', amount: rental.commission.drivy_fee))
  end
end
