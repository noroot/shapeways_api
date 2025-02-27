require 'net/http'
require 'uri'
require 'json'
require 'base64'

class ShapewaysAPI
  BASE_URL = 'https://api.shapeways.com'

  def initialize(client_id, client_secret)
    @client_id = client_id
    @client_secret = client_secret
    @access_token = authenticate
  end

  def authenticate
    uri = URI("#{BASE_URL}/oauth2/token")
    request = Net::HTTP::Post.new(uri)
    request.basic_auth(@client_id, @client_secret)
    request.set_form_data('grant_type' => 'client_credentials')

    response = send_request(uri, request)
    response['access_token']
  end

  def materials
    uri = URI("#{BASE_URL}/materials/v1?")
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{@access_token}"

    send_request(uri, request)
  end

  def get_model(model_id)
    uri = URI("#{BASE_URL}/models/#{model_id}/v1?")
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{@access_token}"

    send_request(uri, request)
  end

  def upload_model(file_path, description)
    file_name = File.basename(file_path)
    file_data = File.read(file_path)
    encoded_file = Base64.strict_encode64(file_data)

    uri = URI("#{BASE_URL}/models/v1")
    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{@access_token}"
    request['Content-Type'] = 'application/json'

    model_upload_data = {
      'fileName' => file_name,
      'file' => encoded_file,
      'description' => description,
      'hasRightsToModel' => 1,
      'acceptTermsAndConditions' => 1
    }.to_json

    request.body = model_upload_data
    send_request(uri, request)
  end

  # Creates an order using the provided order_data
  # order_data should be a hash with the following structure:
  # {
  #   'items' => [{ 'materialId' => material_id, 'modelId' => model_id, 'quantity' => 1 }],
  #   'firstName' => 'John',
  #   'lastName' => 'Doe',
  #   'country' => 'US',
  #   'state' => 'NY',
  #   'city' => 'New York',
  #   'address1' => '419 Park Ave S',
  #   'address2' => 'Suite 900',
  #   'zipCode' => '10016',
  #   'phoneNumber' => '0000000000',
  #   'paymentVerificationId' => 'YOUR_PAYMENT_VERIFICATION_ID',
  #   'paymentMethod' => 'credit_card',
  #   'shippingOption' => 'Cheapest'
  # }
  def create_order(order_data)
    uri = URI("#{BASE_URL}/orders/v1")
    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{@access_token}"
    request['Content-Type'] = 'application/json'

    request.body = order_data.to_json
    send_request(uri, request)
  end

  private

  def send_request(uri, request)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    JSON.parse(response.body)
  end
end
