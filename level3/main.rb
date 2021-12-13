require 'date'
require 'json'

require './car'
require './rental'

class Main
  attr_reader :input_data

  DEFAULT_INPUT_FILE_NAME = 'data/input.json'.freeze
  DEFAULT_OUTPUT_FILE_NAME = 'data/output.json'.freeze

  def initialize
    @input_data = JSON.parse(File.read(DEFAULT_INPUT_FILE_NAME))
  end

  def call
    File.open(DEFAULT_OUTPUT_FILE_NAME, 'w') do |file|
      file.write(
        JSON.pretty_generate({
          rentals: rentals.map(&:to_h)
        })
      )
    end
  end

  private

  def cars
    @cars ||= input_data['cars'].each_with_object({}) do |car, cars|
      cars[car['id']] = Car.new(
        id: car['id'],
        price_per_day: car['price_per_day'],
        price_per_km: car['price_per_km']
      )
    end
  end

  def rentals
    @rentals ||= input_data['rentals'].map do |rental|
      Rental.new(
        id: rental['id'],
        car: cars[rental['car_id']],
        start_date: Date.parse(rental['start_date']),
        end_date: Date.parse(rental['end_date']),
        distance: rental['distance']
      ).with_discount.with_commission
    end
  end
end

Main.new.call
