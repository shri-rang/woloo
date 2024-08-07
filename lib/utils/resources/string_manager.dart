class AppStrings {
  static const strNoRouteFound = "no_route_found";
  static const strAppName = "app_name";

  static const String success = "success";
  // error handler
  static const String strBadRequestError = "bad_request_error";
  static const String strNoContent = "no_content";
  static const String strForbiddenError = "forbidden_error";
  static const String strUnauthorizedError = "unauthorized_error";
  static const String strNotFoundError = "not_found_error";
  static const String strConflictError = "conflict_error";
  static const String strInternalServerError = "internal_server_error";
  static const String strUnknownError = "unknown_error";
  static const String strTimeoutError = "timeout_error";
  static const String strDefaultError = "default_error";
  static const String strCacheError = "cache_error";
  static const String strNoInternetError = "no_internet_error";

  // Authentication
  static const String welcomeBack = "Welcome Back!";
  static const String beginJoureny =
      "To begin this journey, please enter your login details";
  static const String emailMobileNo = "Email Id";
  static const String enter = "Enter";
  static const String password = "Password";
  static const String enterPassword = "Enter Password";
  static const String login = "Login";
  static const String captcha = "Captcha";
  static const String pressHeighestNo = "Press the highest number";
  static const String forgotPassword = "Forgot Password ?";
  static const String selectHigher = "Please select higher number from Captcha";
  static const String forgotPass = "Forgot Password ";
  static const String verificationCodeonAddress =
      "We will send a verification code to your mail address";
  static const String continuee = "Continue";
  static const String verification = "Verification";
  static const String verificationCodeSent =
      "Enter the verification code that sent to your mail id ";
  static const String verify = "Verify";
  static const String resetPassword = "Reset Password";
  static const String setNewPassword = "Set a new password for your account";
  static const String couldNotGetCode = "Couldn't get the code?";
  static const String resend = "  RESEND";
  static const String newPassword = "New Password";
  static const String confirmPassword = "Confirm Password";
  static const String successMessageHeader = "Success";
  static const String passwordResetSuccessMessage =
      "Your password has been reset successfully";

  static const String enterMobileNo = "Please enter Email Id ";

  static const String mobileNoMustBe = 'Mobile Number must be of 10 digit';

  static const String enterValidEmail = 'Enter Valid Email';

  // Dashboard

  static const String appName = 'Woloo';
  static const String goodMorning = 'Good Morning,';
  static const String userName = 'Mahendra';
  // Validation

  static const String passwordIsRequired = "Password is required";
  static const String passwordMustBe =
      "Password Must be more than 8 characters";
  static const String loginPasswordMustBe =
      "Password Must be more than 4 characters";
  static const String passwordShouldContain =
      "Password should contain upper,lower,digit and Special character "; //
  static const String passwordShouldSame = "Password should be same";
  static var passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
}
