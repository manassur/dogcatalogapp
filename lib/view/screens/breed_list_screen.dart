import 'package:dogcatalogapp/controllers/breed_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dogcatalogapp/view/widgets/dog_breed_item.dart';

class BreedListScreen  extends StatefulWidget {
  const BreedListScreen({super.key,required this.breed});
 final String breed;

  static String route='/breed_list';

  @override
  State<BreedListScreen> createState() => _BreedListScreenState();
}

class _BreedListScreenState extends State<BreedListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BreedController>(context, listen: false).getImagesByBreeds(widget.breed);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.breed),
      ),
      body:   Consumer<BreedController>(
        builder: (context, data, child) =>
        data.isLoading!?
        const Center(child: CircularProgressIndicator()):
        data.error!?const Center(child: Text('An error occurred')):
        ListView.builder(
          itemCount: data.imageByBreedList.length,
          itemBuilder: (BuildContext context, int index) =>
              DogBreedItem(dog: data.imageByBreedList[index]),
        ),
      ),
    );
  }
}

