import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';

import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];

  List prices = [];

  String bitcoin = '?';
  String ethereum = '?';
  String litecoin = '?';
  CoinData coinData = CoinData();

  // ! Make all the requests
  void requests() async {
    String btc = await coinData.getBitcoinPrice(selectedCurrency);
    setState(() {
      bitcoin = btc;
    });
    btc = await coinData.getEthereumPrice(selectedCurrency);
    setState(() {
      ethereum = btc;
    });
    btc = await coinData.getLitecoinPrice(selectedCurrency);
    setState(() {
      litecoin = btc;
    });
  }

  // * Dropdown Button
  DropdownButton androidDropdown() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: createDropdown(),
      onChanged: (value) {
        print(value);
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  // * Dropdown loop
  List<DropdownMenuItem<String>> createDropdown() {
    List<DropdownMenuItem<String>> dropdownItens = [];

    for (String currency in currenciesList) {
      DropdownMenuItem dropdownMenuItem = DropdownMenuItem<String>(
        child: Text(currency),
        value: currency,
      );

      dropdownItens.add(dropdownMenuItem);
    }

    return dropdownItens;
  }

  // * Cupertino Picker

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          bitcoin = '?';
          ethereum = '?';
          litecoin = '?';
        });
      },
      children: cupertinoPickerItems(),
    );
  }

  // * Cupertino Loop
  List<Text> cupertinoPickerItems() {
    List<Text> pickerItem = [];

    for (String currency in currenciesList) {
      Text text = Text(
        currency,
        style: TextStyle(color: Colors.white),
      );

      pickerItem.add(text);
    }

    return pickerItem;
  }

  Widget getPicker() {
    if (Platform.isAndroid) {
      return iosPicker();
    } else if (Platform.isIOS) {
      return androidDropdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    createDropdown();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CoinWidget(
                coinType: 'BTC',
                currency: selectedCurrency,
                price: bitcoin,
              ),
              CoinWidget(
                coinType: 'ETH',
                currency: selectedCurrency,
                price: ethereum,
              ),
              CoinWidget(
                coinType: 'LTC',
                currency: selectedCurrency,
                price: litecoin,
              ),
              GestureDetector(
                onTap: () => requests(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.purple,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 28.0),
                          child: Text(
                            'Get Coins price',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 200.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.purple,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}

class CoinWidget extends StatelessWidget {
  CoinWidget({this.coinType, this.currency, this.price});

  final String coinType;
  final String currency;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.purple,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
              child: Text(
                '1 $coinType = $price $currency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
