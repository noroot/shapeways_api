# ShapewaysAPI Gem

## Overview
ShapewaysAPI is a Ruby gem that provides an easy-to-use wrapper for the Shapeways API. This gem allows developers to authenticate, manage 3D models, and process orders seamlessly.

Shapeways API is very limited for now https://developers.shapeways.com/quick-start

## Features
- Authenticate with the Shapeways API using OAuth2
- Fetch available materials
- Retrieve model details
- Upload 3D models
- Create order

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'shapeways_api'
```

And then execute:

```sh
bundle install
```

Or install it manually using:

```sh
gem install shapeways_api
```

## Usage

### Initialization
To use the API, initialize the `ShapewaysAPI` class with your client ID and client secret:

```ruby
require 'shapeways_api'

client_id = 'YOUR_CLIENT_ID'
client_secret = 'YOUR_CLIENT_SECRET'
shapeways = ShapewaysAPI.new(client_id, client_secret)
```

### Fetch Available Materials
```ruby
materials = shapeways.get_materials
puts materials
```

### Retrieve Model Details
```ruby
model_id = '12345'
model = shapeways.get_model(model_id)
puts model
```

### Upload a 3D Model
```ruby
file_path = 'path/to/your/model.stl'
description = 'A cool 3D printed model'
response = shapeways.upload_model(file_path, description)
puts response
```

### Create an Order
```ruby
order_data = {
  'items' => [{ 'materialId' => '6789', 'modelId' => '12345', 'quantity' => 1 }],
  'firstName' => 'John',
  'lastName' => 'Doe',
  'country' => 'US',
  'state' => 'NY',
  'city' => 'New York',
  'address1' => '419 Park Ave S',
  'address2' => 'Suite 900',
  'zipCode' => '10016',
  'phoneNumber' => '0000000000',
  'paymentVerificationId' => 'PAYMENT_VERIFICATION_ID',
  'paymentMethod' => 'credit_card',
  'shippingOption' => 'Cheapest'
}

order_response = shapeways.create_order(order_data)
puts order_response
```

## Contributing
Bug reports and pull requests are welcome on [GitHub](https://github.com/noroot/shapeways_api).

## License
This gem is available as open-source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

