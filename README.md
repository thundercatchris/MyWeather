# MyWeather

<img src=/images/sunIcon.png width="100" height="100">

TFL EF English Live - test


### Prerequisites

Cocpods need to be installed

A Device or iPhone simulator running iOS 12.0 or higher

Xcode 10.0 or higher


### Installing

Clone the project. change to the installation directory in terminal and run "pod install".

Open the MyWeather.xcworkspace project

### Testing

Some basic Unit tests have been included and can be run individually or as an entire class.
UI tests were not included as the UI is so simple, with the refresh button being visible at all times.


### Built With

* [Alamofire](https://github.com/Alamofire/Alamofire) - The http request framework used
* [Kingfisher](https://github.com/onevcat/Kingfisher) - Image caching

&nbsp;
&nbsp;


## Purpose

To display the weather for the users location, and to store this information for up to 24 hours, to use offline

&nbsp;
<img src=/images/IMG_8186.png width="231" height="500">
&nbsp;
&nbsp;


## Choices

#### User Defaults vs Core Data
Core Data is my go to solution, however storage is only required for one object in this case. Security is also not required, so I decided to go with User Defaults.
#### Images & Kingfisher
The Images provided by the API are quite low resolution, I kept these and their link for demonstration purposes, but chose to use my own larger Images for design.
Kingfisher is a cocoapod I trust and not only requests the image from the url, but caches it for use offline.
I chose to re use some of the images and to change the background from day to night.
#### Alamofire vs URLSesseion
This is just personal preference
#### Codable and nested data
This is something I have been experimenting with of late, its a nice clean way to parse the data into a struct. I chose to only use the first weather item from the array.
I made the majority of the attributes optional so that if any data is missing, the app will still perform. One example is the 'wind direction', which was missing on several occasions from the response.
#### Reachability
I found a solution to this without using cocoapods here
#### Cocoapods
Although I used Alamofire and Kingfisher, I trust these and they are regularly updated. I have not restricted the versioning for them here. I have avoided using others so that the app is not too reliant on them.
#### Prominent displays and warnings
I decided not to show separate screens or large icons, for live / cached data I chose to change the updated date and time colour and add warnings if offline data was used / other status errors. These could prove to be annoying, so this may be something I would change.
#### Activity Indicator
I used a custom activity indicator for loading and disabled the view behind, but this only flashes up very quickly if the network connection is strong and may go unnoticed

&nbsp;
<img src=/images/IMG_8185.png width="231" height="500">
&nbsp;
<img src=/images/IMG_8192.png width="231" height="500">

