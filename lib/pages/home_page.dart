import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:love_calculator/bloc/home_bloc.dart';
import 'package:love_calculator/utils/helpers/helpers.dart';

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
      floatingActionButton: _searchButton(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _icon(),
                _textTitle(),
                _divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                  child: _textFormField(
                    textEditingController: _fname,
                    hintText: "First name",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: _textFormField(
                    textEditingController: _sname,
                    hintText: "Second name",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _divider() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Divider(),
    );
  }

  Text _textTitle() {
    return Text(
      "Love Calculator",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline4,
    );
  }

  IconTheme _icon() {
    return IconTheme(
      data: Theme.of(context).iconTheme.copyWith(
            size: 70,
            color: Theme.of(context).primaryColorLight,
          ),
      child: Icon(Icons.favorite),
    );
  }

  TextFormField _textFormField(
      {TextEditingController textEditingController, String hintText}) {
    return TextFormField(
      onChanged: (value) => textEditingController.text = value,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Theme.of(context).accentColor),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: IconTheme(
          data: Theme.of(context).iconTheme.copyWith(size: 30),
          child: Icon(Icons.person),
        ),
      ),
    );
  }

  FloatingActionButton _searchButton() {
    return FloatingActionButton(
      child: IconTheme(
        data: Theme.of(context).iconTheme.copyWith(
              color: Theme.of(context).primaryColorLight,
              size: 30,
            ),
        child: Icon(Icons.search),
      ),
      onPressed: () {
        if (Helpers.validateName(_fname.text) &&
            Helpers.validateName(_sname.text)) {
          _bloc.getResults(fname: _fname.text, sname: _sname.text);
        } else {
          _buildAlertDialog(
            title: "Campos inválidos!",
            content: "Preencha todos os campos corretamente.",
          );
        }
      },
    );
  }

  _buildAlertDialog({String title, String content}) {
    if (Platform.isIOS) {
      _buildIOSDialog(
        title: title,
        content: content,
      );
    } else {
      _buildAndroidDialog(
        title: title,
        content: content,
      );
    }
  }

  _buildIOSDialog({String title, String content}) {
    return showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: Text("Ok"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  _buildAndroidDialog({String title, String content}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Ok",
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ],
        );
      },
    );
  }
}
