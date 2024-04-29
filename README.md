# augmenti

## Description

A Flutter app to take pictures, augment it with AI, and save/download it.

User authentication is done with Firebase, and remote image storage is to a Google Cloud Storage bucket associated with the user. The magic behind the app is Stability AI's Inpainting model.

## Usage
1. Login (either with Google, Apple, or with an email/password)
2. Take a picture
3. Paint over the region you want to replace
4. Write some prompt that will replace your highlighted region
5. Click augment, and wait for the request to resolve
6. View, retake, save (on the cloud) or download the picture

Demo pictures are below.

## Spin-up
To run/test this app locally, you'll need to do a few things.

1. Get access to Firebase, Stability AI
The required packages have already been installed but configuration to your own Firebase project would still be required. You can select your project using the `flutterfire` CLI, in combination with the Firebase CLI. For Stability's Inpainting, simply get an API key, create a `.env` file at root and paste `API_KEY="..."`.

2. `flutter run`
Assuming you have a the flutter sdk already installed (must also add to path), simply run `flutter run` in your terminal, which will ask you what emulator to run it on. You can choose an iOS emulator (XCode, Mac) or an Android Emulator (via Android Studio, all platforms).

## Screenshots


## Next steps
- Animations
- Apple sign in flow (required for publishing on App Store)

## Extra Notes
- The input/mask pictures must each be less than 9,437,184 pixels (e.g. 3072x3072, 4096x2304, etc.), which is ensured by scaling down the raw camera picture before invoking the Inpainting API.

- As recommended, feathering the edges of the mask leads to better results at the borders, so a Gaussian blur is applied by default.
