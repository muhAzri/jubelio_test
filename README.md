# jubelio_test

A Flutter Project With Objection for Test In Jubelio

## Description 

The Flutter app created for test submission is a mobile application that provides a convenient way for users to browse and purchase products from a WooCommerce store. The app features three main pages, starting with a catalog display that shows a list of products fetched from the WooCommerce API. The app uses caching to ensure that the products can still be viewed even when the user is offline.

The app also includes a search feature to make it easier for users to find specific products. When a user taps on a product tile, they will be taken to a detail page that displays more information about the selected product. Additionally, the detail page includes a button that allows users to add the selected product to their cart.

The final page of the app is the Cart Page, which displays all the products that the user has added to their cart. The cart tile includes functions to increase or decrease the quantity of products, and it also displays the total cost of the products that the user has selected.

To manage the state of the app, the developer used Bloc for API consuming and Provider for the Cart. Overall, this app provides a seamless shopping experience for users and is designed to make it easier to purchase products from a WooCommerce store.

## Prerequisites

To run the app locally, you'll need the following:

- Flutter installed on your machine
- An emulator or physical device to run the app on

## How To Run Steps

Firstly we have 2 way to run the app

### First ( Install Direct By Apk )
You can easily run this application just by installing the apk that I have built in the root of this project folder

### Second ( Build Apk From Source Code )

#### Steps
1. Clone the repository
    you can download the zip file or run this code
    ```git clone <repository-url>```
2. Run Flutter Pub Get on the project folder
    ```Flutter Pub Get```
3. Create .env file in the root of project folder for store the consumer key and consumer secret
    the file should be like this :
    ```
    CONSUMER_KEY=your_consumer_key
    CONSUMER_SECRET=your_consumer_secret
    ```

    **Dont forget to change the value**
4. After the env create you can run the app simply with this command
    ```Flutter run```

    Note : Dont Forget to attach your Real Device or Simulator
