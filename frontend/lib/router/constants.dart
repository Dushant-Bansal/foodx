import 'package:flutter/material.dart' show GlobalKey, NavigatorState;

const String initialPage = '/';
const String home = '/home';
const String addProduct = 'addProduct';
const String viewProduct = 'viewProduct';
const String inventory = 'inventory';
const String toBeImplemented = 'toBeImplemented';
const String settings = 'settings';
const String spaces = 'spaces';
const String spaceSettings = 'spaceSettings';
const String shop = 'shop';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

List<String> routes = [
  home,
  '$home/$inventory',
  '$home/$spaces',
  '$home/$shop'
];
