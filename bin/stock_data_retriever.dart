import 'package:dotenv/dotenv.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:stock_data_retriever/stock_data_retriever.dart'
    as stock_data_retriever;
import 'model/stock_data.dart';
import 'repository/mysql_stock_database.dart';

void main(List<String> arguments) async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

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
    host: env["SQL_HOST"]!,
    port: int.parse(env["SQL_PORT"]!),
    userName: env["SQL_USER"]!,
    password: env["SQL_PASS"]!,
    maxConnections: 10,
    databaseName: env["SQL_DATABASE_NAME"]!,
  );

  final mysqlRepo = MySqlStockDataBase(pool: pool);

  final addData = StockData(
    ticker: "1234",
    timestamp: DateTime.now(),
    open: 100.0,
    high: 200.0,
    low: 50.0,
    close: 150.0,
    volume: 12345,
  );

  final result = await mysqlRepo.insertStock(addData);

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
