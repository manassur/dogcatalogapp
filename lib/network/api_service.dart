import 'dart:async';
import 'dart:convert';
import 'package:dogcatalogapp/model/responses/breed_response.dart';
import 'package:flutter/material.dart';
import '../constants/endpoints.dart';
import 'api_client.dart';

class ApiService {
  final ApiClient _apiClient = ApiClient();

  Future<BreedResponse> fetchRandomDogBreeds() async {
    final response = await _apiClient.get(EndPoints.randomBreedImages);
    var data = json.decode(response);
    return BreedResponse.fromJson(data);
  }

  Future<BreedResponse> fetchImagesByBreed(breed) async {
    final response = await _apiClient.get(EndPoints.breedImages(breed));
    var data = json.decode(response);
    return BreedResponse.fromJson(data);
  }

  Future< Map<String, dynamic>> fetchAllBreeds() async {
    final response = await _apiClient.get(EndPoints.getAllBreeds);
    Map<String, dynamic> data = json.decode(response);
    return data;
  }

  Future<BreedResponse> fetchRandomImageByBreedAndSubBreed(breed,subbreed) async {
    final response = await _apiClient.get(EndPoints.randomImageByBreedAndSubBreed(breed, subbreed));
    var data = json.decode(response);
    return BreedResponse.fromJson(data);
  }

  Future<BreedResponse> fetchImagesByBreedAndSubBreed(breed,subbreed) async {
    final response = await _apiClient.get(EndPoints.breedImagesByBreedAndSubBreed(breed, subbreed));
    var data = json.decode(response);
    return BreedResponse.fromJson(data);
  }
}
