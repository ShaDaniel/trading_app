import 'package:flutter/material.dart';
import 'common_elements/colors.dart' as colors;

// Получается, все или почти все виджеты Stateful?
// Это очень плохо, их нужно использовать только там, где действительно
// необходим какой-то нестатичный блок.

class BasicPage extends StatefulWidget {
  final Widget child;
  final Widget bottomPanel;
  final Widget floatingBtn;
  final Widget appBar;

  BasicPage({this.child, this.bottomPanel, this.floatingBtn, this.appBar});

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
        extendBodyBehindAppBar: true,
        appBar: widget.appBar,
        key: scaffoldKey,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
              colors: [colors.appBckgr1, colors.appBckgr2],
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
