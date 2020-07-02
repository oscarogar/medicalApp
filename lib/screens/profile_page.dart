import 'package:flutter/material.dart';

final backgroundColor = Color(0XFF4A4A58);

class ProfilePage extends StatefulWidget {
  static const String id = 'profile_page';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenHeight, screenWidth;
  final Duration duration = Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _scaleMenuAnimation;
  Animation<Offset> _slidAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(_controller);
    _scaleMenuAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slidAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            menu(context),
            dashBoard(context),
          ],
        ),
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slidAnimation,
      child: ScaleTransition(
        scale: _scaleMenuAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'History',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Service Providers',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Balance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashBoard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      right: isCollapsed ? 0 : -0.4 * screenWidth,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 4,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 28),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          InkWell(
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            onTap: () {
                              setState(() {
                                if (isCollapsed)
                                  _controller.forward();
                                else
                                  _controller.reverse();
                                isCollapsed = !isCollapsed;
                              });
                            },
                          ),
                          Text(
                            'My Cards',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                          )
                        ],
                      ),
                      SizedBox(height: 40),
                      Container(
                        height: 200,
                        child: PageView(
                          controller: PageController(viewportFraction: 0.8),
                          pageSnapping: true,
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              color: Colors.blueAccent,
                              width: 100,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              color: Colors.redAccent,
                              width: 100,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              color: Colors.greenAccent,
                              width: 100,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Transactions',
                        style: (TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('Comsultancy'),
                              subtitle: Text('Doctor'),
                              trailing: Text('5000'),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 10,
                            );
                          },
                          itemCount: 10),
                    ])),
          ),
        ),
      ),
    );
  }
}
