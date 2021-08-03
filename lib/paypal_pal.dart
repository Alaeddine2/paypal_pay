library paypal_pal;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:enum_to_string/enum_to_string.dart';

/// Describes the state of JavaScript support in a given web view.
enum PayementMode {
  /// Payement execution is in sandbox mode.
  sandbox,

  /// Payement execution is in live mode.
  live,
}

enum Currency {
  AUD, // Australian dollar	
  BRL, // Brazilian real
  CAD, // Canadian dollar	
  CNY, // Chinese Renmenbi	
  CZK, // Czech koruna
  DKK, // Danish krone		
  EUR, // EUR
  HKD, // Hong Kong dollar	
  HUF, // Hungarian forint
  JPY, // Japanese yen
  MYR, // Malaysian ringgit
  MXN, // Mexican peso	
  TWD, // New Taiwan dollar
  NZD, // New Zealand dollar	
  NOK, // Norwegian krone	
  PHP, // Philippine peso	
  PLN, // Pound sterling	
  GBP, // Pound sterling	
  RUB, // Russian ruble	
  SGD, // Singapore dollar	
  SEK, // Swedish krona	
  CHF, // Swiss franc	
  THB, // Thai baht	
  USD // United States dollar	
}

class PayPalPayer extends StatefulWidget{
  //Client Id from paypal dashboard
  final String client_id;
  
  //secret from paypal dashboard
  final String secret;
  
  //secret from paypal dashboard
  final PayementMode mode;

  //Total Payement value
  final double price;
  
  //Currency 
  final Currency currency;
  //Description for paiement service
  final String description;

  //Submit payement
  final Function onPaymentSuccessed;

  //cancel payement
  final Function onPaymentCanceled;

  //cancel payement
  final Function(String) onPaymentFailed;

  const PayPalPayer({
    @required this.client_id,
    @required this.secret,
    this.mode = PayementMode.sandbox,
    @required this.price,
    this.currency = Currency.USD,
    this.description = "",
    @required this.onPaymentSuccessed,
    @required this.onPaymentCanceled,
    @required this.onPaymentFailed
  });

  @override
  _PayPalPayer createState() => _PayPalPayer();  

}

class _PayPalPayer extends State<PayPalPayer>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
        onPageFinished: (page) {
          if(page.contains('paypal/success')){
            //print(page);
            widget.onPaymentSuccessed();
          }
          if(page.contains('paypal/failed')){
            //print(page);
            widget.onPaymentCanceled();
          }
          if(page.contains('paypal/error')){
            //print(page);
            var data = page.split("paypal/error?case=");
            widget.onPaymentFailed(data[1]);
          }
        },
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://paypal-plugin.herokuapp.com/paypal/pay?price=' + widget.price.toString() + '&currency=' + EnumToString.parse(widget.currency) +'&mode=' + EnumToString.parse(widget.mode) + '&client_id=' + widget.client_id + '&secret=' + widget.secret + '&description=' + widget.description,
      );
  }
}