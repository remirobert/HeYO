# HeYO !

**HeYO** is a mobile application allows you get informations about your current location.
Such as the current *address*, *weather*, *venues*, and *photos*.

# Service

The service, follows the micro-service architechture. That means, all the functionnalities is splitted in different application. The service is made with **Node.js**.

This is the current services avalaible :

- **service-geo**: fetch information on *google map* API to find some information about the location.
- **service-venues**: fetch venues arround with *foursquare* API.
- **service-weather**: fetch weather information with *forecast* API.
- **service-instagram**: fetch pictures arround the location posted on *instagram*.
- **api**: propose an interface for the client to fetch the datas corresponding to the client (iOS app).

All the service are divided on different application. And all return **JSON** data. That means, all the service are independant from the core and can work by their own.

# Deployment

To be deployed, all services (so all applications) need to be deployed.
To help the deployment of the all architecture, all the application has its own **Dockerfile**. 
All the application can be deployed by their own.
The project has a **docker-compose.yml** file, to *build* and *run* all the *docker container* in one time.

```shell
docker-compose up
```

Or using **pm2** to manage all the applications process.

```shell
npm install -g pm2
pm2 start processes.json
```
