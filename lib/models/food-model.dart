class Food {
  String? name;
  String? desc;
  String? waitTime;
  bool? highlight;
  String? imgUrl;
  num? score;
  num? price;
  String? cal;
  num? quantity;
  List<Map<String, String>>? ingredient;
  String? about;

  Food(
      this.imgUrl,
      this.desc,
      this.name,
      this.waitTime,
      this.score,
      this.cal,
      this.price,
      this.quantity,
      this.ingredient,
      this.about
      ,{this.highlight=false});

  static List<Food> generateRecommendedFoods(){
    return [
      Food(
         "assets/images/dish1.png",
          "desc",
          "Fish",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},
          ],
          "about",
      highlight: true),
      Food(
          "assets/images/dish2.png",
          "description",
          "meat",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
          highlight: true),
      Food(
          "assets/images/dish3.png",
          "desc",
          "Soba Soup",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
          highlight: true),
      Food(
          "assets/images/dish4.png",
          "desc",
          "Soba Soup",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
          highlight: true),
    ];
  }
  static List<Food> generatePopularFoods(){
    return [
      Food(
         "assets/images/dish2.png",
          "desc",
          "Soba Soup",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
      highlight: true),
      Food(
          "assets/images/dish1.png",
          "desc",
          "Soba Soup",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
          highlight: true),
      Food(
          "assets/images/dish2.png",
          "desc",
          "Soba Soup",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
          highlight: true),
      Food(
          "assets/images/dish3.png",
          "desc",
          "Soba Soup",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
          highlight: true),
      Food(
          "assets/images/dish1.png",
          "desc",
          "Soba Soup",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
          highlight: true),
      Food(
          "assets/images/dish1.png",
          "desc",
          "Soba Soup",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
          highlight: true),
    ];
  }
  static List<Food> generateNoodlesFoods(){
    return [
      Food(
         "assets/images/dish1.png",
          "desc",
          "Soba Soup",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
      highlight: true),
      Food(
          "assets/images/dish1.png",
          "desc",
          "Soba Soup",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
          highlight: true),
      Food(
          "assets/images/dish1.png",
          "desc",
          "Soba Soup",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
          highlight: true),
      Food(
          "assets/images/dish1.png",
          "desc",
          "Soba Soup",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
          highlight: true),
      Food(
          "assets/images/dish1.png",
          "desc",
          "Soba Soup",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
          highlight: true),
      Food(
          "assets/images/dish1.png",
          "desc",
          "Soba Soup",
          "50 min",
          4.8,
          "325 kcal",
          15,
          3,
          [
            {"Noodle":"assets/images/ingre1.png"},
            {"Sharimp":"assets/images/ingre2.png"},
            {"Egg":"assets/images/ingre3.png"},
            {"Scallion":"assets/images/ingre4.png"},

          ],
          "about",
          highlight: true),
    ];
  }
}