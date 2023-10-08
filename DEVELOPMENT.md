# Development

## TrufiCore

Based on Trufi Core https://github.com/AddisMap/trufi-core/releases/

* Tag new Trufi Core release, update pubspec.yaml

## Stack

* Flutter 3.3.3
* Africa Tiles
* For Android and iOS

## Creating new Search data for Addis Ababa

Warning: BBOX Params are flipped!

```
git clone https://github.com/trufi-association/osm-search-data-export.git
cd osm-search-data-export
docker build . --tag osm-search-data-export:latest
docker run --volume /tmp:/data osm-search-data-export  --input overpass --bbox "8.82,38.63,9.11,38.91" --output json-compact --outpath /data/search.json
cp /tmp/search.json ../AddisMapTransit/assets/data/search.json
```

## Fastlane

See also [Fastlane.tools](https://docs.fastlane.tools/getting-started/android/setup/)
```bash
sudo apt install ruby ruby-dev
sudo gem install fastlane
```

### Releasing / Uploading to Google Play

1. Bump version in pubspec.yaml
2. Add changelog in `fastlane/metadata/android/en-US/changelogs`
2. Push to GitHub, merge to master, make a new tag
 
#### GitHub Release
3. `flutter build apk  --analyze-size --target-platform android-arm`
4. Upload apk to GitHub

### Playstore Release

5. Build an use fastlane supply
```
flutter build appbundle
cd android && fastlane supply --track internal --aab ../build/app/outputs/bundle/release/app-release.aab --version-code x # replace by the version code from pubspec.yaml 
```
6. Go to [playstore](https://play.google.com/console/u/0/developers/?pli=1), check everything and promote from the internal to the the public track

### Taking Screenshots

1. Open Browserstack
2. Google Pixel 6

Save in android/fastlane/metadata/android/en-US/images/phoneScreenshots

Screenshot 1 - Start app / overview screen
Screenshot 2 - Routeplanner (to Show map), then open side drawer
Screenshot 3 - Parking Airport to Bandira Addis Map -> Overview of routes (no map)
Screenshot 4 - pull down overview, show map as well
Screenshot 5 - Your places (after favoriting Bandira Addis Map)
Screenshot 6 - Show routes

4. Galaxy Tab S7
5. Rotate Device

Save android/fastlane/metadata/android/en-US/images/tenInchScreenshots + sevenInchScreenshots 

For iOS:

BrowserStack -> TestFlight -> Sign In
* iPhone 11 Pro Max (6.5" screen)
* iPhone 8 Plus (5.5" screen)
* iPad Pro 12.9 2021 (6th gen)
* iPad Pro 12.9 2017 (2th gen)

### Building compact APK for GitHub Release

`flutter build apk  --analyze-size --target-platform android-arm`

## iOS

We are developing at MacStadium.com (thank you!)

### Installation on a fresh MacMini

* Install Xcode via App Store (Free)
  * Also run `xcode-select --install` to install Cmdline tools
  * `sudo xcode-select -s /Applications/Xcode.app/Contents/Developer`
  * open xcode, accept licenses
* Refer to https://docs.flutter.dev/get-started/install/macos to install flutter
  * Download the ZIP, extract to development/
  * Add path to .bash_profile `export PATH="$PATH:/Users/administrator/development/flutter/bin"`
  * `flutter doctor`
  * install homebrew
    * `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
  * install [cocoapods](https://guides.cocoapods.org/using/getting-started.html#installation)
    * `brew install cocoapods`
* Clone this git `cd ~/development && git clone https://github.com/AddisMap/addismaptransit`
* `cd addismaptransit` 
* Setup signing as instructed by `flutter build ios`
  * open ios/Runner.xcworkspace
  * Select or create development signing certificate

### Archiving 

Eventually upgrade flutter, check with `flutter doctor`

```
cd development/addismaptransit
git pull
flutter build ios
```

* First create the new version in https://appstoreconnect.apple.com/apps

In Xcode:

* Product -> Destination -> Any iOS Device 
* Product -> Archive (if already built: Window -> Organizer -> Archives)
* Opens the uploader, select current most recent version, click Distribute, Next, App store connect, 
  * Next, Upload, Next,
  * All options, Next,
  * Automatically manage signing, of this is is not working:
    * Manual manage signing, next...
    * Use apple distribution certificate
    * Create profile: https://developer.apple.com/account/resources/profiles/add Distribution - App Store
    * Runner.app Download Profile
* The local keychain needs to be opened: click always allow ! not only allow ! (use the login password)
* Publish via https://appstoreconnect.apple.com/apps
  * Choose the app
  * Click the little "+" icon to create a new store version
  * Enter the store version manually
  * Paste he changelog
  * Eventually wait some time until the build can be selected (you should receive and email notification)
* Click save, then add for review
* Submit to App Review

#### Common Issues

* "the request expected results but none were found - error while generation code signature" in the last step when uploading
  * Signature expired? Follow the steps above 
* Local keychain password keeps asking again and again:
  * It's the login password
  * Window might have appeared multiple times
  * use Always Allow
  * see also https://stackoverflow.com/a/50657877/288568

