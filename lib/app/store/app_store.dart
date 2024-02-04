import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartcard/app/utils/resource/constants_manager.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isDarkMode = false;

  @observable
  bool isFirstTime = true;

  @observable
  bool isDisableNotification = false;

  @observable
  bool isLoggedIn = false;

  @observable
  bool sampleFileExist = false;

  @observable
  bool purchasedFileExist = false;

  @observable
  bool isLoading = false;

  @observable
  bool isDownloading = false;

  @observable
  String token = '';

  @observable
  String branchUUID = '';

  @observable
  String userName = '';

  @observable
  String address = '';

  @observable
  String name = '';

  @observable
  String userEmail = '';

  @observable
  String phone = '';

  @observable
  String userProfile = '';

  @observable
  String contactName = '';

  @observable
  String userContactNumber = '';

  @observable
  int userId = 0;

  @observable
  String selectPaymentMode = '';

  @observable
  int pageVariant = 1;

  @observable
  double downloadPercentageStore = 0.0;

  @observable
  List<String> recentSearch = <String>[];

  @observable
  int cartCount = 0;

  @observable
  num userBalance = 0;

  @observable
  double total = 0;

  @observable
  double payableAmount = 0;

  @computed
  bool get isNetworkConnected => connectivityResult != ConnectivityResult.none;

  @observable
  ConnectivityResult connectivityResult = ConnectivityResult.none;

  @observable
  bool isAddToCart = false;

  @action
  Future<void> setCartCount(int value) async {
    cartCount = value;
    await setValue(CART_COUNT, value);
  }

  @action
  Future<void> setRecentSearchData(List<String> data) async {
    recentSearch = data;
    await setValue(SEARCH_TEXT, data);
  }

  @action
  Future<void> setDisplayWalkThrough(bool val) async {
    isFirstTime = val;
    await setValue(IS_EXIST_IN_CART, isFirstTime);
  }

  @action
  Future<void> setLoggedIn(bool val, {bool isInitializing = false}) async {
    isLoggedIn = val;
    if (!isInitializing) await setValue(IS_LOGGED_IN, val);
  }

  @action
  Future<void> setLoading(bool val) async {
    isLoading = val;
    await setValue(IS_LOADING, isLoading);
  }

  @action
  Future<void> setToken(String val, {bool isInitializing = false}) async {
    token = val;
    if (!isInitializing) await setValue(TOKEN, val);
  }

  @action
  Future<void> setUUID(String val, {bool isInitializing = false}) async {
    branchUUID = val;
    if (!isInitializing) await setValue(BRANCHUUID, val);
  }

  @action
  Future<void> setUserName(String val, {bool isInitializing = false}) async {
    userName = val;
    if (!isInitializing) await setValue(USERNAME, val);
  }

  @action
  Future<void> setUserBalance(int val, {bool isInitializing = false}) async {
    userBalance = val;
    if (!isInitializing) await setValue(USER_BALANCE, val);
  }

  @action
  Future<void> setName(String val, {bool isInitializing = false}) async {
    name = val;
    if (!isInitializing) await setValue(NAME, val);
  }

  @action
  Future<void> setContactName(String val, {bool isInitializing = false}) async {
    contactName = val;
    if (!isInitializing) await setValue(CONTACTNAME, val);
  }

  @action
  Future<void> setAddress(String val, {bool isInitializing = false}) async {
    address = val;
    if (!isInitializing) await setValue(ADDRESS, val);
  }

  @action
  Future<void> setPhone(String val, {bool isInitializing = false}) async {
    phone = val;
    if (!isInitializing) await setValue(PHONE, val);
  }

  @action
  Future<void> setUserEmail(String val, {bool isInitializing = false}) async {
    userEmail = val;
    if (!isInitializing) await setValue(USER_EMAIL, val);
  }

  @action
  Future<void> setUserProfile(String val, {bool isInitializing = false}) async {
    userProfile = val;
    if (!isInitializing) await setValue(USER_PROFILE, val);
  }

  @action
  Future<void> setUserContactNumber(String val,
      {bool isInitializing = false}) async {
    userContactNumber = val;
    if (!isInitializing) await setValue(USER_CONTACT_NUMBER, val);
  }

  @action
  Future<void> setUserId(int val, {bool isInitializing = false}) async {
    userId = val;
    if (!isInitializing) await setValue(USER_ID, val);
  }

  @action
  void setConnectionState(ConnectivityResult val) {
    connectivityResult = val;
  }

  @action
  Future<void> setPayableAmount(double value) async {
    payableAmount = value;
    await setValue(CART_TOTAL, value);
  }

  @action
  Future<void> setAddToCart(bool val) async {
    isAddToCart = val;
    await setValue(IS_ADD_TO_CART, val);
  }

  @action
  Future<void> checkToken(String val, {bool isInitializing = false}) async {
    token = val;
  }

  bool isTokenExpired(value) {
    print(value);
    bool isTokenExpired = JwtDecoder.isExpired(value);
    return isTokenExpired;
  }
}
