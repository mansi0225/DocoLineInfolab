class LaboratoryListData {
  LaboratoryListData({
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

  static List<LaboratoryListData> laboratoryList = <LaboratoryListData>[
    LaboratoryListData(
      imagePath: 'assets/images/laboratory_home.png',
      titleTxt: 'Akshar Pathology Laboratory',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perNight: 180,
    ),
    LaboratoryListData(
      imagePath: 'assets/images/laboratory_home.png',
      titleTxt: 'Micro Pathology Laboratory',
      subTxt: 'Wembley, London',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      perNight: 200,
    ),
    LaboratoryListData(
      imagePath: 'assets/images/laboratory_home.png',
      titleTxt: 'Dr Lal PathLabs Laboratory',
      subTxt: 'Wembley, London',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: 60,
    ),
    LaboratoryListData(
      imagePath: 'assets/images/laboratory_home.png',
      titleTxt: 'Pathocare Laboratory',
      subTxt: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
  ];
}