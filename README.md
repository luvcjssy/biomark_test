# README

This README would normally document whatever steps are necessary to get the
application up and running.

The setups steps expect following tools installed on the system.

- Github
- Ruby 2.6.5
- Rails 6.0.3

##### 1. Check out the repository

```bash
git@github.com:luvcjssy/biomark_test.git
```

##### 2. Go to project directory

```bash
cd <path_to_project>
```

##### 3.Running

###### 3.1 With Docker

- Install Docker at [here](https://docs.docker.com/get-docker/)

- Running command

  ```ruby
  docker-compose build
  docker-compose up
  ```
  
- Open other terminal to create DB with command

  ```ruby
  docker-compose run --rm biomark_app rails db:create
  docker-compose run --rm biomark_app rails db:migrate
  ```
  
###### 3.2 On local

- Run `bundle install` to install missing gems

- Edit the database configuration in `config/database.yml` 

- Create DB

```ruby
bundle exec rake db:create
bundle exec rake db:migrate
```

- Start the Rails server with command `rails s`


### APIs doc

Parser payload API

```ruby
curl --location --request POST 'localhost:3000/api/v1/parsers' \
--header 'Content-Type: application/json' \
--data-raw '{
    "payload": {{payload format data}}
}'
```

Example payload formats

Case 1

```ruby
{
  "payload": {
    "date_of_test": "20210227134300",
    "id_number": "IC000A2",
    "patient_name": "Patient A4",
    "gender": "F",
    "date_of_birth": "19940231",
    "lab_number": "QT196-21-124",
    "clinic_code": "QT196",
    "lab_studies": [
      {
        "code": "2085-9",
        "name": "HDL Cholesterol",
        "value": "cancel",
        "unit": "mg/dL",
        "ref_range": "> 59",
        "finding": "A",
        "result_state": "F"
      }
    ]
  }
}
```

Case 2

```ruby
{
  "patient_data": {
    "id_number": "IC000A3",
    "first_name": "Patient",
    "last_name": "A5",
    "phone_mobile": "+6500000000",
    "gender": "M",
    "date_of_birth": "19940228"
  },
  "date_of_test": "20210227134300",
  "lab_number": "QT196-21-124",
  "clinic_code": "QT196",
  "lab_studies": [
    {
      "code": "2085-9",
      "name": "HDL Cholesterol",
      "value": "cancel",
      "unit": "mg/dL",
      "ref_range": "> 59",
      "finding": "A",
      "result_state": "F"
    }
  ]
}
```