# jubelio_test

A Flutter Project With Objection for Test In Jubelio

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
