# Project Three

---

Build a complex full stack application **

1. This application will have a **client-based** component as well as a **server-side** component.

## Outline

The period dedicated to projects in-class begins the afternoon of Thursday, October 9. **On the morning of Tuesday, October 14, we will be doing presentations to demo the progress we have made**.

As with the previous project, we will meet at 9:30 on Friday. This time however, we have no class on Monday for Columbus Day.

The dedicated project period is known as a ***sprint***. During this sprint, we will have daily ***stand-ups***, or short meetings with our classmates and instructors, every morning. The purpose of the stand-up is to set goals for the day and support one-another in our development tasks. The purpose of the sprint is to fulfill a set of required features known as an ***MVP***, or *minimum viable product*.

**The end of the sprint is not the end of the project**. The resulting application will be your first possible portfolio piece, and as such it would behoove us to continue to work on it in the months to come.

**Each group will be responsible for their own project**. This means that every student in the group  must be able to explain what every piece of code does. Do not include code you do not understand!

## Objectives

- Collaborate with your peers as a team
- Pull everything together by building a web application from the ground up.
- Gain experience collaborating and working in a development team.
- Practice integrating topics covered during this course thus far, bridging the gaps between the various areas of a web app (client-side and server-side).
- Use [GitHub](https://help.github.com/categories/63/articles) and [Trello](https://trello.com/) to collaborate


## Core Requirements
- __Application__
    - A server-side component built using Sinatra and Postgres that will act as a service to be consumed.
      - Think back to how our Project 2 server side component was set up.
    - A client-side component that is a **Single Page Application** which will consume that API you built.
      - You can choose whether to use Backbone or to roll your own solution with Javascript/jQuery.
    - An external API must also be consumed.
      - It is your choice whether you should interact with API using HTTParty or a gem on the server-side or whether you AJAX directly to it from the client-side.
      - Resources to research API's:
        - [Programmable Web](http://www.programmableweb.com/)
        - [Mashape](https://www.mashape.com/)
    - All of your routes should follow REST protocol
    - Be sure that you're `/` route serves up the `index.html` rather than having to go to `/index.html` to interact with the client-side application.
- __Database__
  - You application **MUST** have at least three models, which will of course correspond to their own database tables.
  - At least one of these models **MUST** have more than one foreign key in it.
    - This is commonly called a 'joiner model'
- __Deployment__
  - Your application **MUST** be hosted on Heroku.
  - When presentation time comes around, you will be demo'ing the hosted version from one of our computers.
- __Group__
  - You **MUST** pair program at all times. This will ensure that team members understand the code that is being written.
    - There is a great Wikipedia [entry](http://en.wikipedia.org/wiki/Pair_programming) on the subject. Be sure to pay attention to the `Benefits` section.
- __Indidivual__
    - Communicate.
    - Comment your code.

## Deliverables (Due on Tuesday, October 14th)

- The MVP of an application with a detailed README that features:
    - A short description of your Application
    - Team members
    - Technologies used
    - A link to your Trello board
    - Artifacts
      - Wireframes
      - ERDs
- A [GitHub Organization](https://github.com/blog/674-introducing-organizations) that includes each member of your team.
- A new [Trello board](https://trello.com/) that serves as a prioritized list of tasks your team needs to complete during your sprint. This includes user stories, bug fix, general todo.
- Lightning talk that:
    - Demo your application on Heroku.
    - You will be presenting this talk to the entire class


##Last Details
- [Timeline][timeline]
- [Groups][groups]


<!-- Links -->

[timeline]: timeline.md
[groups]: groups.md

##Final thoughts

**This is not a hack fest!** Cobbling or hacking together a bunch of code is not the point of this project. We want to write well structured, easy to read, and working code.

To this end, make sure you spend enough time planning your application and how you are going to implement it.

---