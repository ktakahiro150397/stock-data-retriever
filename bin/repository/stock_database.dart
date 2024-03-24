import '../model/stock_data.dart';

abstract class StockDatabase {
  Future<dynamic> insertStock(StockData stockData);
  Future<dynamic> clearStocks(String ticker);
}
