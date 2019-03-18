# AIRTNT



## Getting Started

1. To get this platform working on your localhost, do the following:

After cloning the project, do the following on your terminal:

```
#TERMINAL
brew update
bundle install
Yarn instal
rails db: create
rails db: migrate
rails db:seed
```
On your .env file put your claudinary key, your email adress, your email app password and your host website)
```
#.ENV file
CLOUDINARY_URL= ************************************
EMAIL_ADDRESS=something@something.something
EMAIL_APP_PASSWORD=**********
HOST=www.something.something
```
You need to install sidekiq too, for those asynchronous jobs. To do that, do the following on your terminal:
```
#TERMINAL
brew update
brew install redis
brew services start redis
redis-cli FLUSHALL
bundle binstub sidekiq
bundle binstub sidekiq -- force
```
Now, you are ready to see this project from your own machine.
Do the following, on your terminal:
```
#TERMINAL:
sidekiq
```
Still on the terminal, but on another tab:
```
#TERMINAL:
rails s
```

After this, you can open the app in your local server

2. If you want to see the app working without any job, you can visit: https://airtnt.herokuapp.com (feel free to sign up and add seeds :)  )


### Prerequisites

1. Text Editor
2. Package manager (homebrew on OSX, Aptitude on Ubunto)
3. Git
4. Ruby
5. Rails





## Still on construction from now on

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc

