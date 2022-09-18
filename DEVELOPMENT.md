## Creating new Search data for Addis Ababa

Warning: BBOX Params are flipped!

```
git clone https://github.com/trufi-association/osm-search-data-export.git
cd osm-search-data-export
docker build . --tag osm-search-data-export:latest
docker run --volume /tmp:/data osm-search-data-export  --input overpass --bbox "8.82,38.63,9.11,38.91"   --output json --outpath /data/search.json
cp /tmp/search.json ../AddisMapTransit/assets/data/ search.json
```