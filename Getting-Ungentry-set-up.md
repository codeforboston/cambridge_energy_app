Live example: [ungentry.codeforboston.org](ungentry.codeforboston.org)

You've found a place to plug in, and you want to jam on some code... Great!
The details below will help you get the project up and running locally on your computer so you can make changes and push them up to the main project.


## Running Ungentry locally
Whether you want to help build the original, or make your own version, you need to get a copy working on your computer.  The steps below will get you there.  It's a little bit of an involved process, but it doesn't take too long, and you only have to do it once. :)
### Set up your computer

##### Mac or Linux

1. Open the Terminal application.

2. Make sure the command-line tool Git is installed by entering `which git` into Terminal. If the command returns a filepath, you're all set. (If Git is not installed, [install it](http://git-scm.com/book/en/Getting-Started-Installing-Git).)

##### Windows

1. Open the command prompt (click the start button, open the command prompt by typing `cmd` in the "search programs and files" box, and hitting enter.

2. Make sure the command-line tool Git is installed by entering `git --version` into Terminal. If the command returns a version number, you're all set. (If Git is not installed,
[Install Git for Windows](http://git-scm.com/book/en/Getting-Started-Installing-Git)).


### Copy the code to your computer.

1. Navigate to the folder you'd like to copy the code to by using the `cd` command.

2. Clone the repository (i.e. copy the code) from where it's hosted online. Do this by entering `$ git clone git@github.com:codeforboston/ungentry.git` at the command line.

3. Open the folder you just downloaded using your favorite text editor. (We use [Sublime Text](http://www.sublimetext.com/).)

### Installing dependencies

In order to build and test the project, you'll need to download software packages (they are defined in the file  `package.json`). Thankfully, [Node](http://nodejs.org/) package manager (aka npm) does the hard work with a single command (if you don't have Node/npm installed, do it now via the download package, Homebrew or another option before proceeding):

* `cd` into your repo directory and run `$ npm install`.

### Running the server

We have preconfigured an HTTP server for Ungentry using [Gulp](http://gulpjs.com/).  It serves your local site to the browser and also watches your files so that the browser will refresh every time you save.


* Make sure you have Gulp installed globally: `$ npm install -g gulp`

* At the command line, simply run `$ gulp`.

Once you've started Gulp, you should see Ungentry at [http://localhost:3000](http://localhost:3000)!

### Add your data.

(The project already has the main metro-Boston data set, if you're just trying to get it running, or want to tweak it you can use this data.)

Ungentry requires that your data is in topoJSON format, since it's an open, web-friendly format and saves to smaller files than geoJSON when using large polygons.

Our basic Java utility creates the topoJSON tiles at a full complement of zoom levels. For more info see the page on [data generation](Data Generation). 



### Style the application.

You can edit the display of your application using `style.css` in the `src` directory.

We use plain CSS3 so it is pretty straightforward. 



### Testing (after installing dependencies)

We are working on creating unit tests for Ungentry.  If you would like to help with that, check out issue #29


### Deploy
So you have everything looking the way you want now?  Check out the [page on Deployment](Deployment) to see how to get your page out there
