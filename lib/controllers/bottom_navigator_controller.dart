import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:the_movie_app/screens/home_screen.dart';
import 'package:the_movie_app/screens/search_screen.dart';
import 'package:the_movie_app/screens/watch_list_screen.dart';

class BottomNavigatorController extends GetxController {
  var screens = [
    HomeScreen(),
    const SearchScreen(),
    WatchList(),
  ];
  var index = 0.obs;
  void setIndex(indx) => index.value = indx;
}
