# Wheels Within Wheels
It's not unusual to require a web appliation with CRUD functionality. Code, code, code. What if I told you there's an app&mdash;a CRUD app, in fact&mdash;that builds a CRUD app for you? 

Wheels Within Wheels is the robot you've been waiting for. Built in Sinatra, Wheels Within Wheels accepts some basic specifications from the user, creates a MEAN-stack CRUD app with those specs, wraps it up in a Zip file and presents a link for download.

You may never need to build another CRUD app!

Rubyists (or anyone) can use this as a tool to learn about the MEAN-stack. You can inspect the code with the application's design&mdash;*your* design&mdash;in mind.

## Web app operation, or the 'outer wheel'
Wheels Within Wheels creates a basic, single-model CRUD application with three attributes. To do so, it asks the user for the following specifications:
* Application title
* Application description
* Model name
* Three pairs of attributes and data types. At this time, the valid data types are String, Number, Date, and Boolean.
Click 'submit' and you'll be presented with a link to download the completed basic MEAN-stack application made to your specifications.

For example, let's say you're making an app for tracking Supreme Court decisions. You could proceed as follows:
<table>
	<tr><td>Title</td><td>Benchley</td></tr>
	<tr><td>Description</td><td>A pile of SCOTUS decisions </td></tr>
	<tr><td>Model name </td><td>Case </td></tr>
	<tr><td>Attribute 1</td><td>Name </td></tr>
	<tr><td>Data Type 1</td><td>String </td></tr>
	<tr><td>Attribute 2</td><td>Description </td></tr>
	<tr><td>Data Type 2</td><td>String </td></tr>
	<tr><td>Attribute 3</td><td>Decision </td></tr>
	<tr><td>Data Type 3</td><td>String </td></tr>
</table>

## Custom app operation, or the 'inner wheel'
Download and unzip your new app. To run it locally, you need to get MEAN (MongoDB, ExpressJS, AngularJS, Node.js).
* Download and install [node.js](https://nodejs.org). This will also install the command line utility npm.
* Download, install, and configure [MongoDB](https://www.mongodb.com/download-center?jmp=nav#community).
* Install Bower on the command line: `npm install -g bower`
* In your new application directory, `cd` into the `public` directory and run these two commands: `npm install` `bower install`. (AngularJS arrives with this bower command.)
* Next, `cd ..` to get back to the root of the application directory and run `npm install` here. (ExpressJS arrives with this npm command.)
* Run `node server.js`. 
* Open a browser and visit localhost:8080. Your MEAN-stack app will be running there!

## Contributions
This application is not currently under active development. I can accept pull requests for bug fixes. If you envision improvements, feel free to fork and develop.

## License
[MIT](https://github.com/amcooper/wheels-within-wheels/blob/master/LICENSE)