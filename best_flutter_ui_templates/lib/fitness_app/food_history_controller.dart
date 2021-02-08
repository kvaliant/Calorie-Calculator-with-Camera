class FoodHistory {
  Map<String, Food> food;
  FoodHistory({this.food});
  @override
  String toString() {
    return 'FoodHistory{food: $food}';
  }

  factory FoodHistory.fromJson(Map<String, dynamic> json) {
    var mapFood = json["predictions"] as Map;
    var mapFoodContent = mapFood.map((key, value) {
      return MapEntry<String, Food>(key, Food.fromJson(value));
    });
    return FoodHistory(
      food: mapFoodContent,
    );
  }
}

class Food {
  String probability;
  String tagId;
  String tagName;
  Food(
      {this.probability,
      this.tagId,
      this.tagName}); // this.calorie, this.timeStamp});
  @override
  String toString() {
    return 'Food{id: $probability, name: $tagName,}'; // calorie: $calorie, timeStamp: $timeStamp}';
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        probability: json["probability"],
        tagId: json["tagId"],
        tagName: json["tagName"]);
  }
}
