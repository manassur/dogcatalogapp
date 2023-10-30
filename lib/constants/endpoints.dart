class EndPoints{
  static const String baseUrl = 'https://dog.ceo/api';
  static String getAllBreeds ="$baseUrl/breeds/list/all";
  static String randomBreedImages='$baseUrl/breeds/image/random/10';
  static String breedImages(breed){
    return '$baseUrl/breed/$breed/images';
  }
  static String randomImageByBreedAndSubBreed(breed,subbreed){
    return '$baseUrl/breed/$breed/$subbreed/images';
  }
  static String breedImagesByBreedAndSubBreed(breed,subreed){
    return '$baseUrl/breed/$breed/$subreed/images';
  }
  static String getRandomImageByBreed(breedName){
    return '$baseUrl/breeds/image/random?breed=$breedName';
  }



}