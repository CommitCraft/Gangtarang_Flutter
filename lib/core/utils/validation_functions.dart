import 'package:amazmart/core/app_export.dart';

/// Checks if string consist only Alphabet. (No Whitespace)
bool isText(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;
  if (!isRequired && (inputString == null || inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern = r'^[a-zA-Z]+$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }
  return isInputStringValid;
}

/// Checks if string consist only numeric.
bool isNumeric(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;
  if (!isRequired && (inputString == null || inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern = r'^\d+$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }
  return isInputStringValid;
}

/// Checks if string is email.
bool isValidEmail(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;
  if (!isRequired && (inputString == null || inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern =   r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }
  return isInputStringValid;
}

// Card Valid / Card Invalid
String getCardType(String cardNumber) {
  if (cardNumber.isEmpty) return ImageConstant.isEmpty;

  if (cardNumber.startsWith('4')) {
    return ImageConstant.iconVisa;
  } else if (cardNumber.startsWith(RegExp(r'5[1-5]')) ||
      cardNumber.startsWith(RegExp(r'222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720'))) {
    return ImageConstant.cardmasterCard;
  } else if (cardNumber.startsWith('34') || cardNumber.startsWith('37')) {
    return ImageConstant.cardAmericanExpress;
  } else if (cardNumber.startsWith('6011') ||
      cardNumber.startsWith(RegExp(r'622(12[6-9]|1[3-9][0-9]|[2-8][0-9]{2}|9[01][0-9]|92[0-5])')) ||
      cardNumber.startsWith(RegExp(r'64[4-9]')) ||
      cardNumber.startsWith('65')) {
    return ImageConstant.cardDiscover;
  } else {
    return ImageConstant.imageNotFound;
  }
}

String maskCardNumber(String cardNumber) {
  if (cardNumber.length == 16) {
    String maskedPart = '*' * 12;
    String visiblePart = cardNumber.substring(12);

    // Group the masked part and visible part into sets of 4 with spaces
    return maskedPart.substring(0, 4) +
        ' ' +
        maskedPart.substring(4, 8) +
        ' ' +
        maskedPart.substring(8, 12) +
        ' ' +
        visiblePart.substring(0, 4);
  } else {
    return cardNumber; // Return as is if not 16 characters
  }
}

