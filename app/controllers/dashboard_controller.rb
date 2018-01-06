class DashboardController < ApplicationController
  def index
  end

  def drive_time
    kitchens = ClusterTruck.new.kitchens
    destinations = kitchens.map { |k| k[:location] }

    map_service = GoogleMaps.new
    shortest_distance = map_service.shortest_distance(params[:address], destinations)

    render json: { kitchen: shortest_distance }
  end
end
