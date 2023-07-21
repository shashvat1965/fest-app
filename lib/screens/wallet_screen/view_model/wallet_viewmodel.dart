import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../Repo/model/Transactions_model.dart';
import '../Repo/retrofit/transactions_retrofit.dart';
import '/provider/user_details_viewmodel.dart';
import '/screens/wallet_screen/Repo/model/add_swd_model.dart';
import '/screens/wallet_screen/Repo/model/balance_model.dart';
import '/screens/wallet_screen/Repo/model/qr_to_id.dart';
import '/screens/wallet_screen/Repo/model/refresh_qr.dart';
import '/screens/wallet_screen/Repo/model/send_money_model.dart';
import '/screens/wallet_screen/Repo/retrofit/balance_retrofit.dart';
import '/screens/wallet_screen/Repo/retrofit/qr_to_id_retrofit.dart';
import '/screens/wallet_screen/Repo/retrofit/refresh_qr_retrofit.dart';
import '/screens/wallet_screen/Repo/retrofit/send_money_retrofit.dart';
import '/screens/wallet_screen/Repo/retrofit/swd_retrofit.dart';
import '/utils/error_messages.dart';

class WalletViewModel {
  static int balance = 0;
  static bool isKindActive = false;
  static int? kindpoints = 0;
  String? jwt = UserDetailsViewModel.userDetails.JWT;
  static String? error;

