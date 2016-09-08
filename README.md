# The Iron Yard Tampa / St Pete

# Intro to Ruby on Rails

# Crash Course

These are the steps we will walk through during our Crash Course app building tonight.

Please follow along with the instructor.

## Food Trucks!

I love food trucks even though the city of St Pete does not. Lets build an app to catalog the various food trucks in town and give them a way to show their location on a handy map.

This app will use the [bootstrap](getbootstrap.com) HTML, CSS, and JS framework as the basis of our design.

## Step 1

We use a tool called `bundler` to manage `gems` (libraries) that we use in our application.

`bundle install`

## Step 2

Rails comes with `generators` for quickly generating code/migrations/controllers/views.

Here we will generate all the needed components for managing our `Truck` data

This will include:
- `name`: The name of our food truck
- `location`: The street address
- `latitude`: The latitude of the location
- `longitude`: The longitude of the location

`rails g scaffold Truck name:string location:string latitude:float longitude:float`

`rake db:migrate`

*NOTE* If running locally you may need to `rake db:create db:migrate`

## Step 3

Lets go try our app!

## Step 4

Add some code to ensure a name and a location

In `app/models/truck.rb` add these lines between `class Truck` and `end`

```ruby
validates :name, presence: true
validates :location, presence: true
```

## Step 5

Lets have the computer automatically figure out the latitude / longitude of our truck!

In `app/models/truck.rb` add these lines between `class Truck` and `end`

```ruby
geocoded_by :location
after_validation :geocode
```

## Step 6

Our app doesn't have a proper home page yet, lets give it one with a map!

`rails generate controller Pages home`

## Step 7

Add this to `config/routes.rb`

```ruby
root 'pages#home'
```

after the line `Rails.application.routes.draw do`

## Step 8

Visit our app again, seeing that we have a home page, albeit boring.

## Step 9

In the file `app/controllers/pages_controller`

between `def home` and `end` add the following

```ruby
  @trucks = Truck.where.not(latitude: nil).where.not(longitude: nil)
```

So the file looks like:

```
class PagesController < ApplicationController
  def home
    @trucks = Truck.where.not(latitude: nil).where.not(longitude: nil)
  end
end
```

## Step 10

Add the file `app/assets/stylesheets/map.scss`

```
#map {
  height: 600px;
}

.map-image {
  width: 100px;
  height: 100px;
}
```

## Step 11

Edit the file `app/views/pages/home.html.erb` replacing the contents with

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.3/leaflet.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.3/leaflet.css" />

<div id="map"></div>

<script>
var map = L.map('map').setView([27.768, -82.633], 10);
L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
  attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
  maxZoom: 18,
  id: 'gavinstark.806a776b',
  accessToken: 'pk.eyJ1IjoiZ2F2aW5zdGFyayIsImEiOiIxZjVmODFhYWQ2NjIyZGY1MTQ5MzM3ZTE2MWNkMDkxMiJ9.HG1IbUfea4FfcJ0WrY7Pqg'
}).addTo(map);
<% @trucks.each do |truck| %>
  var marker = L.marker([<%= truck.latitude %>, <%= truck.longitude %>]).addTo(map);
  marker.bindPopup('<%= link_to truck.name, truck_path(truck) %><br/><%= truck.location %><br/>');
<% end %>
</script>
```

## Step 12

*Profit!*
