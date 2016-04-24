# Cambridge Energy App [![Build Status](https://travis-ci.org/codeforboston/cambridge_energy_app.svg?branch=master)](https://travis-ci.org/codeforboston/cambridge_energy_app)

## What
How might we reduce energy use and cost for the 100 biggest apartment buildings in Cambridge?


## Who
We are working with the City of Cambridge.


## Status
We have developed a list of feature ideas. We are going to create a Ruby on Rails app, use Foundation for the front end, and PostgreSQL as the database so that people can report their energy usage and we can give them tips about reducing their energy usage and find ways to encourage them to follow through on these tips.


## Why
No one likes being cold in the winter, and no one likes paying really high heating bills, either. Thanks to the [Building Energy Use Disclosure Ordinance](https://www.cambridgema.gov/CDD/zoninganddevelopment/sustainablebldgs/buildingenergydisclosureordinance.aspx), Cambridge now has energy use data for the 100 largest apartment buildings in the City, which account for about half of the residential energy consumption. Can you use this (anonymized) data to help us communicate to the buildings about how they’re doing now and what they might do to reduce their energy consumption and bills? Apps to help residents monitor energy use, encourage action, and track results are all useful. And if Cambridge can reduce its city-wide energy use the most by the end of 2016, it could win the $5 million [Georgetown University Energy Prize](http://www.cambridgeenergyalliance.org/winit)!


## How to Contribute
If you wish to contribute to the project you should read this README along with our Wiki. It will also be helpful to catch-up on the [GitHub Issues Page](https://github.com/codeforboston/cambridge_energy_app/issues). You will then want to join the #cambridgeenergyapp channel in the [Code for Boston Slack Team](http://public.codeforboston.org/) and say hello. Slack is informal so feel free to ask questions there and other collaborators will help you out. 

Contributors who are changing code should develop their feature or fix in a new branch in the GitHub repository and then once it is complete you should send a pull request to have another project collaborator review your work and allow others to give you feedback. After any improvements have been incorporated your pull request will be merged into master.

If you have ideas for features or find a bug you should submit it as a GitHub issue. Due to the distributed and ephemeral nature of the project and our meetings ideas that are submitted in any other form are likely to turn into vaporware.

If you want to collaborate in person we normally meet on Tuesdays at 7 p.m. at the Cambridge Innovation Center. 


## Running with Docker

On Mac or Windows, install
[Docker Toolbox](https://www.docker.com/docker-toolbox). The Toolbox includes
VirtualBox, Docker, Docker Compose, and Docker Machine. You can choose not to
install Kitematic. On Windows, it also installs Git for Windows, which itself
includes MinGW.

On Linux,
install the Docker
[engine](https://docs.docker.com/engine/installation/ubuntulinux/)
(i.e., the daemon and client) and
[Docker Compose](https://docs.docker.com/compose/install/).

On Mac or Windows, launch the Docker Quickstart Terminal*.  It will set
up a new Docker 'default' VM if you do not already have one.

(On Linux, the following instructions should work, but you may need to start the
Docker daemon and use `sudo`. The details of starting the daemon are
platform-dependent, but it will be something like `sudo service docker start`.)

Now, cd to the root directory of this repository, run:

```sh
   docker-compose build 
   docker-compose up
```

The build step may take a little while.

To set up the database, with the server still running, open a new Docker
Quickstart Terminal window and type:

### Mac/Linux:

```sh
   eval "$(docker-machine env my-default)"
   docker-compose run app rake db:create
   docker-compose run app rake db:migrate
```

### Windows:

```sh
    docker-compose run -d app bash -c "rake db:create && rake db:migrate"
```

(The `-d` option is required on Windows due to current Compose limitations. You
will not see feedback on the terminal where you enter this command, but you
should see insert statements in the terminal where `docker-compose up` is
running.)

You can follow this general pattern to run arbitrary commands within the
running 'app' container. For example, you could type `bash` instead of
`rake db:migrate` to drop into a bash prompt inside the container. This
can be useful for performing maintenance tasks.

Determine the IP address of the running web app by typing
`docker-machine ip default`, then open your browser to
http://IP-ADDRESS:3002.

On Mac, you can type this at a new terminal window to quickly launch the
browser: `open http://$(docker-machine ip default):3002`.

*Important note*: as the application develops, you will probably need to re-run
`docker-compose run app bundle install` (to fetch new dependencies) or `rake
db:migrate` (to bring the database into line with the latest schema). If these
fail, try rebuilding with `docker-compose build`.

* If you prefer not to use the Docker Quickstart Terminal, all it's doing is:

```sh
    # First run, provisions a Linux VM:
    docker-machine create -d virtualbox default
    # Start the machine:
    docker-machine start default
    
    # Each terminal:
    eval $(docker-machine env default)
```

### Troubleshooting

- If `docker-compose` is not installed, or if it returns `Illegal instruction`,
  run `pip install docker-compose` (requires
  [pip](https://pip.pypa.io/en/stable/))

- If you see a message that says `A server is already running` when you attempt
to run `docker compose up` (and you don't have a server running), delete the
`server.pid` file in `tmp/pids`.

## License
[MIT License](LICENSE)
