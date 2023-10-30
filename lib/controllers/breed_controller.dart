
import 'package:dogcatalogapp/network/api_service.dart';
import 'package:flutter/material.dart';

class BreedController with ChangeNotifier {

  final _apiService = ApiService();

  bool? _error;

  List<String> _breeds=[];
  List<String> get breeds => _breeds;
  set breeds(List<String> value) {
    _breeds = value;
  }

  List<String> _breedImages=[];
  List<String> get breedImages => _breedImages;
  set breedImages(List<String> value) {
    breedImages = value;
  }


  bool? get error => _error;
  set error(bool? value) {
    _error = value;
    notifyListeners();
  }

  bool? _isLoading;
  bool? get isLoading => _isLoading;
  set isLoading(bool? value) {
    _isLoading = value;
    notifyListeners();
  }

  List<String> _randomImageByBreedList=[];
  List<String> get randomImageByBreedList => _randomImageByBreedList;
  set randomImageByBreedList(List<String> value) {
    _randomImageByBreedList = value;
    notifyListeners();
  }

  List<String> _imageByBreedList=[];
  List<String> get imageByBreedList => _imageByBreedList;
  set imageByBreedList(List<String> value) {
    _imageByBreedList = value;
    notifyListeners();
  }

  Future<void> getRandomBreeds() async {
   _error=false;
    try {
      _isLoading = true;
      final result = await _apiService.fetchRandomDogBreeds();
      randomImageByBreedList=result!.randomBreedList!;
    } catch (e) {
      _error=true;
    }
   _isLoading = false;
  }

  Future<void> getImagesByBreeds(breed) async {
    _error=false;
    try {
      _isLoading = true;
      final result = await _apiService.fetchImagesByBreed(breed);
      imageByBreedList=result!.randomBreedList!;
    } catch (e) {
      _error=true;
    }
    _isLoading = false;
  }

  Future<void> getAllBreeds() async {
    _error=false;
    try {
      _isLoading = true;
      final result = await _apiService.fetchAllBreeds();
      Map<String, List<dynamic>> message = Map<String, List<dynamic>>.from(result['message']);
      // Get all breed names
      breeds = message.keys.toList();
    } catch (e) {
      _error=true;
      debugPrint(e.toString());
    }
    _isLoading = false;
  }

  void getRandomImageForBreed(breedName) async{
    for (String breed in breeds) {
      try {
        String randomImageUrl = await _apiService.getRandomImageByBreed(breed);
        _breedImages.add(randomImageUrl);
      } catch (e) {
        debugPrint('Error for breed $breed: $e');
      }
    }
  }
}
