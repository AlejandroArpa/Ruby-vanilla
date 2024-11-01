# 💎 My first Ruby project 

## Description
  In this project I build an API with RESTapi standart using Ruby vanilla, to try understand wath's the background in Rails, I really hope in a feature come back and turn this project in a mini framework, that can recive a relational model and transform in a backend to fast, using the cli. 

  The goal is have an intermediate point between JSON server and a real backend.👾

### Requeriments 📝
  Have installed Ruby (prefered 3.3.5 LTS at 1/11/24) 
  Have already install all the basic gems

### Running the project 🚀
  The first step is install project's gems
  ```bash
    bundle install
  ```

  After that you must have a MySQL databe and change the file app/config/database.yml with your credentials.

  ```bash
    RACK_ENV=development rake db:create   
  ```

  Finally and everithing is fine, you should be available tu run
  ```bash
    puma
  ```

### Run test: (under constrution)
```bash
  bundle exec ruby test_my_app.rb
```
