import 'package:flutter/material.dart';

class AccountsPage extends StatefulWidget {
  static const String id = 'accounts_page';
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add your card'),
        backgroundColor: Color(0xFFC21A26),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 35,
                      backgroundImage: AssetImage('images/visacard.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 35,
                      backgroundImage: AssetImage('images/vervecard.jpg'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 30,
                      backgroundImage: AssetImage('images/mastercard.jpg'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 30,
                      backgroundImage: AssetImage('images/AmericanExpress.png'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'In our bid to provide you with seamless service,'
                  ' a temporary debit may be made and reimbursed on validation',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.redAccent, fontSize: 18),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.phone,
                      autofocus: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.credit_card,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textColor: Colors.white,
                  color: Color(0xFFC21A26),
                  onPressed: () {
                    // validate with paystack
                  },
                  child: Text(
                    'Done',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
