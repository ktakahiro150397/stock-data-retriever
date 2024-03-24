import 'package:mysql_client/mysql_client.dart';

import '../model/stock_data.dart';
import 'stock_database.dart';

class MySqlStockDataBase extends StockDatabase {
  final MySQLConnectionPool pool;

  MySqlStockDataBase({required this.pool});

  @override
  Future<dynamic> insertStock(StockData stockData) async {
    final values = {
      "stock_symbol": stockData.ticker,
      "stock_date": stockData.timestamp,
      "stock_price_open": stockData.open,
      "stock_price_high": stockData.high,
      "stock_price_low": stockData.low,
      "stock_price_close": stockData.close,
      "stock_volume": stockData.volume
    };

    return await pool.transactional((conn) async => {
          await conn.execute("""
INSERT INTO `stock_data`.`stock_data` ( 
  `symbol`, 
  `ticker_date`, 
  `price_open`, 
  `price_high`, 
  `price_low`, 
  `price_close`, 
  `volume`
)
 VALUES ( 
  :stock_symbol, 
  :stock_date, 
  :stock_price_open, 
  :stock_price_high, 
  :stock_price_low, 
  :stock_price_close, 
  :stock_volume);
""", values)
        });
  }
}
