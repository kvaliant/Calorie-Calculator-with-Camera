class RestrictionsListData {
  RestrictionsListData({
    this.restrictionsName = '',
    this.active = false,
    this.isAlergies = false,
  });

  String restrictionsName;
  bool active;
  bool isAlergies;

  static List<RestrictionsListData> restrictionsList = <RestrictionsListData>[
    RestrictionsListData(
      restrictionsName: 'Halal Only',
      active: false,
      isAlergies: false,
    ),
    RestrictionsListData(
      restrictionsName: 'Vegan Only',
      active: false,
      isAlergies: false,
    ),
    RestrictionsListData(
      restrictionsName: 'Hinduism Only',
      active: false,
      isAlergies: false,
    ),
    RestrictionsListData(
      restrictionsName: 'No Prawn',
      active: false,
      isAlergies: true,
    ),
    RestrictionsListData(
      restrictionsName: 'No Clam',
      active: false,
      isAlergies: true,
    ),
    RestrictionsListData(
      restrictionsName: 'No Seafood',
      active: false,
      isAlergies: true,
    ),
    RestrictionsListData(
      restrictionsName: 'No Nut',
      active: false,
      isAlergies: true,
    ),
    RestrictionsListData(
      restrictionsName: 'No Gluten',
      active: false,
      isAlergies: true,
    ),
    RestrictionsListData(
      restrictionsName: 'No Lactose',
      active: false,
      isAlergies: true,
    ),
  ];
}
