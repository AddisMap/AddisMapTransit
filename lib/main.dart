import 'package:flutter/material.dart';
import 'package:trufi_core/base/blocs/localization/trufi_localization_cubit.dart';
import 'package:trufi_core/base/blocs/map_configuration/map_configuration_cubit.dart';
import 'package:trufi_core/base/blocs/theme/theme_cubit.dart';
import 'package:trufi_core/base/models/trufi_latlng.dart';
import 'package:trufi_core/base/pages/about/translations/about_localizations.dart';
import 'package:trufi_core/base/pages/feedback/translations/feedback_localizations.dart';
import 'package:trufi_core/base/pages/saved_places/translations/saved_places_localizations.dart';
import 'package:trufi_core/base/utils/graphql_client/hive_init.dart';
import 'package:trufi_core/base/widgets/drawer/menu/social_media_item.dart';
import 'package:trufi_core/base/widgets/screen/lifecycle_reactor_notification.dart';
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
          searchAssetPath: "assets/data/search.json",
          photonUrl: "https://photon.komoot.io",
          mapTileProviders: [OpenPlaceGuideMapTile()],
        ),
      ],
      trufiLocalization:
        const TrufiLocalization(
          currentLocale: Locale("en"),
          localizationDelegates: [
            SavedPlacesLocalization.delegate,
            FeedbackLocalization.delegate,
            AboutLocalization.delegate,
          ],
          supportedLocales: [
            Locale('en'),
            Locale('am'),
          ],
        ),
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
          urlFeedback: 'https://addismaptransit.com/support/',
          emailContact: 'info@addismap.com',
          urlShareApp: 'https://addismaptransit.com/store.php',
          urlSocialMedia: const UrlSocialMedia(
            urlFacebook: 'https://www.facebook.com/AddisMapTransit',
            urlTwitter: 'https://www.twitter.com/AddisMapTransit',
          ),
          lifecycleReactorHandler: LifecycleReactorNotifications(
            url:
            'https://addismaptransit.com/app_static_files/notification.json',
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
