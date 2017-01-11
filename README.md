# Wheels Within Wheels
It's not unusual to require a web appliation with CRUD functionality. Code, code, code. What if I told you there's an app&mdash;a CRUD app, in fact&mdash;that builds a CRUD app for you? 

Wheels Within Wheels is the robot you've been waiting for. Built in Sinatra, Wheels Within Wheels accepts some basic specifications from the user, creates a MEAN-stack CRUD app with those specs, wraps it up in a Zip file and presents a link for download.

You may never need to build another CRUD app!

Rubyists (or anyone) can use this as a tool to learn about the MEAN-stack. You can inspect the code with the application's design&mdash;*your* design&mdash;in mind.

## Visit on the Web
(The public URL will be posted by the end of January 2017.)

## Run it locally
Want to run it locally? No problem.

1. Ruby is required. It comes standard on Mac and Linux. If you're on Windows, check out [RubyInstaller](https://rubyinstaller.org/).
2. Clone this repository.
3. `gem install bundler` to install the Bundler gem (if you don't already have it) and then, from the root of the new directory, `bundle install`.
4. Run `shotgun` to launch the app!
5. Go to the browser and navigate to localhost:9393
6. And you're up and running!

## Web app operation, or the 'outer wheel'
You're going to be looking at a basic CRUD app with user válidation. To create a new single-model, three-attribute CRUD app object, you'll be asked for the following:
* Application title
* Application description
* Model name (e.g., book)
* Three pairs of attributes and data types (e.g., title, String; author, String; finished, Boolean)
Click 'submit' and you'll be presented with a link to download the completed basic MEAN-stack application made to your specifications. 

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