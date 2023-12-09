import 'package:flutter/material.dart';
import 'package:responsi_c_124210052/api/api_service.dart';
import 'package:responsi_c_124210052/detail_page.dart';

class MealsPage extends StatefulWidget {
  final category;

  const MealsPage({super.key, required this.category});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  Future<Map<String, dynamic>>? _data;

  @override
  void initState() {
    super.initState();
    _data = APIService.instance.loadMeals(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          widget.category,
          style: const TextStyle(color: Colors.yellowAccent),
        ),
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!['meals'];
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailPage(
                              id: data[index]['idMeal'],
                            ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellowAccent),
                    child: Column(
                      children: [
                        Image.network(data[index]['strMealThumb'], width: 150,
                            height: 150),
                        SizedBox(height: 10),
                        Text(
                          data[index]['strMeal'],
                          style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold,),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
