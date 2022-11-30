import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:navigator_new/api/api_response.dart';
import 'package:navigator_new/bloc/home_bloc.dart';
import 'package:navigator_new/custom_lib/multi_stream_builder.dart';
import 'package:navigator_new/custom_lib/transparent_image.dart';
import 'package:navigator_new/ui/information_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MyBloc _myBloc = MyBloc();
  late Future<APIResponse>? future;

  @override
  void initState() {
    super.initState();
    timeDilation = 3.0;
    future = _myBloc.apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<APIResponse>(
          future: future,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container();
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return Container();
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text('Snapshot Error: ${snapshot.error.toString()}');
                } else if (snapshot.hasData) {
                  return list(snapshot.data);
                } else {
                  return Text('Unknown Error: ${snapshot.error.toString()}');
                }
            }
          },
        ),
      ),
    );
  }

  Widget list(Object? object) {
    return object != null
        ? MultiStreamBuilder(
            streams: [_myBloc.listBS.stream],
            builder: (context) {
              return (_myBloc.listBS.hasValue)
                  ? RefreshIndicator(
                      onRefresh: () async {
                        future = _myBloc.apiCall();
                        return Future.value();
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(18),
                        itemCount: _myBloc.listBS.value.results?.length ?? 0,
                        itemBuilder: (context, index) {
                          Results results =
                              _myBloc.listBS.value.results?[index] ?? Results();
                          return Card(
                            clipBehavior: Clip.hardEdge,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return InformationScreen(
                                        results: results,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Hero(
                                      transitionOnUserGestures: true,
                                      tag: results.picture ?? '',
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: Card(
                                          clipBehavior: Clip.antiAlias,
                                          shape: const CircleBorder(),
                                          elevation: 4,
                                          child: Card(
                                            margin: const EdgeInsets.all(6),
                                            clipBehavior: Clip.antiAlias,
                                            shape: const CircleBorder(),
                                            elevation: 4,
                                            child: FadeInImage.memoryNetwork(
                                              image: results.picture?.thumbnail ?? '',
                                              fit: BoxFit.contain,
                                              placeholder: kTransparentImage,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Hero(
                                        transitionOnUserGestures: true,
                                        tag: results.email ?? '',
                                        child: nameplate(results),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Hero(
                                      transitionOnUserGestures: true,
                                      tag: results.login?.uuid ?? '',
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return InformationScreen(
                                                    results: results,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: const Card(
                                            shape: CircleBorder(),
                                            elevation: 4,
                                            child: Padding(
                                              padding: EdgeInsets.all(12.0),
                                              child: Icon(
                                                Icons.arrow_circle_right_outlined,
                                                // color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container();
            },
          )
        : Container();
  }

  Widget nameplate(Results results) {
    return Container(
      alignment: Alignment.center,
      child: Material(
        type: MaterialType.transparency,
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(text: '${results.name?.title ?? ''}. '),
                        TextSpan(
                          text: results.name?.first ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: results.name?.last ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
