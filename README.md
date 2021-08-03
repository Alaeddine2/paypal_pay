# paypal_pal

A flutter plugin that allows user to submit paypal payment.


## Platform Support

 | Android  |  iOS |  MacOS | Web  | Windows  |
|---|---|---|---|---|
|  :heavy_check_mark:  |  :heavy_check_mark:  | :x:  | :x:  |  :x: |

## Usage

 - To use this plugin, add  `paypal_pal`  as a  [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).
 - You need to register for a developer account and get your client_id and secret at  [PayPal Developer Portal](https://developer.paypal.com/).

**Permissions**
On Android you'll need to add either the ```
INTERNET
``` permission to your Android Manifest. To do so open the AndroidManifest.xml file (located under android/app/src/main) and add one of the following two lines as direct children of the `<manifest>` tag :

```xml
<manifest xmlns:android="...">
  <uses-permission android:name="android.permission.INTERNET"/> <!-- Add this -->
</manifast>
```
### Example

    import  'package:flutter/material.dart';
    import  'package:paypal_pal/paypal_pal.dart';
    
    class  MyHomePage  extends  StatefulWidget {
	    MyHomePage({Key  key, this.title}) : super(key: key);
	    final  String  title;
    @override
	    _MyHomePageState  createState() => _MyHomePageState();
    }
    class  _MyHomePageState  extends  State<MyHomePage> {
	    int  _counter = 0;
	    bool  isLaunched = false;
	    void  _incrementCounter() {
		    setState(() {
			    isLaunched = !isLaunched;
		    });
	    }
	    @override
	    Widget  build(BuildContext  context) {
		    return  Scaffold(
			    appBar: AppBar(
			    title: Text(widget.title),
		    ),
		    body: isLaunched ?
		    PayPalPayer(
			    client_id: "your client id",
			    price: 25.00,
			    secret: "your secret",
			    currency: Currency.JPY,
			    description: 'Description....',
			    onPaymentCanceled: (){
				    print("Canceled");
				    setState(() {
				    isLaunched = !isLaunched;
				    });
			    },
			    onPaymentSuccessed: (){
				    print("Success");
				    setState(() {
				    isLaunched = !isLaunched;
				    });
				},
			    onPaymentFailed: (error){
				    print("Failed " + error);
				    setState(() {
				    isLaunched = !isLaunched;
				    });
				},
			    ) :
			    Center(
				    child: Column(
					    mainAxisAlignment: MainAxisAlignment.center,
					    children: <Widget>[
						    Text(
						    'You have pushed the button this many times:',
						    ),
						    Text(
						    '$_counter',
						    style: Theme.of(context).textTheme.headline4,
						    ),
					    ],
					    ),
				    ),
			    floatingActionButton: FloatingActionButton(
				    onPressed: _incrementCounter,
				    child: Icon(Icons.add),
				    ),
			    );
		    }
    }