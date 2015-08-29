Live example: [____.codeforboston.org](____.codeforboston.org)

You've found a place to plug in, and you want to jam on some code... Great!
The details below will help you get the project up and running locally on your computer so you can make changes and push them up to the main project.


## Running ____ locally
Whether you want to help build the original, or make your own version, you need to get a copy working on your computer.  The steps below will get you there.  It's a little bit of an involved process, but it doesn't take too long, and you only have to do it once. :)
### Set up your computer

##### Mac or Linux

1. Open the Terminal application.

2. Make sure the command-line tool Git is installed by entering `which git` into Terminal. If the command returns a filepath, you're all set. (If Git is not installed, [install it](http://git-scm.com/book/en/Getting-Started-Installing-Git).)

##### Windows

1. Open the command prompt (click the start button, open the command prompt by typing `cmd` in the "search programs and files" box, and hitting enter.

2. Make sure the command-line tool Git is installed by entering `git --version` at the command prompt. If the command returns a version number, you're all set. (If Git is not installed,
[Install Git for Windows](http://git-scm.com/book/en/Getting-Started-Installing-Git)).


### Copy the code to your computer.

1. Navigate to the folder you'd like to copy the code to by using the `cd` command.

2. Clone the repository (i.e. copy the code) from where it's hosted online. Do this by entering `$ git clone git@github.com:codeforboston/______.git` at the command line.  This will create a folder named `____` that contains the code.

3. Open the folder you just downloaded using your favorite text editor. (We use [Sublime Text](http://www.sublimetext.com/).)

### Installing dependencies

#####If your project has dependencies, give instructions on how to install here.  An example is below:

In order to build and test the project, you'll need to download software packages (they are defined in the file  `package.json`). Thankfully, [Node](http://nodejs.org/) package manager (aka npm) does the hard work with a single command (if you don't have Node/npm installed, do it now via the download package, Homebrew or another option before proceeding):

* `cd` into your repo directory and run `$ npm install`.

### Running the server
#####If you are using a task runner ([Gulp](http://gulpjs.com/) is recomended), put instructions here.  Otherwise give info on how to serve during development.  Example below: 

We have preconfigured an HTTP server for ____ using [Gulp](http://gulpjs.com/).  It serves your local site to the browser and also watches your files so that the browser will refresh every time you save.


* Make sure you have Gulp installed globally: `$ npm install -g gulp`

* At the command line, simply run `$ gulp`.

Once you've started Gulp, you should see ____ at [http://localhost:3000](http://localhost:3000)!

