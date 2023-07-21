class ErrorMessages {
  static const String unauthError = "Unauthorized; Please Restart Your App";
  static const String defaultError =
      "An error occured, please check your network connetion or try again after some time, if the problem persists please contact a DVM Official";
  static const String unknownError =
      'Unknown error occured. Please contact a DVM Official';
  static const String invalidLogin = 'Your details could not be verified';
  static const String timeOutError =
      'Server taking too long to respond. Please try again later';
  static const String showDoesNotExist =
      "The show you're looking for does not exist.";
  static const String itemDoesNotExist =
      "The item you're looking for does not exist.";
  static const String venderClosedOrders =
      "The item you're looking for is currently unavailable.";
  static const String somethingWentWrong =
      'Something went wrong. Please contact a DVM official.';
  static const String insufficientFunds =
      'Insufficient funds. Please add money to your wallet.';
  static const String invalidUser =
      'Your details are invalid. Please try again';
  static const String disabledUser =
      'You are currently disabled. Please contact a DVM official';
  static const String emptyProfile =
      'User profile does not exist for this JWT. The user exists but does not have a profile';
  static const String noInternet =
      'Please check your connectivity and try again';
  static const String googleLoginFailed =
      'Google sign in failed. Please contact a DVM Official';
  static const String emptyUsernamePassword =
      'Please enter your username and password'; //backend response : Missing key in request: 'username
}

// to use write ErrorMessages.unknownError
