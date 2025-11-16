import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:test/main.dart';
import 'package:test/mod/coustm_textfiled.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const String routs = 'home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var box = Hive.box('tasks');

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 205, 241, 235).withRed(240),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final reuslt = await Navigator.pushNamed(context, 'make_task');
          if (reuslt == true) {
            setState(() {});
          }
        },
        child: const Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0)),
        backgroundColor: const Color.fromARGB(255, 153, 224, 215),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              box.clear();
            });
          },
          icon: Icon(Icons.delete, color: Colors.black),
        ),
        shadowColor: Colors.black,
        elevation: 6,
        backgroundColor: const Color.fromARGB(255, 153, 224, 215),
        centerTitle: true,
        title: const Text(
          'task app',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Color.fromARGB(255, 10, 10, 10),
          ),
        ),
      ),
      body: box.isEmpty
          ? const Center(
              child: Text(
                'No Tasks Available',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final task = box.getAt(index) as Map;
                String shortContent(String text) {
                  if (text.length > 20) {
                    return text.substring(0, 6) + '...';
                  }
                  return text;
                }

                return Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  padding: EdgeInsets.only(left: 20, top: 10),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(172, 17, 17, 17),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(5),
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 7,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        task['title'],
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        shortContent(task['content']),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 10),

                      Row(
                        children: [
                          Text(
                            task['createdAt'],
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 247, 244, 244),
                            ),
                          ),
                          SizedBox(width: 70),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                box.deleteAt(index);
                              });
                            },
                            icon: Icon(
                              weight: 1,
                              Icons.delete,
                              color: const Color.fromARGB(255, 189, 66, 57),
                            ),
                          ),
                          SizedBox(width: 0),
                          IconButton(
                            onPressed: () async {
                              final titleCtrl = TextEditingController(
                                text: task['title'],
                              );
                              final contentCtrl = TextEditingController(
                                text: task['content'],
                              );
                              final result = await showDialog<Map<String, String>?>(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      205,
                                      241,
                                      235,
                                    ).withRed(240),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'Title',
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            CoustmTextfiled(
                                              controller: titleCtrl,
                                              color: Colors.red,
                                              hint: 'edit title',
                                              maxLines: 1,
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Content',
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            CoustmTextfiled(
                                              controller: contentCtrl,
                                              color: Colors.red,
                                              hint: 'edit content',
                                              maxLines: 5,
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              children: [
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                          255,
                                                          33,
                                                          45,
                                                          207,
                                                        ),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 50,
                                                          vertical: 15,
                                                        ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop({
                                                      'title': titleCtrl.text,
                                                      'content':
                                                          contentCtrl.text,
                                                    });
                                                  },
                                                  child: const Text(
                                                    'Save',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 70),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(
                                                      context,
                                                    ).pop(null); // cancel
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );

                              if (result != null) {
                                box.putAt(index, {
                                  'title': result['title'] ?? '',
                                  'content': result['content'] ?? '',
                                  'createdAt': DateTime.now().toString(),
                                });
                                setState(() {});
                              }
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Color.fromARGB(255, 255, 253, 255),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
