class Restrictions {
  Restrictions({
    this.halal = false,
    this.vegan = false,
    this.hinduism = false,
    this.prawn = false,
    this.clam = false,
    this.seafood = false,
    this.nut = false,
    this.gluten = false,
    this.lactose = false,
  });
  bool halal;
  bool vegan;
  bool hinduism;
  bool prawn;
  bool clam;
  bool seafood;
  bool nut;
  bool gluten;
  bool lactose;
}

class FoodsListData {
  FoodsListData({
    this.foodID = 0,
    this.foodName = '',
    this.calorie = 0,
    this.servingSize = '',
    this.restrictions,
  });

  int foodID;
  String foodName;
  int calorie;
  String servingSize; //e.g. '1 bowl'
  Restrictions restrictions;

  static List<FoodsListData> foodDatabase = <FoodsListData>[
    FoodsListData(
      foodID: 1,
      foodName: 'Chicken Bolognise',
      calorie: 300,
      servingSize: '1 Plate',
      restrictions: Restrictions(vegan: true, lactose: true),
    ),
  ];
}
