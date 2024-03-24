class StockData {
  StockData({
    required this.ticker,
    this.timestamp,
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
  });

  String ticker = "";
  DateTime? timestamp;
  double? open;
  double? high;
  double? low;
  double? close;
  double? volume;
}
