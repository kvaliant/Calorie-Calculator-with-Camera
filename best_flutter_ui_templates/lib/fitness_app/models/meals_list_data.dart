class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.timeStamp,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  DateTime timeStamp;
  int kacl;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/breakfast.png',
      titleTxt: 'Rice',
      kacl: 525,
      timeStamp: DateTime.parse("2021-05-15 08:18:04Z"),
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: 'Fried Chicken',
      kacl: 602,
      timeStamp: DateTime.parse("2021-05-15 08:18:04Z"),
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/snack.png',
      titleTxt: 'Spaghetti',
      kacl: 525,
      timeStamp: DateTime.parse("2021-05-15 08:18:04Z"),
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: 'Hamburger',
      kacl: 500,
      timeStamp: DateTime.parse("2021-05-15 08:18:04Z"),
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
