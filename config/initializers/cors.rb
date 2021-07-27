Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://my-retail-api-consumer-site.herokuapp.com'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end
end