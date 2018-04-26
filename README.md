# School Content Management System

## Purpose and Usage

Titled **Semitime**, this application is a content management system created for my high school, [Semiahmoo Secondary School](https://www.surreyschools.ca/schools/semi/Pages/default.aspx).

My high school has a rotating class ordering (known as *block order* in my high school) for every day of the week. While the class ordering is usually consistent, the class ordering deviates from the norm during holidays, exam days, and on Fridays. This has been a source of confusion for many students in my high school, so I created an app that achieves the following purpose:

1. School Administrators update information about class ordering or important announcements.
2. Students receive push notifications whenever there are changes (adjustable depending on each student's needs).

The mobile client contains the following features:

- Updated Class Ordering
- Calendar
- ToDo App
- Push Notifications

#### Video Demo

[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/MpxcKblkl8w/0.jpg)](http://www.youtube.com/watch?v=MpxcKblkl8w)

#### Screenshot of Server Interface

<img src="https://i.imgur.com/zo6epES.png" width="400">

#### Screenshot of Mobile Client

<img src="https://i.imgur.com/ZOC52Re.png" width="400">
<img src="https://i.imgur.com/MGJwUUP.png" width="400">
<img src="https://i.imgur.com/tisCOsv.png" width="400">

## Implementation

The entire application consists of two separate parts:

- A server backend developed using [php](http://php.net)
- A mobile client developed using [Corona SDK](http://coronalabs.com)

Through the server frontend, administrators modify class ordering or special events for specific day(s). The class orderings is serialized into a JSON file, and a POST request is made to trigger push notifications on students' phones. The push notification system is implemented using [OneSignal](https://onesignal.com/).

When a new JSON file is serialized, a MD5 hash is generated. Upon each refresh of the mobile client, the client downloads the MD5 hash and checks if its internal database is different from the server's database with the MD5 hash. If the MD5 hashes don't match, the client requests the JSON file and updates its own database.

I originally tested the app using a LAMP (Linux, Apache, MySQL, and php) stack on Ubuntu Linux.
