# weatherapp

A new Flutter project. 🚀

In the process of developing this app, I have gained valuable experience in using web APIs and handling requests efficiently with the help of various dependencies. 📡

### Dependencies

```yaml
dependencies:
    cupertino_icons: ^1.0.8
    flutter:
        sdk: flutter
    flutter_dotenv: ^5.2.1
    geolocator: ^13.0.2
    http: ^1.2.2
    intl: ^0.20.1
    permission_handler: ^11.3.1
```

## Overview

`weatherapp` is a Flutter application designed to provide weather updates based on the user's current location or a searched city. The app features a user-friendly interface with real-time weather data, including temperature, sunrise/sunset times, and more.

## Features

- Fetch weather data based on the current location using geolocation.
- Search for weather information by city name.
- Display detailed weather information including temperature, sunrise/sunset times, and more.
- Improved UI responsiveness and user interaction.
- Splash screen for enhanced app loading experience.

## Technologies Used

- **Flutter**: For building the cross-platform mobile application.
- **Dart**: The programming language used with Flutter.
- **Geolocation**: To fetch weather data based on the user's current location.
- **dotenv**: For managing environment variables, such as the weather API key.

## Getting Started

This project is a starting point for a Flutter application.

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter
- An API key for the weather service (stored in a `.env` file)

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/Yasitha-Bhanuka/weatherapp.git
    ```
2. Navigate to the project directory:
    ```sh
    cd weatherapp
    ```
3. Install dependencies:
    ```sh
    flutter pub get
    ```
4. Create a `.env` file in the root directory and add your weather API key:
    ```env
    WEATHER_API_KEY=your_api_key_here
    ```
5. Run the application:
    ```sh
    flutter run
    ```

## Resources

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.

## Commit History

The commit history provides a detailed log of the project's development, including feature additions, refactoring, and bug fixes. Notable commits include:

- Adding geolocation support to fetch weather data.
- Implementing weather data fetching functionality.
- Enhancing the WeatherPage UI and user interaction.
- Adding a splash screen for improved loading experience.

For a complete list of changes, refer to the commit history in the repository.

