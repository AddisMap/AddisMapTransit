## Creating new Search data for Addis Ababa

Warning: BBOX Params are flipped!

```
git clone https://github.com/trufi-association/osm-search-data-export.git
cd osm-search-data-export
docker build . --tag osm-search-data-export:latest
docker run --volume /tmp:/data osm-search-data-export  --input overpass --bbox "8.82,38.63,9.11,38.91" --output json-compact --outpath /data/search.json
cp /tmp/search.json ../AddisMapTransit/assets/data/ search.json
```

## Fastlane

See also [Fastlane.tools](https://docs.fastlane.tools/getting-started/android/setup/)
```bash
sudo apt install ruby ruby-dev
sudo gem install fastlane
```

### Uploading

```
cd android && fastlane supply --track internal --version-code 2
```

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
Screenshot 1 - Airport Parking -> Bandira -> Routes and Map overview

### Building compact APK for GitHub Release

`flutter build apk  --analyze-size --target-platform android-arm`
