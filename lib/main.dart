import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isOpened = false;
  bool _isSearching = false;
  final TextEditingController _controller = TextEditingController();

  final List<String> _searchItems = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Elderberry",
    "Fig",
    "Grape",
  ];

  List<String> _search(String value) {
    List<String> searchList = [];
    for (int i = 0; i < _searchItems.length; i++) {
      String name = _searchItems[i];
      if (name.toLowerCase().contains(value.toLowerCase())) {
        searchList.add(name);
      }
    }
    return searchList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          height: _isOpened ? 280 : 55,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyan.shade900,
                Colors.deepPurple.shade900,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0, top: 3.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isOpened = !_isOpened;
                      });
                    },
                    child: TextFormField(
                      controller: _controller,
                      enabled: _isOpened ? true : false,
                      style: const TextStyle(
                        color: Colors.white54,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _isOpened = true;
                          });
                        } else {
                          setState(() {
                            _isOpened = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 10.0),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        prefixIcon: AnimatedOpacity(
                          duration: const Duration(milliseconds: 700),
                          opacity: _isOpened ? 0 : 1,
                          child: const Icon(
                            Icons.search,
                            color: Colors.white54,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: _isSearching
                              ? AnimatedOpacity(
                                  duration: const Duration(milliseconds: 700),
                                  opacity: _isOpened ? 0 : 1,
                                  child: Transform.scale(
                                    scale: 0.4,
                                    child: const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white54),
                                    ),
                                  ))
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (_controller.text.isNotEmpty)
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _controller.clear();
                                            _isOpened = !_isOpened;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          size: 20,
                                          color: Colors.white54,
                                        ),
                                      ),
                                    const SizedBox(width: 10.0),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                        color: Colors.white24,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.filter_list,
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {
                          _isSearching = true;
                          _isOpened = false;
                        });
                      },
                    ),
                  ),
                ),
                if (_isOpened)
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _search(_controller.text).length,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: AnimatedOpacity(
                                duration: const Duration(milliseconds: 700),
                                opacity: _controller.text ==
                                        _search(_controller.text)[index]
                                    ? 1
                                    : 0.5,
                                child: Text(
                                  _controller.text ==
                                          _search(_controller.text)[index]
                                      ? _search(_controller.text)[index]
                                      : _search(_controller.text)[index],
                                  style: TextStyle(
                                    color: _controller.text ==
                                            _search(_controller.text)[index]
                                        ? Colors.white
                                        : Colors.white54,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              leading: AnimatedOpacity(
                                duration: const Duration(milliseconds: 700),
                                opacity: _controller.text ==
                                        _search(_controller.text)[index]
                                    ? 1
                                    : 0.5,
                                child: Icon(
                                  Icons.search,
                                  color: _controller.text ==
                                          _search(_controller.text)[index]
                                      ? Colors.white
                                      : Colors.white54,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
