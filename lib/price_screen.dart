import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';

import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  //Dropdown Button

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

  //Dropdown loop
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

  //Cupertino Picker

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(currenciesList[selectedIndex]);
        selectedCurrency = currenciesList[selectedIndex];
      },
      children: cupertinoPickerItems(),
    );
  }

  //Cupertino Loop
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
              ),
              CoinWidget(
                coinType: 'UTC',
              ),
              CoinWidget(
                coinType: 'ETH',
              ),
              GestureDetector(
                onTap: () => print('Works'),
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
  CoinWidget({this.coinType});

  final String coinType;

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
                '1 BTC = ? USD',
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
