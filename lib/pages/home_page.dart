import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:love_calculator/bloc/home_bloc.dart';
import 'package:love_calculator/components/native_loading.dart';
import 'package:love_calculator/utils/helpers/helpers.dart';
import 'package:love_calculator/utils/helpers/manage_dialogs.dart';

import '../model/Results.dart';
import '../service/config/base_response.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _bloc = HomeBloc();
  bool _isResultsVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void _clear() {
    _bloc.fname.clear();
    _bloc.sname.clear();
    setState(() {
      _isResultsVisible = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.fname?.dispose();
    _bloc.fname = null;
    _bloc.sname?.dispose();
    _bloc.sname = null;
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: IconTheme(
              data: Theme.of(context).iconTheme.copyWith(
                    size: 30,
                  ),
              child: Icon(Icons.refresh),
            ),
            onPressed: _clear,
          )
        ],
      ),
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
                    textEditingController: _bloc.fname,
                    hintText: "First name",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: _textFormField(
                    textEditingController: _bloc.sname,
                    hintText: "Second name",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: StreamBuilder<BaseResponse<Results>>(
                    initialData: BaseResponse.completed(),
                    stream: _bloc.calculatorStream,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
                            return _onLoading();
                            break;
                          case Status.ERROR:
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ManagerDialogs.showErrorDialog(
                                context,
                                snapshot.data.message,
                              );
                            });
                            return Container();
                            break;
                          default:
                            return _results(snapshot);
                        }
                      } else {
                        return _onLoading();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Visibility _results(AsyncSnapshot<BaseResponse<Results>> snapshot) {
    return Visibility(
      visible: _isResultsVisible,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              snapshot.data.data != null
                  ? "${snapshot.data.data.percentage}%"
                  : "",
              style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              snapshot.data.data != null ? snapshot.data.data.result : "",
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Padding _onLoading() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: NativeLoading(animating: true),
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
      controller: textEditingController,
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
        if (Helpers.validateName(_bloc.fname.text) &&
            Helpers.validateName(_bloc.sname.text)) {
          _bloc.getResults(fname: _bloc.fname.text, sname: _bloc.sname.text);
          setState(() {
            _isResultsVisible = true;
          });
        } else {
          _buildAlertDialog(
            title: "Invalid fields!",
            content: "Complete all the fields correctly.",
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
