## Socmed

Final task for #GenerasiGigih 2021

### Problem

You are tasked with developing a social media application which can be used to share information with other people. This application will only be used by people that work in a certain company so we cannot use existing public social media.

This is an API only application with the following stories:

 - As a user, I want to save my username, email, and bio description.
    - Authentication and authorization is out of scope of this story and you don’t need to implement them
 
 - As a user, I want to post a text that might contain hashtag(s).
    - Maximum limit of a text is 1000 characters
    - A hashtag is a text that is followed by # symbol, for instance: #generasigigih
 
 - As a user, I want to see all posts that contain a certain hashtag.
    - A user can only filter by one hashtag at a time

 - As a user, I want to see the list of trending hashtags.
    - Trending hashtags are the top 5 most posted hashtags in the past 24 hours
    - A post containing multiple instances of a hashtag only counts as 1 occurrence for trending hashtags calculation

 - As a user, I want to comment on a post
    - A comment can contain hashtag(s)
    - A hashtag occurrence in a comment is counted in trending hashtags calculation
    
 - As a user, I want to attach things to a post
    - Three kinds of attachment are allowed: pictures (jpg, png, gif), video (mp4), and file (any other extensions outside of pictures and videos)


### Prerequisites

 - ruby
 - sinatra
 - mysql
 - rspec
 - simplecov
 
### Database Schema 

![Database Scheema](/erd.png)

### How to run

#### clone this repository

 - use https
 ```
 git clone https://github.com/edinugroho/socmed.git
 ```
 - use ssh
 ```
 git clone git@github.com:edinugroho/socmed.git
 ```

#### go to directory

```
cd socmed
```

#### install dependencies 

```
bundler install
```

#### import database 

 - create database
 - import database from [This SQL](https://github.com/edinugroho/socmed/blob/main/app/db/socmed_db.sql) file
    ```
    mysql -u username -p database_name < socmed_db.sql
    ```

#### set env
 
 - copy .env.examole file to .env
    ```
    cp .env.example .env
    ```
 - edit inside .env file if use nano for editors use this command
    ```
    nano .env
    ```
 - adjust to your configuration
 - exit and save file
 - import env by this command
    ```
    source .env
    ```

#### run test

```
rspec --pattern=spec/*/*_spec.rb -fd
```

#### serve app

```
ruby app/main.rb
```

### Postman collection

[Postman Collection](https://github.com/edinugroho/socmed/blob/main/Final%20Task%20GenerasiGigih.postman_collection.json)
