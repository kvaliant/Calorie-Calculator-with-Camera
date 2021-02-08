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
      restrictions: Restrictions(vegan: true, lactose: true, hinduism: true),
    ),
    FoodsListData(
      foodID: 2,
      foodName: 'Meatball',
      calorie: 57,
      servingSize: '1 Ball',
      restrictions: Restrictions(vegan: true, hinduism: true),
    ),
    FoodsListData(
      foodID: 3,
      foodName: 'Fried Chicken',
      calorie: 217,
      servingSize: '1 Chicken Breast',
      restrictions: Restrictions(vegan: true, gluten: true),
    ),
    FoodsListData(
      foodID: 4,
      foodName: 'Kebab',
      calorie: 620,
      servingSize: '1 Kebab',
      restrictions: Restrictions(vegan: true, hinduism: true),
    ),
    FoodsListData(
      foodID: 5,
      foodName: 'Egg',
      calorie: 72,
      servingSize: '1 Egg',
      restrictions: Restrictions(vegan: true, hinduism: true),
    ),
    FoodsListData(
      foodID: 6,
      foodName: 'Fried Rice',
      calorie: 217,
      servingSize: '1 Plate',
      restrictions: Restrictions(vegan: true),
    ),
    FoodsListData(
      foodID: 7,
      foodName: 'Bread',
      calorie: 25,
      servingSize: '1 Slice',
      restrictions: Restrictions(gluten: true),
    ),
    FoodsListData(
      foodID: 8,
      foodName: 'Steak',
      calorie: 271,
      servingSize: '100 grams/ 3.5 oz',
      restrictions: Restrictions(vegan: true, hinduism: true),
    ),
    FoodsListData(
      foodID: 9,
      foodName: 'Chicken Nugget',
      calorie: 170,
      servingSize: '1 Piece',
      restrictions: Restrictions(vegan: true, gluten: true),
    ),
    FoodsListData(
      foodID: 10,
      foodName: 'Spaghetti',
      calorie: 274,
      servingSize: '1 Plate',
      restrictions: Restrictions(vegan: true, hinduism: true),
    ),
    FoodsListData(
      foodID: 11,
      foodName: 'Ice Cream',
      calorie: 140,
      servingSize: '1 Bowl',
      restrictions: Restrictions(vegan: true, lactose: true),
    ),
    FoodsListData(
      foodID: 12,
      foodName: 'Pizza',
      calorie: 300,
      servingSize: '1 Slice',
      restrictions: Restrictions(vegan: true, gluten: true, hinduism: true),
    ),
    FoodsListData(
      foodID: 13,
      foodName: 'Pickled Cabbage',
      calorie: 300,
      servingSize: '100 grams/ 3.5 oz',
      restrictions: Restrictions(),
    ),
    FoodsListData(
      foodID: 14,
      foodName: 'Fried Fish',
      calorie: 199,
      servingSize: '1 Fish',
      restrictions: Restrictions(seafood: true, vegan: true),
    ),
    FoodsListData(
      foodID: 15,
      foodName: 'Fried Noodles',
      calorie: 460,
      servingSize: '1 Cup',
      restrictions: Restrictions(gluten: true),
    ),
    FoodsListData(
      foodID: 16,
      foodName: 'Cake',
      calorie: 424,
      servingSize: '1 Slice',
      restrictions: Restrictions(gluten: true),
    ),
    FoodsListData(
      foodID: 17,
      foodName: 'Hamburger',
      calorie: 351,
      servingSize: '1 Burger',
      restrictions: Restrictions(vegan: true, gluten: true, hinduism: true),
    ),
    FoodsListData(
      foodID: 18,
      foodName: 'Soda',
      calorie: 0,
      servingSize: 'Zero Cal',
      restrictions: Restrictions(),
    ),
    FoodsListData(
      foodID: 19,
      foodName: 'Hotdog',
      calorie: 300,
      servingSize: '1 Hotdog',
      restrictions: Restrictions(vegan: true, gluten: true),
    ),
    FoodsListData(
      foodID: 20,
      foodName: 'Cheese',
      calorie: 402,
      servingSize: '100 grams',
      restrictions: Restrictions(vegan: true, lactose: true, gluten: true),
    ),
    FoodsListData(
      foodID: 21,
      foodName: 'French Fries',
      calorie: 312,
      servingSize: '100 grams/ 3.5 oz',
      restrictions: Restrictions(gluten: true),
    ),
    FoodsListData(
      foodID: 22,
      foodName: 'Wine',
      calorie: 625,
      servingSize: '750 ml/ 25 oz',
      restrictions: Restrictions(halal: true, vegan: true, hinduism: true),
    ),
    FoodsListData(
      foodID: 23,
      foodName: 'salad',
      calorie: 108,
      servingSize: '1 Bowl',
      restrictions: Restrictions(),
    ),
  ];
}
