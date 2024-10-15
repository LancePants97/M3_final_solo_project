# M3 FINAL PROJECT README

LEARNING GOALS
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

HOW TO CLONE REPO
- In terminal, run: "git clone git@github.com:LancePants97/M3_final_solo_project.git"
- In terminal, run: "bundle install"
- In terminal, run: "rails db:{drop,create,migrate}"

RUN ALL TESTS
- In terminal: run: "bundle exec rspec"
- In terminal: run: "open coverage/index.html"

API KEY
- To see how to retrieve your API key, see 'ENDPOINT 3' below

ENDPOINTS
ENDPOINT 1: Retrieve weather for a city
- GET /api/v1/forecast?location=(city/town and state abbreviation go here - like 'cincinnati,oh')
- example: GET /api/v1/forecast?location=cincinnati,oh

ENDPOINT 2: User Registration
- POST /api/v1/users
Must include email, password, and password confirmation in body to get a response
Body: 
{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}

Response:
{
  "data": {
    "type": "user",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}

ENDPOINT 3: Login
- POST /api/v1/sessions
Must include email, and password in body to get a response
Body:
{
  "email": "whatever@example.com",
  "password": "password"
}

Response:
{
  "data": {
    "type": "user",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11" (NOTE: this is not a real api key)
    }
  }
}

ENDPOINT 4: Road Trip
- POST /api/v1/road_trip
Must include origin, destination, and api_key in body to get a response
Body:
{
  "origin": "Cincinnati,OH",
  "destination": "Chicago,IL",
  "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11" (NOTE: this is not a real api key)
}
Response:
{
    "data": {
        "id": "null",
        "type": "road_trip",
        "attributes": {
            "start_city": "Cincinnati, OH",
            "end_city": "Chicago, IL",
            "travel_time": "04:40:45",
            "weather_at_eta": {
                "datetime": "2024-09-25 23:00",
                "temperature": 44.2,
                "condition": "Cloudy with a chance of meatballs"
            }
        }
    }
}


