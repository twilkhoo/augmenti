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
6. View, retake, save (on Google Cloud) or download the picture

Demo pictures are below.

## Spin-up
To run/test this app locally, you'll need to do a few things.

1. Get access to Firebase, Stability AI
The required packages have already been installed but configuration to your own Firebase project would still be required. You can select your project using the `flutterfire` CLI, in combination with the Firebase CLI. For Stability's Inpainting, simply get an API key, create a `.env` file at root and paste `STABILITY_API_KEY="..."`.

2. `flutter pub get` to resolve all dependencies.

3. `flutter run`
Assuming you have a the flutter sdk already installed (must also add to path), simply run `flutter run` in your terminal, which will ask you what emulator to run it on. You can choose an iOS emulator (XCode, Mac) or an Android Emulator (via Android Studio, all platforms).

## Screenshots
The following are some screenshots of the app.
![ss_homepage](https://github.com/twilkhoo/augmenti/assets/30396273/c101f6b5-7e55-40bf-9ded-e172c6c7be7f)The homepage^.


![ss_login](https://github.com/twilkhoo/augmenti/assets/30396273/ff305750-4d99-4b95-83cd-b486bfa2a8c5)The login page^.


![ss_capture](https://github.com/twilkhoo/augmenti/assets/30396273/315a7242-4071-4f71-aefb-184bca6d3ea9)The capture page^, the displayed picture is of Android Studio's Camera Emulator.


![step2_ss](https://github.com/twilkhoo/augmenti/assets/30396273/7bed0169-8ca5-4c82-acaa-6c6c99f4469b)The augment page^ (picture uploaded).


![step3_ss](https://github.com/twilkhoo/augmenti/assets/30396273/f200d4dc-ea9e-4ee6-ba0d-a400a320a815)The save page^.

## Demo Pics
All of these were uploaded then augmented, since I have an iPhone and no Mac and can't test on an actual phone lol.

![demo1](https://github.com/twilkhoo/augmenti/assets/30396273/c004feac-09c6-46fa-b0e6-b029f0829763)

![demo2](https://github.com/twilkhoo/augmenti/assets/30396273/0576e104-b72e-4dc9-842a-054cebad67eb)

![demo3](https://github.com/twilkhoo/augmenti/assets/30396273/2219f11f-d58c-4e1a-8871-d7ae6eb3eaf3)

![demo4](https://github.com/twilkhoo/augmenti/assets/30396273/6fce219b-bc50-40cf-86fc-b7b097b2ee7b)

## Next steps
- Animations
- Apple sign in flow (required for publishing on App Store)
- Optimize for different screen sizes with MediaQuery methods

## Extra Notes
- The input/mask pictures must each be less than 9,437,184 pixels (e.g. 3072x3072, 4096x2304, etc.), which is ensured by scaling down the raw camera picture before invoking the Inpainting API.

- As recommended, feathering the edges of the mask leads to better results at the borders, so a Gaussian blur is applied by default.
