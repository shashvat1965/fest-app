import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:oasis_2022/screens/events/view_model/misc_events_view_model.dart';

import '../repository/model/miscEventResult.dart';

class CachedMiscEventsViewModel {
  static String? error;
  static List<MiscEventData> miscEventList = <MiscEventData>[];
  static Map<int, List<int>> miscEventSortedMap = {}; //19:[1,3,4,6],20:[]....
  final _box = Hive.box<MiscEventList>('miscEventListBox');
  static ChangeNotifier status =
      ChangeNotifier(); //0 is initial state, 1 is its in hive and read from hive, 2 is read from network call
  static int statusInt =
      0; //0 is initial state, 1 is its in hive and read from hive, 2 is read from network call

  mergedRetriveMiscResult() {
    readFromBox();
    retrieveMiscEventResult();
  }

  Future<void> retrieveMiscEventResult() async {
    print('goes in network call');
    List<MiscEventData> networkMiscEventList = [];
    Map<int, List<int>> networkMiscEventSortedMap = {};
    List<MiscEventCategory> miscEventCategoryList = [];
    error = null;
    miscEventCategoryList =
        await MiscEventsViewModel().retrieveMiscEventResult();
    int indexPosition = 0;
    for (MiscEventCategory miscEventCategory in miscEventCategoryList) {
      if (miscEventCategory.events != null &&
          miscEventCategory.category_name != 'visitors') {
        for (MiscEventData miscevent in miscEventCategory.events!) {
          String a = miscevent.date_time ?? '2022-11-23T19:42:24z';

          try {
            var p = DateTime.parse(a);
            if (!(networkMiscEventSortedMap.containsKey(p.day))) {
              networkMiscEventSortedMap.putIfAbsent(
                  p.day, () => [indexPosition]);
            } else {
              networkMiscEventSortedMap.update(p.day, (oldList) {
                oldList.add(indexPosition);
                return oldList;
              });
            }
          } catch (e) {
            //TBA
            if (!(networkMiscEventSortedMap.containsKey(19))) {
              networkMiscEventSortedMap.putIfAbsent(19, () => [indexPosition]);
            } else {
              networkMiscEventSortedMap.update(19, (oldList) {
                oldList.add(indexPosition);
                return oldList;
              });
            }
          }
          indexPosition++;
          networkMiscEventList.add(miscevent);
        }
      }
    }

    if (networkMiscEventList.isNotEmpty) {
      miscEventList = networkMiscEventList;
      miscEventSortedMap = networkMiscEventSortedMap;
      statusInt = 2;
      status.notifyListeners();
      print('storing');
      storeInBox();
    }
    print('goes out of network');
    error = MiscEventsViewModel.error;
  }

  Future<void> storeInBox() async {
    await _box.put('a', MiscEventList(miscEventList));
    print('stored, length is');
    print(_box.values.toList().cast<MiscEventList>()[0].events?.length);
  }

  Future<bool> readFromBox() async {
    print('goes in local');
    miscEventList = _box.values.toList().cast<MiscEventList>().isNotEmpty
        ? _box.values.toList().cast<MiscEventList>()[0].events ?? []
        : [];
    if (miscEventList.isEmpty) {
      print('goes in empty database condition');
      return false;
    }

    miscEventSortedMap = {};
    int indexPosition = 0;
    for (MiscEventData miscevent in miscEventList) {
      String a = miscevent.date_time ?? '2022-11-23T19:42:24z';

      try {
        var p = DateTime.parse(a);
        if (!(miscEventSortedMap.containsKey(p.day))) {
          miscEventSortedMap.putIfAbsent(p.day, () => [indexPosition]);
        } else {
          miscEventSortedMap.update(p.day, (oldList) {
            oldList.add(indexPosition);
            return oldList;
          });
        }
      } catch (e) {
        //TBA
        if (!(miscEventSortedMap.containsKey(19))) {
          miscEventSortedMap.putIfAbsent(19, () => [indexPosition]);
        } else {
          miscEventSortedMap.update(19, (oldList) {
            oldList.add(indexPosition);
            return oldList;
          });
        }
      }
      indexPosition++;
    }
    statusInt = 1;
    status.notifyListeners();
    print('goes out of local');
    return true;
  }

  List<MiscEventData> retrieveSearchMiscEventData(int day_no, String text) {
    List<MiscEventData> searchedMiscEventList = [];
    text = text.toLowerCase();
    if (miscEventSortedMap.containsKey(day_no)) {
      for (int element in miscEventSortedMap[day_no] ?? []) {
        if (((miscEventList[element].name == null)
                ? false
                : miscEventList[element].name!.toLowerCase().contains(text)) ||
            ((miscEventList[element].organiser == null)
                ? false
                : miscEventList[element]
                    .organiser!
                    .toLowerCase()
                    .contains(text)) ||
            ((miscEventList[element].about == null)
                ? false
                : miscEventList[element].about!.toLowerCase().contains(text)))
          searchedMiscEventList.add(miscEventList[element]);
      }
    }
    return searchedMiscEventList;
  }

  List<MiscEventData> retrieveDayMiscEventData(int day_no) {
    List<MiscEventData> assortedMiscEventList = [];
    if (miscEventSortedMap.containsKey(day_no)) {
      for (var element in miscEventSortedMap[day_no] ?? []) {
        assortedMiscEventList.add(miscEventList[element]);
      }
    }
    return assortedMiscEventList;
  }
}
