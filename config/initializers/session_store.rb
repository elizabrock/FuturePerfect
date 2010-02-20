# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_FuturePerfect_session',
  :secret => '29b4fe9f36d3c1f91cffd2ceb0ae27334b8c3c41dc0ab1afef74a38fced3cce8e24d733561eab90780c3001a94ea4e70d81241a95b468c09aad05c38e007384d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
