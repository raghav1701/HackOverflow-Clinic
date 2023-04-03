class EarTestModel {
  String name;
  int age;
  String gender;
  int score;

  EarTestModel({
    this.name,
    this.age,
    this.gender,
    this.score = 0,
  });

  void scoreEars({int points = 1}) {
    score += points;
  }
}
