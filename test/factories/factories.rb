Factory.define :user do |u|
  u.first_name 'Test'
  u.last_name 'User'
  u.sequence(:email) { |n| "factory_#{n}@example.com" }
  u.password '123abc'
  u.confirmed_at DateTime.now
end

Factory.define :listing do |l|
  l.title 'Listing X'
  l.state 'open'
  l.latitude 0.0
  l.longitude 0.0
  l.reverse_geocode 'a'
  l.last_seen_at 1.hour.ago
  l.user { Factory(:user) }
end

Factory.define :external_photo do |p|
  p.listing { Factory(:listing) }
  p.raw_url "http://i.imgur.com/F7u12.jpg"
end