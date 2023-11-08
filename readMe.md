Original App Design Project - README Template
===

# TravelExplorer

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

TravelExplorer is a travel app that provides users with travel itineraries, destination guides, and real-time travel updates. Users can like a travel itinerary and that way, other people can see who is traveling there as well. When a user selects their profile, it will show their email, phone number, and place of origin represented with a flag

### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:** Travel
- **Mobile:** The ability to connect with other users and view their information instantly. It provides real time information on the location
- **Story:** Traveler lands in city, but isn’t sure what to do first. so they open the app for an instant itinerary and they also find fellow travelers
- **Market:** the market for this app should be huge because there are lots of tourist. Since younger people love to be spontaneous, they don’t always have a plan, so this app would be perfect for them.
- **Habit:**  App shouldn’t be addicting. Should mainly be used during trips or when planning for a trip. But while a user is traveling, they might use it frequently. This app is mainly just for consumption, but there can be an option for user to create their own unique itineraries
- **Scope:** I think this app will be just challenging enough. I will need to make an API call to a travel company, like Tripadvisor. With the API call, I will need to create a main view that displays all the destinations. I will then also have a tab bar view that has a separate view for liked destinations. When you like a destination, you should also be able to see who else liked it to view their information, which is another page. For the main page, I can also use a filter. So I might need to implement a settings page to filter destinations based on the continent, for example.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can view travel destination
* User can view destination specifics 
* User can add destination 
* User can like a destination
* User can view liked destinations
* ...

**Optional Nice-to-have Stories**

* User can view who else liked the post
* User can filter destinations based on continent, or specific country
* User can comment on itineraries and write their reviews on it
* User can change how many destinations they see


### 2. Screen Archetypes

- Stream
    * User can view travel destination 
    * User can view liked destinations
* Detail
    * User can like a destination
    * User can view destination specifics

* Creation
    * User can add destination

* Setting
    * User can change how many destinations they see



### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [fill out your first tab]
* [fill out your second tab]
* [fill out your third tab]

**Flow Navigation** (Screen to Screen)

- Tab Navigation (Tab to Screen)
    - Home Feed
    - Liked Feed
    - Post an itinerary
* Flow Navigation (Screen to Screen)
    * Stream Screen
        * -> detailed screenview for itinerary specifics
    * Creation Screen
        * -> Home Screen(after you finish creation)
* Liked Screen (Screen to Screen)
    * -> Home Screen


## Wireframes

[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

[This section will be completed in Unit 9]

### Models

[Add table of models]

### Networking

- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]