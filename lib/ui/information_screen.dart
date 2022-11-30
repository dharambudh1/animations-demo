import 'dart:math';

import 'package:flutter/material.dart';
import 'package:navigator_new/api/api_response.dart';
import 'package:navigator_new/custom_lib/transparent_image.dart';

class InformationScreen extends StatefulWidget {
  final Results results;
  const InformationScreen({
    Key? key,
    required this.results,
  }) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  late final Results results;
  late String imageURL;

  @override
  void initState() {
    super.initState();
    imageURL = "https://picsum.photos/1280/720?random=${Random().nextInt(100)}";
    results = widget.results;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Hero(
                transitionOnUserGestures: true,
                tag: results.email ?? '',
                child: nameplate(results),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 24,
                    width: 24,
                  ),
                ),
              ],
              centerTitle: true,
              leading: Hero(
                transitionOnUserGestures: false,
                tag: results.login?.uuid ?? '',
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () => Navigator.pop(context),
                    child: const Card(
                      shape: CircleBorder(),
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.arrow_circle_left_outlined,
                          // color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              automaticallyImplyLeading: true,
              expandedHeight: 300.0,
              floating: true,
              snap: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    FadeInImage.memoryNetwork(
                      image: imageURL,
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Hero(
                        transitionOnUserGestures: true,
                        tag: results.picture ?? '',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Card(
                            margin: const EdgeInsets.all(12),
                            clipBehavior: Clip.antiAlias,
                            shape: const CircleBorder(),
                            elevation: 4,
                            child: Card(
                              margin: const EdgeInsets.all(12),
                              clipBehavior: Clip.antiAlias,
                              shape: const CircleBorder(),
                              elevation: 4,
                              child: FadeInImage.memoryNetwork(
                                image: results.picture?.large ?? '',
                                fit: BoxFit.contain,
                                placeholder: kTransparentImage,
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
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Card(
                            margin: const EdgeInsets.only(left: 32),
                            clipBehavior: Clip.hardEdge,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Card(
                                    elevation: 4,
                                    child: Padding(
                                      padding: EdgeInsets.all(14.0),
                                      child: Text('Baisc information'),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  abc('Gender:', results.gender ?? ''),
                                  abc('Email:', results.email ?? ''),
                                  abc('Phone:', results.phone ?? ''),
                                  abc('Nationality:', results.nat ?? ''),
                                  abc('Date of Birth:',
                                      results.dob?.date ?? ''),
                                  abc('Age:',
                                      results.dob?.age.toString() ?? ''),
                                ],
                              ),
                            ),
                          ),
                          const Card(
                            elevation: 4,
                            shape: CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text('🧑', style: TextStyle(fontSize: 28)),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Stack(
                        children: [
                          Card(
                            margin: const EdgeInsets.only(left: 32),
                            clipBehavior: Clip.hardEdge,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Card(
                                    elevation: 4,
                                    child: Padding(
                                      padding: EdgeInsets.all(14.0),
                                      child: Text('Location information'),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  abc(
                                      'Street #:',
                                      results.location?.street?.number
                                              .toString() ??
                                          ''),
                                  abc('Street name:',
                                      results.location?.street?.name ?? ''),
                                  abc('City:', results.location?.city ?? ''),
                                  abc('State:', results.location?.state ?? ''),
                                  abc('Country:',
                                      results.location?.country ?? ''),
                                  abc(
                                      'Post code:',
                                      results.location?.postcode.toString() ??
                                          ''),
                                ],
                              ),
                            ),
                          ),
                          const Card(
                            elevation: 4,
                            shape: CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child:
                                  Text('🛣️', style: TextStyle(fontSize: 28)),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Stack(
                        children: [
                          Card(
                            margin: const EdgeInsets.only(left: 32),
                            clipBehavior: Clip.hardEdge,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Card(
                                    elevation: 4,
                                    child: Padding(
                                      padding: EdgeInsets.all(14.0),
                                      child: Text('Co-ordinal information'),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  abc(
                                      'Latitude:',
                                      results.location?.coordinates?.latitude ??
                                          ''),
                                  abc(
                                      'Longitude:',
                                      results.location?.coordinates
                                              ?.longitude ??
                                          ''),
                                ],
                              ),
                            ),
                          ),
                          const Card(
                            elevation: 4,
                            shape: CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text('📍', style: TextStyle(fontSize: 28)),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Stack(
                        children: [
                          Card(
                            margin: const EdgeInsets.only(left: 32),
                            clipBehavior: Clip.hardEdge,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Card(
                                    elevation: 4,
                                    child: Padding(
                                      padding: EdgeInsets.all(14.0),
                                      child: Text('Timezone information'),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  abc('Offset:',
                                      results.location?.timezone?.offset ?? ''),
                                  abc(
                                      'Description:',
                                      results.location?.timezone?.description ??
                                          ''),
                                ],
                              ),
                            ),
                          ),
                          const Card(
                            elevation: 4,
                            shape: CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child:
                                  Text('🕰️', style: TextStyle(fontSize: 28)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }, childCount: 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget abc(String title, String value) {
    return Row(
      children: [
        const Text(
          '🔘',
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          title,
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
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
