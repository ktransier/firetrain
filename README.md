# FireTrain

[![Github Actions](https://github.com/ktransier/firetrain/workflows/Tests/badge.svg)](https://github.com/ktransier/firetrain/actions?query=workflow%3ATests)

A Ruby gem that supports authenticating a Rails backend with Firebase for both web and mobile applications. It includes authentication functionality for both an api access token and a session cookie.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'firetrain'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install firetrain
```

## Setup

1. Add a `User` model with `email` and `firebase_id` string attributes

2. Add the following to your application.html.erb:
```html
<head>
  <script src="https://www.gstatic.com/firebasejs/7.9.3/firebase-app.js"></script>
  <script src="https://www.gstatic.com/firebasejs/7.9.3/firebase-auth.js"></script>
  <script src="https://cdn.firebase.com/libs/firebaseui/3.5.2/firebaseui.js"></script>
  <link type="text/css" rel="stylesheet" href="https://www.gstatic.com/firebasejs/ui/4.4.0/firebase-ui-auth.css" />
  <%= javascript_include_tag 'firetrain/application' %>
</head>
```

3. Add the Authenticable module to your ApplicationController.rb:

``` ruby 
class ApplicationController < ActionController::Base
  include FireTrain::Controllers::Authenticatable
  helper FireTrain::Controllers::Authenticatable
end
```

4. Import css in `assets/stylesheets/application.css`:

```css
*= require authentication
```

5. Add the following ENV vars to your `.env`. Your Firebase config variables can be found [here](https://support.google.com/firebase/answer/7015592)

```console
FIRETRAIN_API_KEY=
FIRETRAIN_AUTH_DOMAIN=
FIRETRAIN_DATABASE_URL=
FIRETRAIN_PROJECT_ID=
FIRETRAIN_STORAGE_BUCKET=
FIRETRAIN_MESSAGING_SENDER_ID=
FIRETRAIN_APP_ID=
FIRETRAIN_MEASUREMENT_ID=
FIRETRAIN_TOS_URL=
FIRETRAIN_PRIVACY_POLICY_URL=
FIRETRAIN_TURBOLINKS_ENABLED=
```

6. Setup the following rake task to run every hour in production to refresh Firebase certificates via the included [firebase_id_token](https://github.com/fschuindt/firebase_id_token) gem:

```console
rake firebase:certificates:request
```

## Usage

#### Browser authentication
+ Users can sign in at `/auth`, this will generate a session cookie that will be used to authenticate subsequent requests.

+ Controllers can be restricted to authenticated users by adding `before_action :authenticate_session_user`

+ To display sign in and sign out links add the following to your navigation:

```erb
<%- if current_user %>
  <%= link_to 'Sign Out', sign_out_path, method: :delete %>
<%- else %>
  <%= link_to 'Sign In', auth_path %>
<%- end %>
```

#### API authentication

+ After signing in/up a user on mobile, hit the `/set_token_user` endpoint to generate a user with the Firebase access token as `HTTP_FIREBASE_TOKEN` in the request headers

+ Subsequent requests can be authenticated by passing the Firebase access token as `HTTP_FIREBASE_TOKEN`

+ Controllers can be restricted to authenticated users by adding `before_action :authenticate_api_user`

## Tests

Run:

```console
rake test
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
