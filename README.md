#### What is this ?

Check My Plane is an iOS application + backend that lets you provide the wing number of your airplane  returns the maintenance history of your plane. The data used in this database is not checked into this repo, but it was taken from the NTSB [website](http://www.ntsb.gov/_layouts/ntsb.aviation/index.aspx). The [data](http://app.ntsb.gov/avdata) is only in MSAccess format, so you need a windows machine to convert it to CSV.


####  Setting it up

The currently service is built using objective C (iOS app), golang (server backend), and postgres (database). If you are on a mac, I suggest you install Postgres App for postgres.

To seed the database, you can execute the following command:

```
make database
```
Once the database is seeded, you can run the backend by install the third-party packages:

```
go install
```

And then building the api application:

```
make build
```

Finally, you can run the application using:

```
make web
```

Currently the API provides two endpoints (neither require authentication):

To get a list of all accidents, you can hit (update your [host file](https://github.com/josephmisiti/check-your-plane-api/blob/master/hosts))

```
http://dev.checkmyplane.com/api/v1/accidents
```

And to get the information on an individual accident, you can hit the following endpoint (in this example I am using tail registration number `N6312H`):

```
http://dev.checkmyplane.com/api/v1/accidents/N6312H
```

#### Usage

[![](https://github.com/josephmisiti/check-your-plane-api/blob/master/images/screen1.png)]()

[![](https://github.com/josephmisiti/check-your-plane-api/blob/master/images/screen2.png)]()


#### Helping out?

If you want to contribute, please provide a pull request or reach out on twitter [@josephmisiti](https://www.twitter.com/josephmisiti)

