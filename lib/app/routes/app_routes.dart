import 'package:damishop/app/views/home_shell.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const String home = '/';

  static final List<GetPage> pages = [
    GetPage(name: home, page: () => HomeShell()),
  ];
}
