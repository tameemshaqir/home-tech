import 'package:app_links/app_links.dart';
import 'package:ecommerce/cubits/deep_linke_cubit/deep_link.dart';

final AppLinks _appLinks = AppLinks();

void setupDeepLinkListener(DeepLinkCubit deepLinkCubit) {
  // الاستماع لروابط التطبيق المفتوحة أثناء التشغيل
  _appLinks.uriLinkStream.listen((uri) {
    if (uri != null) {
      deepLinkCubit.handleDeepLink(uri);
    }
  });

  // التعامل مع الرابط الأولي (فتح التطبيق من رابط)
  // _appLinks.stringLinkStream.then((uri) {
  //   if (uri != null) {
  //     deepLinkCubit.handleDeepLink(uri);
  //   }
  // });
}
