class GoogleMaps
  require 'google_maps_service'

  API_KEY = 'AIzaSyAPpSJKHvHzT5K7z_Z8dlDyS57v911yU7o'.freeze

  def initialize
    @map_service = GoogleMapsService::Client.new(key: API_KEY)
  end

  def distances(origin, destinations=[], mode: 'driving', units: 'imperial')
    return '' unless origin.present? && destinations.any?

    @map_service.distance_matrix(
      origin,
      destinations,
      mode: mode,
      units: units
    )
  end

  def shortest_distance(origin, destinations=[], mode: 'driving', units: 'imperial')
    distance_hash = distances(origin, destinations, mode: mode, units: units)
    return nil if distance_hash.blank?

    row = Array(distance_hash[:rows]).first
    return nil unless row.is_a?(Hash)

    elements = Array(row.fetch(:elements, []))
    return nil if elements.empty?

    min_value = elements.map { |r| r[:duration][:value] }.min
    return nil if min_value.blank?

    element = elements.find { |r| r[:duration][:value] == min_value }
    element_index = elements.find_index(element)

    duration = element[:duration][:text]
    address = Array(distance_hash[:destination_addresses])[element_index]
    
    {
      duration: duration || 'Not found - please try again',
      address: address || 'Not found - please try again'
    }
  end
end
