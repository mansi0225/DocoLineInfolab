class ServiceListData {
  ServiceListData({
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

  static List<ServiceListData> pharmacyList = <ServiceListData>[
    ServiceListData(
      imagePath: 'assets/images/cardiologist.png',
      titleTxt: 'Cardiologists',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perNight: 180,
    ),
    ServiceListData(
      imagePath: 'assets/images/dental.png',
      titleTxt: 'Dentist',
      subTxt: 'Wembley, London',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      perNight: 200,
    ),
    ServiceListData(
      imagePath: 'assets/images/orthopedic.png',
      titleTxt: 'Orthopedic',
      subTxt: 'Wembley, London',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: 60,
    ),
    ServiceListData(
      imagePath: 'assets/images/gynecology.png',
      titleTxt: 'Gynecologists',
      subTxt: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
    ServiceListData(
      imagePath: 'assets/images/oncologist.png',
      titleTxt: 'Oncologists',
      subTxt: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
    ServiceListData(
      imagePath: 'assets/images/neurologist.png',
      titleTxt: 'Neurologists',
      subTxt: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
    ServiceListData(
      imagePath: 'assets/images/radiologist.png',
      titleTxt: 'Radiologist',
      subTxt: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
    ServiceListData(
      imagePath: 'assets/images/oncology.png',
      titleTxt: 'Psychiatrists',
      subTxt: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
  ];
}