# CARETAKER

Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.

**The aim of this app is to help anyone to take care of your loved ones and it's the result of my Le Wagon's final project.**
It was developed by me (Rui Magalhães) and my friend Emanuel Moniz (https://github.com/emanuelmoniz/).


You can find it live on: http://www.caretaker.pt/

You can watch the presentation of this app on the following link: https://youtu.be/8wWgDhPc4j0?t=504

## Table of Contents

* [Getting started](#getting-started)
* [Features of the app](#features-of-the-app)
* [Some technicalities of the app](#Some-technicalities-of-the-app)
* [Authors](#authors)

## Getting Started

#### To get this web-service working on your localhost, do the following:

* After cloning the project, do the following on your **terminal**:

```terminal
$ brew update
$ bundle install
$ yarn instal
$ rails db: create
$ rails db: migrate
$ rails db:seed
```
* On your .env file put your claudinary key, your app email adress, your email app password and your host website:

```ruby
#.ENV file
$ CLOUDINARY_URL= ************************************
$ EMAIL_ADDRESS=something@something.something
$ EMAIL_APP_PASSWORD=**********
$ HOST=www.something.something
```
* You need to install sidekiq too, to be able to do asynchronous jobs. To do that, do the following on your **terminal**:

```terminal
$ brew update
$ brew install redis
$ brew services start redis
$ redis-cli FLUSHALL
$ bundle binstub sidekiq
$ bundle binstub sidekiq -- force
```
* Now, you are ready to see this project from your own machine.
Do the following, on your **terminal**:

```terminal
$ sidekiq
```
* Still on the **terminal**, but on **another tab**:

```terminal
$ rails s
```

* After this, you can open the app in your local server: http://localhost:3000/

#### If you want to see the app working without any job, you can visit: www.caretaker.pt (feel free to sign up and see our features!)

### Prerequisites

1. Text Editor
2. Package manager (homebrew on OSX, Aptitude on Ubunto)
3. Git
4. Ruby
5. Rails

## Features of the app

This app have the following features:

1. Link between users (Patient/Caretaker)
2. Add/edit/see an event on my shedule
3. Add/edit/see an event on my Patient schedule
4. Add a recurring event (i.e. To add an event about a pill for 30 days, you only need to add one event, with recurring option)
5. Receive diferent types of notifications (types: Before/ Do/ Done/ Missed) about your events or the ones of your patients
6. Change to a simpler view

### Examples

I'm logged in with Rui's Account and I have Manuel as my Patient.

**Here is my dashboard (I have a section for all events and all notifications too - mines and the ones of my patients):**

<p align="center">
  <img src="/readmeImgs/dashboard.png" width="400">
</p>

* **As you can see, I have Manuel as my patient (Relations page):**

![](/readmeImgs/Patientexample.png)

* **I can see my calendar (no events):**

![](/readmeImgs/mySchedule.png)

* **And, I can see Manuel calendar:**

![](/readmeImgs/manuelSchedule.png)

* **Here are my last notifications (One saying that Manuel missed one event and other event saying that manuel did one event):**

![](/readmeImgs/dashboard.png)

* **I can change the view to a simpler one.
With this view I'm not able to add or edit events. I'm only able to see my events the notifications of those events!**

![](/readmeImgs/simpleview.png)


**NOTE: Those examples are on a mobile view. However, the web-service is totally responsive and it work on IPAD's and computers too.**


## Some technicalities of the app

In this chapter, we will present you some technicalities about this project.

* **The DB schema of the project is the following:**

![](/readmeImgs/DBschema.png)


As you can see, we have 7 tables:

1. users
2. events
3. event_types
4. notifications
5. relations
6. user_diseases
7. diseases


If you look at the Relations, you can see that for each user you can call `` user.patients `` or `` user.caretakers`` and the output will be all the patients or caretakers of that user!

On top of that, one user can have more than one event.
On the other hand, each event can triger more than one type of notification.

For each event, a Job goes to the **sidekiq queue** to triger a notification to the user and/or to his caretakers.

To triger a notification we compare `Time.now` with  ``event.start_time``.

## Authors

App developed by:

* Emanuel Moniz (https://github.com/emanuelmoniz/)
* Rui Magalhães (https://github.com/RuiSMagalhaes)






