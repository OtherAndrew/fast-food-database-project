# fast-food-database-project

This is the React.js frontend for our Fast Food database project.

## Description

This project serves as the frontend for a customer ordering system for a fast food restaurant.
It should be used in conjunction with [fast-food-web-service](https://github.com/OtherAndrew/fast-food-web-service).

Users can view the menu, filter the menu by category, create orders, and add items to orders.

All the orders and items on order stored in the database can be viewed using the `Show All Orders` button at the bottom of the screen.

## Getting Started

### Dependencies

- [Node.js](https://nodejs.org/en)
- [npm](https://www.npmjs.com)
- [React.js](https://react.dev)

### Installing

Clone repository and install dependencies.

```shell
git clone https://github.com/OtherAndrew/fast-food-database-project
cd ./fast-food-database-project/fast-food-app
npm install
```

### Executing program

#### 1. Initialize database

Using MySQL, run `SetupTables.sql` to create tables and insert initial values into the `fast_food` database.

#### 2. Run web service

In the directory containing the [web service](https://github.com/OtherAndrew/fast-food-web-service) (`fast-food-web-service`), run:
   
```shell
npm run local
```

Open [http://localhost:5000](http://localhost:5000) to view the web service in your browser.

#### 3. Run web app

In the directory containing the [web app](https://github.com/OtherAndrew/fast-food-database-project) (`fast-food-app`), run:

```shell
npm start
```

Open [http://localhost:3000](http://localhost:3000) to view the web app in your browser.

## Help

- Make sure both the database and web service are up and running before running the web app. 

## Authors

- [Brian Nguyen](https://github.com/BrianNguyen636)
- [Andrew Nguyen](https://github.com/OtherAndrew)

## Acknowledgments

- [README Template](https://gist.github.com/DomPizzie/7a5ff55ffa9081f2de27c315f5018afc)