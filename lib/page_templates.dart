import 'package:flutter/material.dart';

class BasicPage extends StatefulWidget {
  final Widget child;
  final Widget bottomPanel;
  final Widget floatingBtn;

  BasicPage({this.child, this.bottomPanel, this.floatingBtn});

  static void switchPage(BuildContext context, StatefulWidget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        key: scaffoldKey,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          controller: ScrollController(
            initialScrollOffset: MediaQuery.of(context).size.height,
            keepScrollOffset: true,
          ),
          reverse: true,
          padding: EdgeInsets.only(bottom: bottom),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffDBB3B1), Color(0xffC89FA3)],
            )),
            child: widget.child,
          ),
        ),
        bottomNavigationBar: widget.bottomPanel,
        floatingActionButton: widget.floatingBtn,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
