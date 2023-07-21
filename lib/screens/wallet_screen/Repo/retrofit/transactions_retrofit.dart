import '/screens/wallet_screen/Repo/model/Transactions_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '/../../../utils/urls.dart';

part 'transactions_retrofit.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class TransactionsRestClient {
  factory TransactionsRestClient(Dio dio, {String baseUrl}) =
      _TransactionsRestClient;

  @GET("")
  Future<TransactionsModel> getTransactions(
      @Header("Authorization") String jwt);
}
