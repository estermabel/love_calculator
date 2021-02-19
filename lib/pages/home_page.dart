import 'package:flutter/material.dart';
import 'package:love_calculator/bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _bloc = HomeBloc();

  TextEditingController _fname = TextEditingController();
  TextEditingController _sname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        child: IconTheme(
          data: Theme.of(context).iconTheme.copyWith(
                color: Theme.of(context).primaryColorLight,
                size: 30,
              ),
          child: Icon(Icons.search),
        ),
        onPressed: () {
          _bloc.getResults(fname: _fname.text, sname: _sname.text);
        },
      ),
      body: SingleChildScrollView(),
    );
  }
}
