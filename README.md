# Cambridge Energy App

## What
How might we reduce energy use and cost for the 100 biggest apartment buildings in Cambridge?


## Who
We are working with the City of Cambridge.


## Status
We have developed a list of feature ideas. We are going to create a Ruby on Rails app, use Foundation for the front end, and PostgreSQL as the database so that people can report their energy usage and we can give them tips about reducing their energy usage and find ways to encourage them to follow through on these tips.


## Why
No one likes being cold in the winter, and no one likes paying really high heating bills, either. Thanks to the [Building Energy Use Disclosure Ordinance](https://www.cambridgema.gov/CDD/zoninganddevelopment/sustainablebldgs/buildingenergydisclosureordinance.aspx), Cambridge now has energy use data for the 100 largest apartment buildings in the City, which account for about half of the residential energy consumption. Can you use this (anonymized) data to help us communicate to the buildings about how they’re doing now and what they might do to reduce their energy consumption and bills? Apps to help residents monitor energy use, encourage action, and track results are all useful. And if Cambridge can reduce its city-wide energy use the most by the end of 2016, it could win the $5 million [Georgetown University Energy Prize](http://www.cambridgeenergyalliance.org/winit)!


## How
Dataset: https://www.dropbox.com/sh/iqjv3dobm8rqg1f/AACsNGiGjbSIHokFV_bxvbEna?dl=0

Cambridge Resources: http://www.cambridgeenergyalliance.org

MassSave State Resources: http://Www.masssave.com

Devpost Project Pitch: http://hackwinter2015.devpost.com/forum_topics/5392-project-pitch-apartment-building-energy-savings


## Running with Docker

On Mac or Windows, install
[Docker Toolbox](https://www.docker.com/docker-toolbox).  On Linux,
install the Docker
[engine](https://docs.docker.com/engine/installation/ubuntulinux/)
(i.e., the daemon and client and
[Docker Compose](https://docs.docker.com/compose/install/).

On Mac or Windows, launch the Docker Quickstart Terminal.  It will set
up a new Docker 'default' VM if you do not already have one.

(On Linux, the following instructions should work, but you may need to
start the Docker daemon and use `sudo`.)

Now, cd to the root directory of this repository, run:

```sh
   docker-compose build 
   docker-compose up
```

The build step may take a little while.

To set up the database, open a new Docker Quickstart Terminal window and
type:

```sh
   docker-compose run app rake db:create
   docker-compose run app rake db:migrate
```

You can follow this general pattern to run arbitrary commands within the
running 'app' container.  For example, you could type `bash` instead of
`rake db:migrate` to drop into a bash prompt.

Determine the IP address of the running web app by typing
`docker-machine ip default`, then open your browser to
http://IP-ADDRESS:3002.

On Mac, you can type this at a new terminal window to quickly launch the
browser: `open http://$(docker-machine ip default):3002`.

## License
[MIT License](LICENSE)
