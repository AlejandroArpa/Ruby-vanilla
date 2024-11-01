# 💎 My first Ruby project 

## Description
  In this project I built an API with RESTful standart using Ruby vanilla, to understand the underlying mechanisms in Rails 🧞, I hope in a future come back and turn it this project in a mini framework, that can recive a relational model and transform in a backend to fast, using the CLI. 

  The goal is have an intermediate solution between JSON server and a fully-featured backend, and get a fast tool, special for front developers.👾

### Requeriments 📝
  * Ruby installed (prefered 3.3.5 LTS at 1/11/24) 
  * All necessary gems installed.

### Running the project 🚀
  1. Install project's gems
  ```bash
    bundle install
  ```

 2. Set up the database:

    * Ensure you have a MySQL database.
    * Update app/config/database.yml with your database credentials.
  3. Create the database:
  ```bash
    RACK_ENV=development rake db:create   
  ```

  3. Start the server: If everything is set up correctly, you should be able to run:
  ```bash
    puma
  ```

### Run test: (under constrution) 🚧🔜
  To run tests (when available):
```bash
  bundle exec ruby test_my_app.rb
```
