import 'package:shared_preferences/shared_preferences.dart';
import 'package:mayrasales/model/product.dart';
import 'dart:convert';

class UserPreferences {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _kLoggedIn = "loggedIn";
  static final String _kUserId = "userId";
  static final String _kUsername = "username";
  static final String _kUserAddress = "useraddress";
  static final String _kPassword = "password";
  //static final String _kContactNumber = "contactnumber";
  static final String _kEmail = "email";
  static final String _kApiToken = "apitoken";
  static final String _kPhone = "phone";
  static final String _kEmailVerified = "emailverified";
  static final String _kUserType = "usertype";

  static final String _kShopName = "shopname";
  static final String _kShopAddress = "shopaddress";
  static final String _kRegNumber = "regnumber";

  static final String _kProfilePic = "profilePic";
  static final String _kCart = "wishlist";

  static final String _kLangPref = "langpref";

  static final String _kCookies = "cookies";
  static final String _kToken = "token";

  static void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_kLoggedIn, false);
    prefs.remove(_kUserId);
    prefs.remove(_kEmail);
    prefs.remove(_kUsername);
    prefs.remove(_kPassword);
    prefs.remove(_kApiToken);
    prefs.remove(_kPhone);
    prefs.remove(_kEmailVerified);
    prefs.remove(_kUserType);
    prefs.remove(_kCookies);
    prefs.remove(_kUserAddress);
    prefs.remove(_kProfilePic);
    prefs.remove(_kToken);
  }

  static void sellerLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_kLoggedIn, false);
    prefs.remove(_kUserId);
    prefs.remove(_kEmail);
    prefs.remove(_kUsername);
    prefs.remove(_kApiToken);
    prefs.remove(_kPhone);
    prefs.remove(_kEmailVerified);
    prefs.remove(_kUserType);
    prefs.remove(_kShopName);
    prefs.remove(_kShopAddress);
    prefs.remove(_kRegNumber);
    prefs.remove(_kCookies);
  }

  /// ------------------------------------------------------------
  /// Method that returns the user login status, false if not set
  /// ------------------------------------------------------------
  static Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var ls;

    if (prefs.getBool(_kLoggedIn) == null) {
      ls = false;
    } else {
      ls = prefs.getBool(_kLoggedIn);
    }

    return ls;
  }

  /// ----------------------------------------------------------
  /// Method that saves the user login status
  /// ----------------------------------------------------------
  static Future<bool> setLoginStatus(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_kLoggedIn, value);
  }

  /// ------------------------------------------------------------
  /// Method that returns the user login status, false if not set
  /// ------------------------------------------------------------
  static Future<String> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUsername);
  }

  static Future<bool> setUsername(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUsername, value);
  }

  static Future<String> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kPassword);
  }

  static Future<bool> setPassword(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kPassword, value);
  }

  static Future<String> getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUserAddress);
  }

  static Future<bool> setAddress(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUserAddress, value);
  }

  static Future<String> getProfilePic() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kProfilePic);
  }

  static Future<bool> setProfilePic(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kProfilePic, value);
  }

  static Future<int> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(_kUserId);
  }

  static Future<bool> setUserId(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(_kUserId, value);
  }

  static Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kEmail);
  }

  static Future<bool> setEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kEmail, value);
  }

  static Future<String> getApiToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kApiToken);
  }

  static Future<bool> setApiToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kApiToken, value);
  }

  static Future<String> getContactNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kPhone);
  }

  static Future<bool> setContactNumber(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kPhone, value);
  }

  static Future<String> getEmailVerified() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kEmailVerified);
  }

  static Future<bool> setEmailVerified(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kEmailVerified, value);
  }

  static Future<String> getUserType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kUserType);
  }

  static Future<bool> setUserType(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kUserType, value);
  }

  static Future<String> getShopName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kShopName);
  }

  static Future<bool> setShopName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kShopName, value);
  }

  static Future<String> getShopAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kShopAddress);
  }

  static Future<bool> setShopAddress(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kShopAddress, value);
  }

  static Future<String> getRegNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kRegNumber);
  }

  static Future<bool> setRegNumber(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kRegNumber, value);
  }

  static Future<String> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return json.decode(prefs.getString(_kCart));
  }

  static Future<bool> setCart(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kCart, json.encode(value));
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
  }

  static Future<String> getCookies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kCookies);
  }

  static Future<bool> setCookies(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kCookies, value);
  }

  static Future<String> getLanguagePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kLangPref) ?? "en";
  }

  static Future<bool> setLanguagePreference(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kLangPref, value);
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kToken);
  }

  static Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kToken, value);
  }
}
