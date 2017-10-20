How I approached the task:

Firstly, I decided what kind of architecture I will use and which libraries will be needed.
In the end, it came to RxAlamofire, a library for simple and good looking popups and 
another Alamofire dependency for image loading.

For general architecture, I went for MVP. I didn't use protocols for implementing clients (data)
and presenters since I didn't have too much time. If I was creating a scalable application,
I would definitely use protocols also for Data and Presenter (not just view) for easier testing
(mocking).

When turning JSON into Swift objects, I only extracted the data that seemed useful to me, for
example I ignored search metadata etc.

For ParkingLocation object, I parsed a lot more data than I ended up using because I ran out of
time to visualize everything.

In the end, I sadly ran out of time, I was going to work for a couple of more hours, but something
came up, so I had to stop.

If I had enough time to improve the app, here is what I would do:
- Design proper MVP architecture using protocols
- Implement Map Marker clustering
- Localize strings
- Implement logic to retry request if it fails (currently only a dialog saying it failed displays
and user is stuck with that dialog)
- Add placeholder image while Location image is loading, right now the top of dialog is simply
white, which is very ugly
- Improve Detail popup by making the height dynamic
- Improve Detail popup by visualizing all of the data that I parsed into ParkingLocation object



