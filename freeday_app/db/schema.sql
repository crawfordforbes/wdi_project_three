-- easy db reset -- 
DROP TABLE events;
DROP TABLE activities; 
DROP TABLE windows;
DROP TABLE memberships; 
DROP TABLE people; 
-- run script using command 
-- $ psql -d <db_name> -a -f path/to/schema.sql/file 
-- these lines delete all entries, tables & recreates these tables,  
-- useful for changing tables, running the script for the first time 
-- will simply produce a warning & create the tables   

CREATE TABLE events(
  id SERIAL PRIMARY KEY, 
  name VARCHAR(150),
  zipcode VARCHAR(5), 
  deadline date 
);

CREATE TABLE activities(
  id SERIAL PRIMARY KEY, 
  event_id INTEGER, 
  upvotes INTEGER, 
  name VARCHAR(500),
  address VARCHAR(500), -- combo of city and address
  url VARCHAR(500),
  description TEXT,
  window_id INTEGER -- activity date
);

CREATE TABLE windows(
  id SERIAL PRIMARY KEY, 
  event_id INTEGER, 
  upvotes INTEGER, 
  day date 
); 

CREATE TABLE memberships(
  id SERIAL PRIMARY KEY, 
  people_id INTEGER, 
  event_id INTEGER 
); 

CREATE TABLE people(
  id SERIAL PRIMARY KEY, 
  name VARCHAR(150), 
  email VARCHAR(150)
); 