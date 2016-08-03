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


## Getting Started

1. Follow the instructions at [install Rails](http://installrails.com) to get Rails working on your local machine. Make sure to install [RVM](https://rvm.io).
2. Clone the repo to your directory.
3. run rake db:setup and rake db:seed
4. start the app!

## License
[MIT License](LICENSE)
