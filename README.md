# CARETAKER

Rails app generated with lewagon/rails-templates, created by the Le Wagon coding bootcamp team.

This app is the result of my Le Wagon's final project.It was developed by me (Rui Magalhães) and my friend Emanuel Moniz (https://github.com/emanuelmoniz/)

You can find it live on: http://www.caretaker.pt/

You can watch the presentation of this app on the following link: https://youtu.be/8wWgDhPc4j0?t=504

## Table of Contents

* [Getting started](#getting-started)
* [About the app](#about-the-app)
* [Features](#about-the-app)

## Getting Started

#### To get this web-service working on your localhost, do the following:

* After cloning the project, do the following on your terminal:

```
#TERMINAL
brew update
bundle install
Yarn instal
rails db: create
rails db: migrate
rails db:seed
```
* On your .env file put your claudinary key, your email adress, your email app password and your host website
```
#.ENV file
CLOUDINARY_URL= ************************************
EMAIL_ADDRESS=something@something.something
EMAIL_APP_PASSWORD=**********
HOST=www.something.something
```
* You need to install sidekiq too, to be able to do asynchronous jobs. To do that, do the following on your terminal:
```
#TERMINAL
brew update
brew install redis
brew services start redis
redis-cli FLUSHALL
bundle binstub sidekiq
bundle binstub sidekiq -- force
```
* Now, you are ready to see this project from your own machine.
Do the following, on your terminal:
```
#TERMINAL:
sidekiq
```
* Still on the terminal, but on another tab:
```
#TERMINAL:
rails s
```

* After this, you can open the app in your local server: http://localhost:3000/

#### If you want to see the app working without any job, you can visit: https: www.caretaker.pt (feel free to sign up and see out features!)

### Prerequisites

1. Text Editor
2. Package manager (homebrew on OSX, Aptitude on Ubunto)
3. Git
4. Ruby
5. Rails

## About the app

## Features

![](/readmeImgs/DBschema.png)





