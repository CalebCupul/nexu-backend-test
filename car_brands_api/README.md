# Car Brands API

This is a Rails application for managing car brands and their models. The application provides a simple API with endpoints to create, read, update, and list car brands and their associated models.

## Prerequisites

- Ruby 3.2.4
- Rails 7.1.3
- SQLite 1.4

## Getting Started

### Cloning the Repository

```
git clone https://github.com/CalebCupul/nexu-backend-test.git
cd your-repo
```
### Installing Dependencies
Make sure you have Bundler installed:
```
gem install bundler

```
Install required gems:
```
bundle install

```
### Setting Up the Database
Make sure you have Bundler installed:
```
rails db:create
rails db:migrate
```
(Optional) Seed the database with initial data:


```
rails db:seed
```

### Running the Application
Start the Rails server:
```
rails server
```

## Running Tests
Prepare the test database:

```
rails db:test:prepare
```
Run the tests:
```
rspec
```

## API Endpoints
```
GET    /brands
GET    /brands/:id/models
POST   /brands
POST   /brands/:id/models
PUT    /models/:id
GET    /models
```

#### GET /brands

List all brands 
```json
[
  {"id": 1, "name": "Acura", "average_price": 702109},
  {"id": 2, "name": "Audi", "average_price": 630759},
  {"id": 3, "name": "Bentley", "average_price": 3342575},
  {"id": 4, "name": "BMW", "average_price": 858702},
  {"id": 5, "name": "Buick", "average_price": 290371},
  "..."
]
```
The average price of each brand is the average of its models average prices

#### GET /brands/:id/models

List all models of the brand
```json
[
  {"id": 1, "name": "ILX", "average_price": 303176},
  {"id": 2, "name": "MDX", "average_price": 448193},
  {"id": 1264, "name": "NSX", "average_price": 3818225},
  {"id": 3, "name": "RDX", "average_price": 395753},
  {"id": 354, "name": "RL", "average_price": 239050}
]
```

#### POST /brands

You may add new brands. A brand name must be unique.

```json
{"name": "Toyota"}
```

If a brand name is already in use return a response code and error message reflecting it.


#### POST /brands/:id/models

You may add new models to a brand. A model name must be unique inside a brand.

```json
{"name": "Prius", "average_price": 406400}
```
If the brand id doesn't exist return a response code and error message reflecting it.

If the model name already exists for that brand return a response code and error message reflecting it.

Average price is optional, if supply it must be greater than 100,000.


#### PUT /models/:id

You may edit the average price of a model.

```json
{"average_price": 406400}
```
The average_price must be greater then 100,000.

#### GET /models?greater=&lower=

List all models. 
If greater param is included show all models with average_price greater than the param
If lower param is included show all models with average_price lower than the param
```
# /models?greater=380000&lower=400000
```
```json
[
  {"id": 1264, "name": "NSX", "average_price": 3818225},
  {"id": 3, "name": "RDX", "average_price": 395753}
]
```

