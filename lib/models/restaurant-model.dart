import 'food-model.dart';

class Restaurant {
  String? name;
  String? desc;
  String? waitTime;
  String? label;
  String? logoUrl;
  num? score;
  Map<String, List<Food>>? menu;

  Restaurant(
      this.name,
      this.waitTime,
      this.label,
      this.logoUrl,
      this.desc,
      this.score,
      this.menu,);
  static Restaurant generateRestaurant() {
    return Restaurant(
        "Restaurant",
        "20-30 min",
        "2.4km",
        "assets/images/res_logo.png",
        "Orange sandwiches",
        4.4,
        {
          "Recommend": Food.generateRecommendedFoods(),
          "Popular": Food.generatePopularFoods(),
          "Noodles": Food.generateNoodlesFoods(),
          "pizza": [],

        });
  }

  }

