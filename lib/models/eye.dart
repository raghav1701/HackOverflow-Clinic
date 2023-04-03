class EyeTestModel {
  String name;
  int age;
  String gender;
  int visionAcuity;
  int contrast;
  int colorBlindness;
  int astigmatism;
  int ears;

  EyeTestModel({
    this.name,
    this.age,
    this.gender,
    this.visionAcuity = 0,
    this.contrast = 0,
    this.colorBlindness = 0,
    this.astigmatism = 0,
    this.ears = 0,
  });

  void scoreVisionAcuity(int x) {
    visionAcuity += x;
  }

  void scoreContrast(int x) {
    contrast += x;
  }

  void scoreColorBlindness(int x) {
    colorBlindness += x;
  }

  void scoreAstigmatism(int x) {
    astigmatism += x;
  }
}

class EyeTestResults {
  String visionAcuity;
  String contrast;
  String colorBlindness;
  String astigmatism;
}
