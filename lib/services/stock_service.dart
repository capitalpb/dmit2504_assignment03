import 'package:dmit2504_assignment03/services/network_service.dart';

class StockService {
  static const apiToken = 'QTVXCOASBD3ZIC1J';

  static Uri _getRequestUrl(String symbol, String function) => Uri(
        scheme: 'https',
        host: 'www.alphavantage.co',
        path: '/query',
        query: 'function=$function&symbol=$symbol&apikey=$apiToken',
      );

  static Future getCompanyInfo(String symbol) async {
    final requestUrl = _getRequestUrl(symbol, 'OVERVIEW');
    return await NetworkService.getData(requestUrl);
  }

  static Future getQuote(String symbol) async {
    final requestUrl = _getRequestUrl(symbol, 'GLOBAL_QUOTE');
    return await NetworkService.getData(requestUrl);
  }
}
