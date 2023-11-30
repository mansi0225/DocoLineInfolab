class PharmacyListData {
  PharmacyListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = 180,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int perNight;

  static List<PharmacyListData> pharmacyList = <PharmacyListData>[
    PharmacyListData(
      imagePath: 'assets/images/laboratory_home.png',
      titleTxt: 'Akshar Pharmacy',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perNight: 180,
    ),
    PharmacyListData(
      imagePath: 'assets/images/laboratory_home.png',
      titleTxt: 'Micro Pharmacy',
      subTxt: 'Wembley, London',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      perNight: 200,
    ),
    PharmacyListData(
      imagePath: 'assets/images/laboratory_home.png',
      titleTxt: 'Dr Lal Pharmacy',
      subTxt: 'Wembley, London',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: 60,
    ),
    PharmacyListData(
      imagePath: 'assets/images/laboratory_home.png',
      titleTxt: 'Pathocare Pharmacy',
      subTxt: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
  ];
}