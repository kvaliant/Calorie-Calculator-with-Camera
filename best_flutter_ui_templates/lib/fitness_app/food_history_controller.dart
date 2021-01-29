class FoodHistory {
  Map<String, Food> food;
  FoodHistory({this.food});
  @override
  String toString() {
    return 'FoodHistory{food: $food}';
  }

  factory FoodHistory.fromJson(Map<String, dynamic> json) {
    var mapFood = json["food"] as Map;
    var mapFoodContent = mapFood.map((key, value) {
      return MapEntry<String, Food>(key, Food.fromJson(value));
    });
    return FoodHistory(
      food: mapFoodContent,
    );
  }
}

class Food {
  String id;
  String name;
  //String calorie;
  //String timeStamp;
  Food({this.id, this.name}); // this.calorie, this.timeStamp});
  @override
  String toString() {
    return 'Food{id: $id, name: $name,}'; // calorie: $calorie, timeStamp: $timeStamp}';
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(id: json["foodID"], name: json["foodName"]);
    //calorie: json["calorie"],
    //timeStamp: json["timeStamp"]);
  }
}

class FoodList {
  FoodList({
    this.id = 0,
    this.name = '',
    //this.timeStamp,
    //this.calorie = 0,
  });

  int id;
  String name;
  //DateTime timeStamp;
  //int calorie;

  static List<FoodList> tabIconsList = <FoodList>[
    FoodList(),
  ];
}
