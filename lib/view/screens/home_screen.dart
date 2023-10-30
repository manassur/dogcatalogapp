import 'package:dogcatalogapp/controllers/breed_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dogcatalogapp/view/widgets/dog_breed_item.dart';

import 'breed_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Dog Breeds'),
      ),
      body: const DogList(),
    );
  }
}

class DogList extends StatefulWidget {
  const DogList({super.key});

  @override
  _DogListState createState() => _DogListState();
}

class _DogListState extends State<DogList> {
  @override
  void initState() {
    super.initState();
    Provider.of<BreedController>(context, listen: false).getRandomBreeds();
    Provider.of<BreedController>(context, listen: false).getAllBreeds();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BreedController>(
      builder: (context, data, child) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Explore Breeds'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.breeds.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, BreedListScreen.route,arguments: data.breeds[index]);

                    },
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(
                          data.breeds[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
