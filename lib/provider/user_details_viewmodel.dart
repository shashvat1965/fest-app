
import '../provider/user_details_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../screens/login/repository/model/data.dart';
//afterwards in the app use userDetailsViewModel().userDetails.userId to access

class UserDetailsViewModel {
  static UserDetails userDetails = UserDetails();
  final storage = const FlutterSecureStorage();

  Future<void> loadDetails() async {
    print('load details function called');
    userDetails.username = await storage.read(key: 'username');
    userDetails.JWT = await storage.read(key: 'jwt');
    userDetails.userID = await storage.read(key: 'userid');
    userDetails.referralCode = await storage.read(key: 'referralcode');
    userDetails.isBitsian =
        await storage.read(key: 'isBitsian') == 'true' ? true : false;
    userDetails.doesUserExist =
        await storage.read(key: "doesUserExist") == 'true' ? true : false;
    userDetails.qrCode = await storage.read(key: 'qrcode');

    // notifyListeners();
  }

  Future<bool> userCheck() async {
    await loadDetails();
    if (userDetails.doesUserExist == true && userDetails.JWT != null) {
      return true;
    }
    return false;
  }

  void removeUser() async {
    userDetails.username = null;
    userDetails.userID = null;
    userDetails.referralCode = null;
    userDetails.qrCode = null;
    userDetails.doesUserExist = null;
    userDetails.isBitsian = null;
    await storage.deleteAll();
    //await CartDatabaseHelper.instance.clearTable();
    // notifyListeners();
  }

  void readValues(AuthResult auth) {
    userDetails.quick_uID = auth.user_id.toString();
  }
}
