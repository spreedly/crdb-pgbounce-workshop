# README

## Overview
This is a sample project that demonstrates pgbouncer as an application for providing connection pooling as a service between a ruby/rails application and postgres style database with limited resources.

## Requirements

This project was built with `Rails 5.2.8` , `ruby 2.7.5p203` , `cockroach: v21.2.4` , `PgBouncer 1.17.0`
This project may work with future versions
This project was run/developed/tested on Mac OsX some commands (brew) are specific

## Setup

Install required languages and packages
- cockrocahdb cli installation - https://www.cockroachlabs.com/docs/stable/install-cockroachdb-mac.html
- pgbouncer installation - `brew install pgbouncer` on mac

To start the project from the root of this project:
```
bundle install

cockroach start-single-node --advertise-addr 'localhost' --insecure --background --max-sql-memory=4000000

pgbouncer pgbouncer.ini

rake db:create db:migrate db:seed

bundle exec unicorn -p 3000 -c ./config/unicorn.rb

```

At this point you should be able to navigate to http://localhost:3000/fish and see a dafault page showing some information about fish

To add a few seed fish into the database you can run `rake db:seed` to add the first 10 fish

## Testing
The two areas of testing we will look at through the lens of errors and throughput (using Jmeter) will be

- /config/unicorn.rb:3 - the number of unicorn workers
- /config/database.yml - the database configuration (pointing either to cockroachdb directly Or through pgbouncer) 
- pgbouncer.ini:16 - the number of connections between pgbouncer and cockroachdb

## Configurations And Tests

Below are a few simple configurations you can run to test different connection topologies
You can use the included Jmeter `.jmx` file with the concurrent thread plugin to simulate 50 simultanious connections and load test the application under the below scenarios

### Scenario 1 (default)
Direct connection between the application and cockroach db with 8 unicorn workers

### Scenario 1b
Direct connection between the application and cockroach db with 32 unicorn workers should fail to start

Reconfigure the number of unicorn workers in unicorn.rb to 32 and when you run the `bundle exec` command above to start the application it should fail with some form of out of memory exception

IF the application does start you should see intermittent or complete failures when you visit localhost:3000/fish
### Scenario 2 - PgBouncer

Starting from scenario 1b you can update config/database.yml to point to pgbouncer by commenting out the upper block and commenting In the second block

Now after you start the applicaiton you can restart the application and it should begin working properly

## Utilities

A command to insert lots of fish into the database can be run from a cockrochdb or postgres sql prompt to help simulate greater load for the select statement on the /fish page


```
insert into fish (title, body, fins, school, created_at, updated_at) select 'tester', 'boah', 2, 'service', now(), now() FROM generate_Series(1,1000);
```
