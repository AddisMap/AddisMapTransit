import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:trufi_core/base/blocs/map_tile_provider/map_tile_provider.dart';

class OpenPlaceGuideMapTile extends MapTileProvider {
  @override
  List<LayerOptions> buildTileLayerOptions() {
    return [
      TileLayerOptions(
        urlTemplate: "https://africa.tiles.openplaceguide.org/styles/bright/{z}/{x}/{y}.png",
        tileProvider: const DefaultMapTileCaching(),
      ),
    ];
  }

  @override
  String get id => "OpenPlaceGuideMapTile";

  @override
  WidgetBuilder get imageBuilder => (context) => Image.asset(
        "assets/images/OpenMapTiles.png",
        package: "trufi_core",
        fit: BoxFit.cover,
      );

  @override
  String name(BuildContext context) {
    return id;
  }
}

class OSMMapLayer extends MapTileProvider {
  final String? mapTilesUrl;

  OSMMapLayer({
    required this.mapTilesUrl,
  }) : super();

  @override
  List<LayerOptions> buildTileLayerOptions() {
    return [
      TileLayerOptions(
        urlTemplate: mapTilesUrl,
        subdomains: ['a', 'b', 'c'],
        tileProvider: const DefaultMapTileCaching(),
      ),
    ];
  }

  @override
  String get id => "OpenPlaceGuideMapTile";

  @override
  WidgetBuilder get imageBuilder => (context) => Image.asset(
        "assets/images/OpenMapTiles.png",
        fit: BoxFit.cover,
      );

  @override
  String name(BuildContext context) {
    return id;
  }
}

class DefaultMapTileCaching extends TileProvider {
  const DefaultMapTileCaching();

  @override
  ImageProvider getImage(Coords coords, TileLayerOptions options) {
    return CachedNetworkImageProvider(getTileUrl(coords, options));
  }
}
