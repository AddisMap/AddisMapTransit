import 'package:flutter/material.dart';
import 'package:trufi_core/base/blocs/map_configuration/map_configuration_cubit.dart';
import 'package:trufi_core/base/blocs/theme/theme_cubit.dart';
import 'package:trufi_core/base/models/trufi_latlng.dart';
import 'package:trufi_core/base/utils/graphql_client/hive_init.dart';
import 'package:trufi_core/base/widgets/drawer/menu/social_media_item.dart';
import 'package:trufi_core/default_values.dart';
import 'package:trufi_core/trufi_core.dart';
import 'package:trufi_core/trufi_router.dart';
import 'package:addismaptransit_app/base/blocks/map_tile_provider/map_tile_provider.dart';

final ThemeData standardTheme = ThemeData();
final ThemeData darkTheme = ThemeData.dark();
const ethiopiaGreen = Color(0xff27ae60);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  runApp(
    TrufiApp(
      appNameTitle: 'AddisMapTransit',
      blocProviders: [
        ...DefaultValues.blocProviders(
          otpEndpoint: "https://pt.addismap.com/otp/routers/default",
          otpGraphqlEndpoint: "https://pt.addismap.com/otp/routers/default/index/graphql",
          mapConfiguration: MapConfiguration(
            center: const TrufiLatLng(9.005401, 38.763611),
          ),
          searchAssetPath: "",
          photonUrl: "https://photon.komoot.io",
          mapTileProviders: [OpenPlaceGuideMapTile()]
        ),
      ],
      trufiRouter: TrufiRouter(
        routerDelegate: DefaultValues.routerDelegate(
          appName: 'AddisMapTransit',
          cityName: 'Addis Ababa',
          countryName: 'Ethiopia',
          backgroundImageBuilder: (_) {
            return Image.asset(
              'assets/images/drawer-bg.jpg',
              fit: BoxFit.cover,
            );
          },
          urlFeedback: 'https://example/feedback',
          emailContact: 'example@example.com',
          urlShareApp: 'https://example/share',
          urlSocialMedia: const UrlSocialMedia(
            urlFacebook: 'https://www.facebook.com/Example',
          ),
        ),
      ),
      trufiBaseTheme: TrufiBaseTheme(themeMode: ThemeMode.system, brightness: Brightness.dark,
          theme: standardTheme.copyWith(
            colorScheme: standardTheme.colorScheme.copyWith(secondary: ethiopiaGreen),
          ),
          darkTheme: darkTheme.copyWith(
            colorScheme: darkTheme.colorScheme.copyWith(secondary: ethiopiaGreen),
          ),
      ),
    ),
  );
}
