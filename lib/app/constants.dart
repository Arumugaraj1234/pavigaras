import 'package:pavigaras/domain/model/model.dart';

class AppConstants {
  static const String baseUrl = "http://demo.misoft.ca/service/api/CustomerV1/";
  static const String applicationJson = "application/json";
  static const String contentType = "content-type";
  static const String accept = "accept";
  static const String authorization = "authorization";
  static const String defaultLanguage = "Language";
  static const String authorizationToken = "AUTHORIZATION_TOKEN";
  static const String englishLanguage = "en";
  static const String emptyString = "";
  static const int zeroInt = 0;
  static const double zeroDouble = 0.0;
  static const String prefsKeyUserId = "PREFS_KEY_USER_ID";
  static const String prefsKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";
  static const String prefsKeyUserName = "PREFS_KEY_USER_NAME";
  static const String indianMobileCode = "+91";
  static String indianRupeeSymbol = String.fromCharCodes(Runes('\u20B9'));
  static const String cacheInitKey = "CACHE_INIT_KEY";
  static const String defaultImage =
      "https://clipground.com/images/default-image-icon-png-11.png";
}

class AppDataConstants {
  static List<Village> villages = [];

  static const List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  static List<Quality> qualities = [
    Quality('https://www.finandrib.com/Images/icons/1.png',
        'Delivery Within 2 Hours'),
    Quality(
        'https://www.finandrib.com/Images/icons/2.png', 'Halal Certification'),
    Quality('https://www.finandrib.com/Images/icons/3.png', 'No Preservatives'),
    Quality('https://www.finandrib.com/Images/icons/4.png', 'No Chemicals'),
    Quality('https://www.finandrib.com/Images/icons/5.png', 'Antibiotic free')
  ];

  static List<Product> products = [
    Product(
        1,
        "Sambar",
        15,
        "https://asmallbite.com/wp-content/uploads/2018/03/Arachuvitta-Sambar-Recipe.jpg",
        "",
        2,
        "500ML",
        85,
        78),
    Product(
        2,
        "Aviyal",
        15,
        "https://www.jeyashriskitchen.com/wp-content/uploads/2009/09/IMG_9088.jpg",
        "",
        3,
        "250 GM",
        65,
        56),
    Product(
        3,
        "Peetrut Poriyal",
        15,
        "https://www.vegrecipesofindia.com/wp-content/uploads/2019/03/beetroot-poriyal-1a.jpg",
        "",
        4,
        "250 GM",
        55,
        48)
  ];

  static List<Product> favorites = [
    Product(
        4,
        "Paal Payasam",
        15,
        "https://www.awesomecuisine.com/wp-content/uploads/2015/06/paal_payasam_milk_kheer.jpg",
        "",
        5,
        "500 ML",
        110,
        95),
    Product(
        5,
        "Nattu Kozhi Kulambu",
        30,
        "https://tamil.boldsky.com/img/2015/09/12-1442045666-kongunaaduchickenkuzhambu.jpg",
        "",
        6,
        "500 ML",
        165,
        155),
    Product(
        6,
        "Chicken 65",
        30,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBGO2MAhm9X4U4Ly-aYR7U-xLhCpQN4gPgRfrD1RjlLhfH486Uf1NWYAHCFfF4e93iaBQ&usqp=CAU",
        "",
        7,
        "100 GM",
        40,
        35)
  ];

  static List<Product> todayOffers = [
    Product(
        5,
        "Nattu Kozhi Kulambu",
        30,
        "https://tamil.boldsky.com/img/2015/09/12-1442045666-kongunaaduchickenkuzhambu.jpg",
        "",
        6,
        "500 ML",
        165,
        155),
    Product(
        1,
        "Sambar",
        15,
        "https://asmallbite.com/wp-content/uploads/2018/03/Arachuvitta-Sambar-Recipe.jpg",
        "",
        2,
        "500ML",
        85,
        78),
    Product(
        7,
        "Chicken Biriyani",
        45,
        "https://spicecravings.com/wp-content/uploads/2021/04/Chicken-Biryani-Featured-2-500x500.jpg",
        "",
        8,
        "HALF",
        135,
        110),
  ];
}
