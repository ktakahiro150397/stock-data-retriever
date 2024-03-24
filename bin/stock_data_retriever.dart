import 'package:mysql_client/mysql_client.dart';
import 'package:stock_data_retriever/stock_data_retriever.dart'
    as stock_data_retriever;
import 'package:yahoofin/yahoofin.dart';

void main(List<String> arguments) async {
  // final yfin = YahooFin();
  // final ticker = "3679.T";

  // StockInfo info = yfin.getStockInfo(ticker: ticker);

  // // 価格を取得
  // StockQuote price = await yfin.getPrice(stockInfo: info);
  // StockQuote priceChange = await yfin.getPriceChange(stockInfo: info);

  // StockQuote volume = await yfin.getVolume(stockInfo: info);

  // print(info);
  // print(price);
  // print(priceChange);
  // print(volume);

  // StockHistory hist = yfin.initStockHistory(ticker: ticker);
  // StockChart chart = await yfin.getChartQuotes(
  //     stockHistory: hist,
  //     interval: StockInterval.oneDay,
  //     period: StockRange.fiveYear);
  // print(chart.chartQuotes!.timestamp);

  final pool = MySQLConnectionPool(
    host: "192.168.3.103",
    port: 3306,
    userName: "stock_data_user",
    password: "stockdatauser",
    maxConnections: 10,
    databaseName: "stock_data", // optional,
  );

  var result = await pool.execute("show tables;");

  // final conn = await MySqlConnection.connect(ConnectionSettings(
  //   host: "192.168.3.103",
  //   port: 3306,
  //   user: "stock_data_user",
  //   db: "stock_data",
  //   password: "stockdatauser",
  // ));

  // var result = await conn.query(
  //   "show tables",
  // );
  // final result = await conn.query("USE stock_data;");

  print(result);

  print('Hello world: ${stock_data_retriever.calculate()}!');
}
