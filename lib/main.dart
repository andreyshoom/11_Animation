import 'package:flutter/material.dart';
import 'package:hero_card/space.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(title: 'Animations'),
    );
  }
}

class HomeView extends StatefulWidget {
  HomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black54,
        title: Text(widget.title),
      ),
      body: ListView(
        children: spaces
            .map(
              (item) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 400),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DetailView(data: item),
                    ),
                  );
                },
                child: Container(
                  height: 180,
                  width: 200,
                  child: Card(
                    color: Colors.white,
                    margin: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    elevation: 8,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Hero(
                                tag: item.id,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(item.image),
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Hero(
                                tag: '${item.id}-text',
                                child: Container(
                                  color: Colors.transparent,
                                  margin: const EdgeInsets.only(top: 25),
                                  width: 320,
                                  child: Material(
                                    color: Colors.white,
                                    child: Text(
                                      item.description,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          bottom: 67,
                          child: Hero(
                            tag: '${item.id}-button',
                            child: Material(
                              child: Container(
                                color: Colors.amber[300],
                                padding: const EdgeInsets.all(6),
                                child: const Icon(Icons.add),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({Key? key, required this.data}) : super(key: key);
  final Space data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Hero(
                    tag: data.id,
                    child: Image.asset(data.image),
                  ),
                  Positioned(
                    bottom: -15,
                    right: 20,
                    child: Hero(
                      tag: '${data.id}-button',
                      child: Material(
                        child: Container(
                          color: Colors.amber[300],
                          padding: const EdgeInsets.all(6),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Hero(
              tag: '${data.id}-text',
              child: Material(
                child: Text(data.description),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
