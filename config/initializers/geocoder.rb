Geocoder.configure(
  lookup: :google,
  use_https: true,
  api_key: ENV.fetch('GOOGLE_GEOCODING_API_KEY', nil)
)
