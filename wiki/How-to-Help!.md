Live example: [____.codeforboston.org](____.codeforboston.org)

Thanks for helping build ____!  It's built by volunteers, so it's people like you who move the project forward.

We've collected some documentation on the pieces used in ____ at [Development Resources](Development-Resources), so if you're unfamiliar with anything that's a good place to start.

##Where to Jump in
There are lots of ways to help with this project.  It's really only limited by your imagination. Since it is an open source project, design changes, UI tweaks, data improvements/additions, code cleanup and new features are all welcome.  The only thing we ask is that you document your idea in the ["issues"](https://github.com/codeforboston/____/issues) before working on it. That way discussion can take place and we avoid overlap.

Issues are used to track bugs, note the different pieces we are working on, and to list tasks.  To find the list, you can either click the link above, or if you are used to a Trello type system, use Waffle.io's interface. Just click the badge below.  Issues are assigned to "milestones" to rank the order they should be tackled in.  They sometimes have "labels" that categorize and provide extra information to direct you.

[![Stories in Ready](https://badge.waffle.io/codeforboston/____.png?label=ready&title=Ready)](http://waffle.io/codeforboston/____)

## Stack

#### This is where you should include information about the languages and libraries that you are using for your project.  Having this information here will help people get up to speed quicker and have a better idea of where they can contribute.

> Examples:

> ____ is all client-side Javascript with a single page for the entire app. This helps non-developers and coders of all levels deploy quickly.

> #### In brief: HTML/CSS/JavaScript

> This is the markup and language that we use.  We use a number of frameworks and libraries to help stitch it all together and make it more powerful.  Info about each is below.


####[Bootstrap](http://www.getbootstrap.com)
This framework comes with all kinds of built in classes that help our project be responsive and adapt to various screen sizes.  It's responsible for most of our app's styling through its included CSS sheet.  The rest of our custom styling is done through vanilla CSS in our `style.css` sheet which you can find in the `src` folder.

####[LeafletJS](http://leafletjs.com/)
Leaflet is what makes our maps look so pretty. It uses JavaScript to add layers and elements like legends and markers to maps so that you can easily represent data and information. It's pretty light-weight, and has quite good documentation.  There are also lots of plugins contributed by the developer community.

####[BackboneJS](http://backbonejs.org/)
Backbone is a powerful and flexible Model-View-Controller (MVC) framework.  Lots of sights use it to structure and architect complex pages with lots of moving parts.  We, on the other hand, just use one little part of it; the router.  It is what keeps our URLs dynamic and the browser "back" and "forward" buttons functional. The core files are in the `lib` folder, and the router functionality takes place in `src/scripts/routes.js`.

####[UnderscoreJS](http://underscorejs.org/)
Underscore is a hard dependency for Backbone.  It has to be included, or Backbone won't work.  It is also a nifty templating engine.  We only use that functionality in a few spots, but it is helpful.

####[RequireJS](http://requirejs.org/)
Require is a very important JS library that provides Asynchronous module definition (AMD).  It allows us to break our app apart into small and more manageable modules, and then stitches them all together when we need them.  If you want to work on ____, you will have to know how this library works, so check out the docs.

####[TopoJSON](https://github.com/mbostock/topojson)
This is a file format that makes layers to put on top of maps!  It's not super critical to know how the files are constructed, but be aware of its inclusion.

####[Gulp](http://gulpjs.com/)
Gulp is not actually part of the site/app.  It is a very light-weight app that takes commands in the terminal and runs tasks for us, facilitating development.  It provides an HTTP server so you can see your progress in the browser as you work.  It even refreshes the page when you save a file you are working on!

Once you have your app in a state you actually want to publish, it will help with that as well.

There are instructions for both of those tasks on the Getting Started page under "Running the Server," and the Deployment page.

## Best Practices to Follow While Coding

1. Keep everything human-readable.
2. Comment as much as possible.
3. When working on new features, create a new branch on Github.  When it is complete, generate a pull request to merge it back into the `develop` branch.