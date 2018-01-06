class ClusterTruck
  include HTTParty
  base_uri 'https://api.staging.clustertruck.com/api'.freeze

  BASE_HEADERS = {
    'Accept' => 'application/vnd.api.clustertruck.com; version=2'
  }

  def initialize(options={})
    headers = BASE_HEADERS.merge(options.delete(:headers) || {})
    @options = options.merge({ headers: headers, format: :plain })
  end

  def kitchens
    response = self.class.get("/kitchens", @options)
    JSON.parse(response, symbolize_names: true)
  end
end
