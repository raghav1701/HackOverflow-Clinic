class ResultMessage {
  /// `code` here denotes the custom message codes it may be a error code or a successful message code
  ///
  /// `code == 1` : operation successful
  ///
  /// `code == 2` : platform error such as no internet, or else
  ///
  /// `code == 3` : connection timeout error
  ///
  /// `code == 4` : socket exception
  /// 
  /// `code == 5` : other errors
  String code;

  /// `message` is the description of error or successful operation
  String message;

  ResultMessage({this.code, this.message});
}
