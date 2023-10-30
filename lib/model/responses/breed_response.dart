class BreedResponse {
  List<String>? randomBreedList;
  String? status;

  BreedResponse({this.randomBreedList, this.status});

  BreedResponse.fromJson(Map<String, dynamic> json) {
    randomBreedList = json['message'].cast<String>();
    status = json['status'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.randomBreedList;
    data['status'] = this.status;
    return data;
  }
}
