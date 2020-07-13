import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  static const String apiKey = '2C739D36-401F-4205-81BA-6ABBA1E4410D';

  static const String urlBase = 'https://rest.coinapi.io/v1/exchangerate';

  Future<String> getBitcoinPrice(String currency) async {
    String url = '$urlBase/BTC/$currency?apikey=$apiKey';
    http.Response response = await http.get(url);

    var json = response.body;

    var data = jsonDecode(json)['rate'];

    String price = data.toStringAsFixed(2);

    return price;
  }

  Future<String> getEthereumPrice(String currency) async {
    String url = '$urlBase/ETH/$currency?apikey=$apiKey';
    http.Response response = await http.get(url);

    var json = response.body;

    var data = jsonDecode(json)['rate'];

    String price = data.toStringAsFixed(2);

    return price;
  }

  Future<String> getLitecoinPrice(String currency) async {
    String url = '$urlBase/LTC/$currency?apikey=$apiKey';
    http.Response response = await http.get(url);

    var json = response.body;

    var data = jsonDecode(json)['rate'];

    String price = data.toStringAsFixed(2);

    return price;
  }
}
