import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  DynamicLinkService._internal();

  static final DynamicLinkService _instance = DynamicLinkService._internal();
  static DynamicLinkService get intance => _instance;

  Future<void> handleDynamicLinks({
    void Function(Uri url)? onLinkTapped,
  }) async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(data, onLinkTapped);

    FirebaseDynamicLinks.instance.onLink.listen(
      (PendingDynamicLinkData dynamicLink) async {
        _handleDeepLink(dynamicLink, onLinkTapped);
      },
    );
  }

  void _handleDeepLink(
    PendingDynamicLinkData? data,
    Function(Uri url)? onLinkTapped,
  ) {
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      onLinkTapped?.call(deepLink);
    }
  }
}
