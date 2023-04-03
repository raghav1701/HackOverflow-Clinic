class LocalUser{
  /// `uid` of the current user that can be accessed with the FirebaseAuth object
  /// like `FirebaseAuth.instance.currentUser().then((user) => user.uid)`
  ///
  /// or access this with service class with provider like
  /// `Provider.of<FirestoreService>(context).uid`
  String uid;

  /// `email` of the current user that can be accessed with the FirebaseAuth object
  /// like `FirebaseAuth.instance.currentUser().then((user) => user.email)`
  ///
  /// or access this with service class with provider like
  /// `Provider.of<FirestoreService>(context).email`
  String email;

  /// `name` of the current user that can be accessed with the FirebaseAuth object
  /// like `FirebaseAuth.instance.currentUser().then((user) => user.displayName)`
  ///
  /// or access this with service class with provider like
  /// `Provider.of<FirestoreService>(context).name`
  String name;

  /// `dob` of the current user that is stored in firestore database, can be accessed
  /// with service class with provider like `Provider.of<FirestoreService>(context).dob`
  String dob;

  /// `age` of the current user calculated automatically on the basis of the date of birth provided
  /// and can be accessed with service class with provider like
  /// `Provider.of<FirestoreService>(context).age`
  int age;

  /// `gender` of the current user that is stored in firestore database, can be accessed
  /// with service class with provider like `Provider.of<FirestoreService>(context).gender`
  String gender;

  LocalUser({
    this.uid,
    this.email,
    this.name,
    this.dob,
    this.gender,
  });

  /// call this function to set new user after signing in
  void set(LocalUser user) {
    this.uid   = user.uid;
    this.email = user.email;
    this.name  = user.name;
    this.dob   = user.dob;
    this.age   = findAge(user.dob);
    this.gender = user.gender;
  }

  /// upon `signing out` call this function to clear user data from the provider cache
  void clear() {
    this.uid   = null;
    this.email = null;
    this.name  = null;
    this.dob   = null;
    this.age   = null;
    this.gender = null;
  }

  /// This function takes the date of birth of the user and return the age of the user
  static int findAge(String dob) {
    int dd = int.parse(dob.substring(0, dob.indexOf('-')));
    int mm = int.parse(dob.substring(dob.indexOf('-') + 1, dob.lastIndexOf('-')));
    int yy = int.parse(dob.substring(dob.lastIndexOf('-') + 1, dob.length));

    DateTime today = DateTime.now();

    if (today.month < mm || (today.month == mm && today.day < dd))
      return today.year - yy - 1;
    return today.year - yy;
  }
}