  Future<String> refreshQrCode(int id) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    String auth = "JWT $jwt";
    String qr_code;
    final refreshQrRestClient = RefreshQrRestClient(dio);
    try {
      RefreshQrResponseModel refreshQrResponseModel =
          await refreshQrRestClient.refreshQr(auth, RefreshQrPostModel(id: id));
      qr_code = refreshQrResponseModel.qr_code;
    } on DioError catch (e) {
      throw Exception(e.response!.statusCode);
    }
    return qr_code;
  }

  Future<int> getId(String qr_code) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    String auth = "JWT ${UserDetailsViewModel.userDetails.JWT}";
    int id = -1;
    final qrToIdModelRestClient = QrToIdModelRestClient(dio);
    try {
      QrToIdModel qrToIdModel =
          await qrToIdModelRestClient.getId(auth, qr_code);
      print(qrToIdModel.id);
      id = qrToIdModel.id!;
    } on DioError catch (e) {
      throw Exception(e.response?.statusCode);
    }
    return id;
  }

  Future<TransactionsModel> getTransactions() async {
    final dio = Dio();
    final client = TransactionsRestClient(dio);
    String? jwt = UserDetailsViewModel.userDetails.JWT;
    String auth = "JWT $jwt";
    TransactionsModel transactions = await client.getTransactions(auth);
    return transactions;
  }

  Future<void> getBalance() async {
    error = null;
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    String auth = "JWT $jwt";
    final balanceRestClient = BalanceRestClient(dio);
    BalanceModel response = BalanceModel(
        data: BalanceData(
            cash: 0,
            pg: 0,
            swd: 0,
            transfers: 0,
            kind_active: false,
            kind_points: 0));
    response = await balanceRestClient.getBalance(auth).then((it) {
      return it;
    }).catchError((Object obj) {
      print('error caught');
      try {
        print('hi');
        final res = (obj as DioError).response;
        error = res?.statusCode.toString();
        if (res?.statusCode == null || res == null) {
          error = ErrorMessages.noInternet;
        } else {
          error = ErrorMessages.unknownError;
          if(res?.statusCode.toString() == "401"){
            Hive.box("firstRun").clear();
            error = ErrorMessages.unauthError;
          }
          print('goes here error in wallet');
          //TODO: make a handler
        }
      } catch (e) {
        print('goes to unknown error');
        print(e);
        error = ErrorMessages.unknownError;
      }
      return response;
    });
    balance = (response.data?.swd ?? 0) +
        (response.data?.cash ?? 0) +
        (response.data?.transfers ?? 0) +
        (response.data?.pg ?? 0);
    isKindActive = response.data?.kind_active ?? false;
    kindpoints = response.data?.kind_points ?? 0;
// catch (e) {
//   if (e.runtimeType == DioError) {
//     DioError errore = e as DioError;
//     var response = errore.response;
//     if (response == null) {
//       error=ErrorMessages.noInternet;
//       throw Exception("No Connection");
//
//     } else {
//       error=ErrorMessages.unknownError;
//       throw Exception(response.statusCode);
//     }
//   }
// }
  }

  Future<void> addMoney(int amount) async {
    AddSwdPostRequestModel addSwdPostRequestModel =
        AddSwdPostRequestModel(amount: amount);
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    String auth = "JWT $jwt";
    final addMoneyRestClient = AddMoneyRestClient(dio);
    try {
      print('ekjfhwn');
      await addMoneyRestClient.addFromSwd(auth, addSwdPostRequestModel);
      print('ekjfhwnef');
    } catch (e) {
      print('hihello');
      if (e.runtimeType == DioError) {
        DioError error = e as DioError;
        var response = error.response;
        if (response == null) {
          throw Exception("No Connection");
        } else {
          throw Exception(response.statusCode);
        }
      }

      throw Exception("Server error");
    }
  }

  Future<void> sendMoney(int id, int amount) async {
    SendMoneyThroughIdModel sendMoneyThroughIdModel =
        SendMoneyThroughIdModel(id: id, amount: amount);
    final dio = Dio();
    String auth = "JWT $jwt";
    final sendMoneyRestClient = SendMoneyRestClient(dio);
    try {
      await sendMoneyRestClient.postMoneyTransfer(
          sendMoneyThroughIdModel, auth);
    } catch (e) {
      if (e.runtimeType == DioError) {
        DioError error = e as DioError;
        var response = error.response;
        if (response == null) {
          throw Exception("No Connection");
        } else {
          throw Exception(response.statusCode);
        }
      }
    }
    return;
  }

  int getdate(TransactionsModel transactions, int i) {
    List day = [];
    int? date;

    day.addAll([transactions.txns[i].time![8], transactions.txns[i].time![9]]);
    date = int.parse(day.join().toString());
    return date;
  }

  int getTime(TransactionsModel transactions, int i) {
    List time = [];
    int? timestamp;
    time.addAll([
      transactions.txns[i].time![11],
      transactions.txns[i].time![12],
      transactions.txns[i].time![14],
      transactions.txns[i].time![15],
      transactions.txns[i].time![17],
      transactions.txns[i].time![18],
    ]);
    timestamp = int.parse(time.join().toString());
    return timestamp;
  }

  List<TransactionsData> getGroupTransactions(TransactionsModel transactions) {
    List<TransactionsData> groupedtransactions = [];
    int? date1, date2;
    int? timestamp1, timestamp2;
    int count = 1;
    for (int i = 0; i <= transactions.txns.length - 1; i++) {
      if (i != transactions.txns.length - 1) {
        date1 = getdate(transactions, i);
        date2 = getdate(transactions, i + 1);
        timestamp1 = getTime(transactions, i);
        timestamp2 = getTime(transactions, i + 1);
        if (transactions.txns[i].name == transactions.txns[i + 1].name &&
            date1 == date2 &&
            timestamp1 - timestamp2 <= 5) {
          count++;
        } else {
          print(count);
          transactions.txns[i].price =
              ((transactions.txns[i].price ?? 0) * count);
          print(transactions.txns[i].name);
          print(transactions.txns[i].price);
          groupedtransactions.add(transactions.txns[i]);
          // print(groupedtransactions[i].name);
          //print(groupedtransactions[i].price);
          count = 1;
        }
      } else {
        print(count);
        transactions.txns[i].price =
            ((transactions.txns[i].price ?? 0) * count);
        print(transactions.txns[i].name);
        print(transactions.txns[i].price);
        groupedtransactions.add(transactions.txns[i]);
        // print(groupedtransactions[i].name);
        //print(groupedtransactions[i].price);
      }
    }

    return groupedtransactions;
  }
}
