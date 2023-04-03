class SugarTestModel {
  String name;
  String gender;
  int age;
  int pregnancies;
  double glucose;
  double bloodPressure;
  double insulin;
  double height;
  double weight;
  List<bool> parents;

  SugarTestModel({
    this.name,
    this.age,
    this.gender,
    this.pregnancies,
    this.glucose,
    this.bloodPressure,
    this.insulin,
    this.height,
    this.weight,
  }) {
    parents = [false, false, false, false, false, false];
  }

  void setParents(List<dynamic> ob) {
    for (int i = 0; i < 6; ++i) {
      parents[i] = ob[i];
    }
  }
}
