import 'package:flutter/foundation.dart';
import 'package:oasis_2022/screens/tickets/repository/model/showsData.dart';
import 'package:oasis_2022/screens/tickets/repository/model/signedTicketsData.dart';
import 'package:oasis_2022/screens/tickets/view_model/getAllShows_view_model.dart';

import '../view_model/get_signedtickets_view_model.dart';

class StoreController {
  static ValueNotifier<int> itemNumber = ValueNotifier(0);
  static ValueNotifier<bool> itemBoughtOrRefreshed = ValueNotifier(true);
  static String? error = null;
  static SignedTickets signedTickets = SignedTickets();

  static List<StoreItemData> storeItem = [];

  static List<String> carouselImage2 = [];

  static List<String> profShowImages = [];

  static List<dynamic> carouselItems = [];

  Future<void> initialCall() async {
    error = null;
    try {
      AllShowsData allShowsData =
          await GetShowsViewModel().retrieveAllShowData();
      GetShowsViewModel().fillController(allShowsData);
      signedTickets = SignedTickets();
      signedTickets = await GetSignedTicketsViewModel().retrieveSignedShows();
    } catch (e) {
      error = e.toString().split(':')[1];
    }
  }

  int getId(int? merchIndex) {
    if (carouselItems[itemNumber.value].runtimeType == MerchCarouselItem) {
      return (carouselItems[itemNumber.value] as MerchCarouselItem)
          .merch![merchIndex!]
          .id!;
    } else {
      return (carouselItems[itemNumber.value] as StoreItemData).id!;
    }
  }
}
