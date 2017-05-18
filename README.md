## Music Festival App

#### A music festival app that personalizes music festival schedule, 05/15/17


#### By **Susha Dore,Sowmya Dinavahi,Steven Galvin,Monique St Laurent**


## Description

A web app that allows producers to add festival schedule details to a password protected database. The database stores stage and artist information and assigns artists to stages based on a unique performance time for that stage. Festival attendees can personalize a festival schedule using database records in order to keep track of artists and stages.

## Specifications
|Description|Input|Output|
|----------|:--------:|:---------|
|User authentication for both producer and attendee|login information|access to website|
|Producer addition, list, update and deletion of artist including artist bio|Create: The Eels|The Eels: They have a bio|
|Producer addition, list, update and deletion of stage|Create: Acura| Stages: Acura|
|Producer add performances to artist and stage|The Eels, Acura, 8:30 pm 8/8/2018| Acura Stage: The Eels, 8:30 pm 8/8/2018|
|Attendee can add specific artists to personal festival page|Check artists you are interested in| The Eels Acura stage, Wilco Fox stage|

##### Stretch goals
* Producer specific authentication.
* Automated artist deletion upon final performance.
* Attendee ability to organize stage locations.
* Attendee reviews on the artist's performance.
* Attendee alert notification of favorite artist's performance a half an hour before they go on stage.

## Setup/Installation Requirements

* clone the git repository
* navigate to the directory in your terminal
* run the following commands to create the database and tables
* `bundle`
* `rake db:create`
* `rake db:migrate`
* `rake db:schema:load`
* `ruby app.rb`
* Open localhost:4567 in chrome.

## Known Bugs

No known bugs as of now.

## Support and contact details

Feel free to contact me

## Technologies Used

* Ruby
* Sinatra
* HTML
* CSS
* Bootstrap https://getbootstrap.com/
* ES6
* Jquery https://jquery.com/
* Activerecord

### License

MIT open source


Copyright (c) 2017 **Susha Dore,Sowmya Dinavahi,Steven Galvin,Monique St Laurent**

No known bugs as of now.

## Support and contact details

Feel free to contact me

## Technologies Used

* Ruby
* Sinatra
* HTML
* CSS
* Bootstrap https://getbootstrap.com/
* ES6
* Jquery https://jquery.com/
* Activerecord

### License

MIT open source


Copyright (c) 2017 **Susha Dore,Sowmya Dinavahi,Steven Galvin,Monique St Laurent**
