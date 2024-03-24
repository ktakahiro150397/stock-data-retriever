import 'package:dotenv/dotenv.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:yahoofin/yahoofin.dart';
import 'model/stock_data.dart';
import 'repository/mysql_stock_database.dart';

void main(List<String> arguments) async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  final yfin = YahooFin();
  final ticker = "7211.T";

  StockHistory hist = yfin.initStockHistory(ticker: ticker);
  StockChart chart = await yfin.getChartQuotes(
      stockHistory: hist,
      interval: StockInterval.oneDay,
      period: StockRange.tenYear);

  final pool = MySQLConnectionPool(
    host: env["SQL_HOST"]!,
    port: int.parse(env["SQL_PORT"]!),
    userName: env["SQL_USER"]!,
    password: env["SQL_PASS"]!,
    maxConnections: 10,
    databaseName: env["SQL_DATABASE_NAME"]!,
  );

  final mysqlRepo = MySqlStockDataBase(pool: pool);

  if (chart.chartQuotes == null) {
    print("No data found for $ticker");
    return;
  } else {
    await mysqlRepo.clearStocks(ticker);

    for (var i = 0; i < chart.chartQuotes!.timestamp!.length; i++) {
      final addData = StockData(
        ticker: ticker,
        timestamp: DateTime.fromMillisecondsSinceEpoch(
            chart.chartQuotes!.timestamp![i].toInt() * 1000),
        open: chart.chartQuotes!.open![i].toDouble(),
        high: chart.chartQuotes!.high![i].toDouble(),
        low: chart.chartQuotes!.low![i].toDouble(),
        close: chart.chartQuotes!.close![i].toDouble(),
        volume: chart.chartQuotes!.volume![i].toDouble(),
      );

      final result = await mysqlRepo.insertStock(addData);
      print(addData);
    }
  }
  return;
}
