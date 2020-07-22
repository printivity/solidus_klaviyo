# frozen_string_literal: true

SolidusKlaviyo.configure do |config|
  # Your Klaviyo API key, in order to communicate with the Klaviyo API.
  config.api_key = 'YOUR_KLAVIYO_API_KEY'

  # A proc that accepts a variant and returns the URL of that variant's PDP.
  config.variant_url_builder = proc do |variant|
    "https://example.com/products/#{variant.product.slug}"
  end

  # A proc that accepts a variant and returns the URL of that variant's main image.
  config.image_url_builder = proc do |variant|
    image = variant.gallery.images.first
    image&.attachment&.url(:product)
  end

  # A Klaviyo list that all users will be subscribed to when they sign up.
  # config.default_list = 'KLAVIYO_LIST_ID'

  # You can register custom events or override the defaults by manipulating the `events` hash.
  # config.events['my_custom_event'] = MyApp::KlaviyoEvents::MyCustomEvent
  # config.events['placed_order'] = MyApp::KlaviyoEvents::PlacedOrder
end
