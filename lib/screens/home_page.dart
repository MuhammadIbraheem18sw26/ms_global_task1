import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../service/api_service.dart';

import '../models/models.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late List<PostModel>? _postModel = [];
  late List<UserModel>? _userModel = [];
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getData() async {
    _postModel = (await ApiService().getPosts())!;

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    _userModel = (await ApiService().getUsers())!;

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  var userId = Get.arguments;
  TextStyle style = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: <Widget>[Tab(text: " TASK"), Tab(text: " PROFILE")],
            ),
            surfaceTintColor: Colors.red,
            elevation: 3,
            leading: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 25,
            ),
            centerTitle: true,
            backgroundColor: Colors.red,
            title: const Text(
              "API Data",
              style: TextStyle(fontSize: 23, color: Colors.white),
            ),
            actions: const <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.search),
              ),
            ],
            actionsIconTheme: const IconThemeData(
                size: 25.0, color: Colors.white, opacity: 10.0),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: TabBarView(
            children: [
              (_postModel == null || _postModel!.isEmpty)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: _postModel!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: (userId == _postModel![index].userId)
                                ? Text(_postModel![index].title,
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold))
                                : Text(_postModel![index].title),
                            subtitle: Text(_postModel![index].body),
                          ),
                        );
                      },
                    ),
              Container(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Name:",
                          style: style,
                        ),
                        Text(_userModel![userId - 1].name)
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Username:",
                          style: style,
                        ),
                        Text(_userModel![userId - 1].username)
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Email:", style: style),
                        Text(_userModel![userId - 1].email)
                      ],
                    ),
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
