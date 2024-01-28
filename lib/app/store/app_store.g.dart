// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  Computed<bool>? _$isNetworkConnectedComputed;

  @override
  bool get isNetworkConnected => (_$isNetworkConnectedComputed ??=
          Computed<bool>(() => super.isNetworkConnected,
              name: '_AppStore.isNetworkConnected'))
      .value;

  late final _$isDarkModeAtom =
      Atom(name: '_AppStore.isDarkMode', context: context);

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  late final _$isFirstTimeAtom =
      Atom(name: '_AppStore.isFirstTime', context: context);

  @override
  bool get isFirstTime {
    _$isFirstTimeAtom.reportRead();
    return super.isFirstTime;
  }

  @override
  set isFirstTime(bool value) {
    _$isFirstTimeAtom.reportWrite(value, super.isFirstTime, () {
      super.isFirstTime = value;
    });
  }

  late final _$isDisableNotificationAtom =
      Atom(name: '_AppStore.isDisableNotification', context: context);

  @override
  bool get isDisableNotification {
    _$isDisableNotificationAtom.reportRead();
    return super.isDisableNotification;
  }

  @override
  set isDisableNotification(bool value) {
    _$isDisableNotificationAtom.reportWrite(value, super.isDisableNotification,
        () {
      super.isDisableNotification = value;
    });
  }

  late final _$isLoggedInAtom =
      Atom(name: '_AppStore.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$sampleFileExistAtom =
      Atom(name: '_AppStore.sampleFileExist', context: context);

  @override
  bool get sampleFileExist {
    _$sampleFileExistAtom.reportRead();
    return super.sampleFileExist;
  }

  @override
  set sampleFileExist(bool value) {
    _$sampleFileExistAtom.reportWrite(value, super.sampleFileExist, () {
      super.sampleFileExist = value;
    });
  }

  late final _$purchasedFileExistAtom =
      Atom(name: '_AppStore.purchasedFileExist', context: context);

  @override
  bool get purchasedFileExist {
    _$purchasedFileExistAtom.reportRead();
    return super.purchasedFileExist;
  }

  @override
  set purchasedFileExist(bool value) {
    _$purchasedFileExistAtom.reportWrite(value, super.purchasedFileExist, () {
      super.purchasedFileExist = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AppStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isDownloadingAtom =
      Atom(name: '_AppStore.isDownloading', context: context);

  @override
  bool get isDownloading {
    _$isDownloadingAtom.reportRead();
    return super.isDownloading;
  }

  @override
  set isDownloading(bool value) {
    _$isDownloadingAtom.reportWrite(value, super.isDownloading, () {
      super.isDownloading = value;
    });
  }

  late final _$tokenAtom = Atom(name: '_AppStore.token', context: context);

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$branchUUIDAtom =
      Atom(name: '_AppStore.branchUUID', context: context);

  @override
  String get branchUUID {
    _$branchUUIDAtom.reportRead();
    return super.branchUUID;
  }

  @override
  set branchUUID(String value) {
    _$branchUUIDAtom.reportWrite(value, super.branchUUID, () {
      super.branchUUID = value;
    });
  }

  late final _$userNameAtom =
      Atom(name: '_AppStore.userName', context: context);

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  late final _$addressAtom = Atom(name: '_AppStore.address', context: context);

  @override
  String get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  late final _$nameAtom = Atom(name: '_AppStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$userEmailAtom =
      Atom(name: '_AppStore.userEmail', context: context);

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  late final _$phoneAtom = Atom(name: '_AppStore.phone', context: context);

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  late final _$userProfileAtom =
      Atom(name: '_AppStore.userProfile', context: context);

  @override
  String get userProfile {
    _$userProfileAtom.reportRead();
    return super.userProfile;
  }

  @override
  set userProfile(String value) {
    _$userProfileAtom.reportWrite(value, super.userProfile, () {
      super.userProfile = value;
    });
  }

  late final _$contactNameAtom =
      Atom(name: '_AppStore.contactName', context: context);

  @override
  String get contactName {
    _$contactNameAtom.reportRead();
    return super.contactName;
  }

  @override
  set contactName(String value) {
    _$contactNameAtom.reportWrite(value, super.contactName, () {
      super.contactName = value;
    });
  }

  late final _$userContactNumberAtom =
      Atom(name: '_AppStore.userContactNumber', context: context);

  @override
  String get userContactNumber {
    _$userContactNumberAtom.reportRead();
    return super.userContactNumber;
  }

  @override
  set userContactNumber(String value) {
    _$userContactNumberAtom.reportWrite(value, super.userContactNumber, () {
      super.userContactNumber = value;
    });
  }

  late final _$userIdAtom = Atom(name: '_AppStore.userId', context: context);

  @override
  int get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(int value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  late final _$selectPaymentModeAtom =
      Atom(name: '_AppStore.selectPaymentMode', context: context);

  @override
  String get selectPaymentMode {
    _$selectPaymentModeAtom.reportRead();
    return super.selectPaymentMode;
  }

  @override
  set selectPaymentMode(String value) {
    _$selectPaymentModeAtom.reportWrite(value, super.selectPaymentMode, () {
      super.selectPaymentMode = value;
    });
  }

  late final _$pageVariantAtom =
      Atom(name: '_AppStore.pageVariant', context: context);

  @override
  int get pageVariant {
    _$pageVariantAtom.reportRead();
    return super.pageVariant;
  }

  @override
  set pageVariant(int value) {
    _$pageVariantAtom.reportWrite(value, super.pageVariant, () {
      super.pageVariant = value;
    });
  }

  late final _$downloadPercentageStoreAtom =
      Atom(name: '_AppStore.downloadPercentageStore', context: context);

  @override
  double get downloadPercentageStore {
    _$downloadPercentageStoreAtom.reportRead();
    return super.downloadPercentageStore;
  }

  @override
  set downloadPercentageStore(double value) {
    _$downloadPercentageStoreAtom
        .reportWrite(value, super.downloadPercentageStore, () {
      super.downloadPercentageStore = value;
    });
  }

  late final _$recentSearchAtom =
      Atom(name: '_AppStore.recentSearch', context: context);

  @override
  List<String> get recentSearch {
    _$recentSearchAtom.reportRead();
    return super.recentSearch;
  }

  @override
  set recentSearch(List<String> value) {
    _$recentSearchAtom.reportWrite(value, super.recentSearch, () {
      super.recentSearch = value;
    });
  }

  late final _$cartCountAtom =
      Atom(name: '_AppStore.cartCount', context: context);

  @override
  int get cartCount {
    _$cartCountAtom.reportRead();
    return super.cartCount;
  }

  @override
  set cartCount(int value) {
    _$cartCountAtom.reportWrite(value, super.cartCount, () {
      super.cartCount = value;
    });
  }

  late final _$userBalanceAtom =
      Atom(name: '_AppStore.userBalance', context: context);

  @override
  num get userBalance {
    _$userBalanceAtom.reportRead();
    return super.userBalance;
  }

  @override
  set userBalance(num value) {
    _$userBalanceAtom.reportWrite(value, super.userBalance, () {
      super.userBalance = value;
    });
  }

  late final _$totalAtom = Atom(name: '_AppStore.total', context: context);

  @override
  double get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(double value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
    });
  }

  late final _$payableAmountAtom =
      Atom(name: '_AppStore.payableAmount', context: context);

  @override
  double get payableAmount {
    _$payableAmountAtom.reportRead();
    return super.payableAmount;
  }

  @override
  set payableAmount(double value) {
    _$payableAmountAtom.reportWrite(value, super.payableAmount, () {
      super.payableAmount = value;
    });
  }

  late final _$connectivityResultAtom =
      Atom(name: '_AppStore.connectivityResult', context: context);

  @override
  ConnectivityResult get connectivityResult {
    _$connectivityResultAtom.reportRead();
    return super.connectivityResult;
  }

  @override
  set connectivityResult(ConnectivityResult value) {
    _$connectivityResultAtom.reportWrite(value, super.connectivityResult, () {
      super.connectivityResult = value;
    });
  }

  late final _$isAddToCartAtom =
      Atom(name: '_AppStore.isAddToCart', context: context);

  @override
  bool get isAddToCart {
    _$isAddToCartAtom.reportRead();
    return super.isAddToCart;
  }

  @override
  set isAddToCart(bool value) {
    _$isAddToCartAtom.reportWrite(value, super.isAddToCart, () {
      super.isAddToCart = value;
    });
  }

  late final _$setCartCountAsyncAction =
      AsyncAction('_AppStore.setCartCount', context: context);

  @override
  Future<void> setCartCount(int value) {
    return _$setCartCountAsyncAction.run(() => super.setCartCount(value));
  }

  late final _$setRecentSearchDataAsyncAction =
      AsyncAction('_AppStore.setRecentSearchData', context: context);

  @override
  Future<void> setRecentSearchData(List<String> data) {
    return _$setRecentSearchDataAsyncAction
        .run(() => super.setRecentSearchData(data));
  }

  late final _$setDisplayWalkThroughAsyncAction =
      AsyncAction('_AppStore.setDisplayWalkThrough', context: context);

  @override
  Future<void> setDisplayWalkThrough(bool val) {
    return _$setDisplayWalkThroughAsyncAction
        .run(() => super.setDisplayWalkThrough(val));
  }

  late final _$setLoggedInAsyncAction =
      AsyncAction('_AppStore.setLoggedIn', context: context);

  @override
  Future<void> setLoggedIn(bool val, {bool isInitializing = false}) {
    return _$setLoggedInAsyncAction
        .run(() => super.setLoggedIn(val, isInitializing: isInitializing));
  }

  late final _$setLoadingAsyncAction =
      AsyncAction('_AppStore.setLoading', context: context);

  @override
  Future<void> setLoading(bool val) {
    return _$setLoadingAsyncAction.run(() => super.setLoading(val));
  }

  late final _$setTokenAsyncAction =
      AsyncAction('_AppStore.setToken', context: context);

  @override
  Future<void> setToken(String val, {bool isInitializing = false}) {
    return _$setTokenAsyncAction
        .run(() => super.setToken(val, isInitializing: isInitializing));
  }

  late final _$setUUIDAsyncAction =
      AsyncAction('_AppStore.setUUID', context: context);

  @override
  Future<void> setUUID(String val, {bool isInitializing = false}) {
    return _$setUUIDAsyncAction
        .run(() => super.setUUID(val, isInitializing: isInitializing));
  }

  late final _$setUserNameAsyncAction =
      AsyncAction('_AppStore.setUserName', context: context);

  @override
  Future<void> setUserName(String val, {bool isInitializing = false}) {
    return _$setUserNameAsyncAction
        .run(() => super.setUserName(val, isInitializing: isInitializing));
  }

  late final _$setUserBalanceAsyncAction =
      AsyncAction('_AppStore.setUserBalance', context: context);

  @override
  Future<void> setUserBalance(int val, {bool isInitializing = false}) {
    return _$setUserBalanceAsyncAction
        .run(() => super.setUserBalance(val, isInitializing: isInitializing));
  }

  late final _$setNameAsyncAction =
      AsyncAction('_AppStore.setName', context: context);

  @override
  Future<void> setName(String val, {bool isInitializing = false}) {
    return _$setNameAsyncAction
        .run(() => super.setName(val, isInitializing: isInitializing));
  }

  late final _$setContactNameAsyncAction =
      AsyncAction('_AppStore.setContactName', context: context);

  @override
  Future<void> setContactName(String val, {bool isInitializing = false}) {
    return _$setContactNameAsyncAction
        .run(() => super.setContactName(val, isInitializing: isInitializing));
  }

  late final _$setAddressAsyncAction =
      AsyncAction('_AppStore.setAddress', context: context);

  @override
  Future<void> setAddress(String val, {bool isInitializing = false}) {
    return _$setAddressAsyncAction
        .run(() => super.setAddress(val, isInitializing: isInitializing));
  }

  late final _$setPhoneAsyncAction =
      AsyncAction('_AppStore.setPhone', context: context);

  @override
  Future<void> setPhone(String val, {bool isInitializing = false}) {
    return _$setPhoneAsyncAction
        .run(() => super.setPhone(val, isInitializing: isInitializing));
  }

  late final _$setUserEmailAsyncAction =
      AsyncAction('_AppStore.setUserEmail', context: context);

  @override
  Future<void> setUserEmail(String val, {bool isInitializing = false}) {
    return _$setUserEmailAsyncAction
        .run(() => super.setUserEmail(val, isInitializing: isInitializing));
  }

  late final _$setUserProfileAsyncAction =
      AsyncAction('_AppStore.setUserProfile', context: context);

  @override
  Future<void> setUserProfile(String val, {bool isInitializing = false}) {
    return _$setUserProfileAsyncAction
        .run(() => super.setUserProfile(val, isInitializing: isInitializing));
  }

  late final _$setUserContactNumberAsyncAction =
      AsyncAction('_AppStore.setUserContactNumber', context: context);

  @override
  Future<void> setUserContactNumber(String val, {bool isInitializing = false}) {
    return _$setUserContactNumberAsyncAction.run(
        () => super.setUserContactNumber(val, isInitializing: isInitializing));
  }

  late final _$setUserIdAsyncAction =
      AsyncAction('_AppStore.setUserId', context: context);

  @override
  Future<void> setUserId(int val, {bool isInitializing = false}) {
    return _$setUserIdAsyncAction
        .run(() => super.setUserId(val, isInitializing: isInitializing));
  }

  late final _$setPayableAmountAsyncAction =
      AsyncAction('_AppStore.setPayableAmount', context: context);

  @override
  Future<void> setPayableAmount(double value) {
    return _$setPayableAmountAsyncAction
        .run(() => super.setPayableAmount(value));
  }

  late final _$setAddToCartAsyncAction =
      AsyncAction('_AppStore.setAddToCart', context: context);

  @override
  Future<void> setAddToCart(bool val) {
    return _$setAddToCartAsyncAction.run(() => super.setAddToCart(val));
  }

  late final _$checkTokenAsyncAction =
      AsyncAction('_AppStore.checkToken', context: context);

  @override
  Future<void> checkToken(String val, {bool isInitializing = false}) {
    return _$checkTokenAsyncAction
        .run(() => super.checkToken(val, isInitializing: isInitializing));
  }

  late final _$_AppStoreActionController =
      ActionController(name: '_AppStore', context: context);

  @override
  void setConnectionState(ConnectivityResult val) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setConnectionState');
    try {
      return super.setConnectionState(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkMode: ${isDarkMode},
isFirstTime: ${isFirstTime},
isDisableNotification: ${isDisableNotification},
isLoggedIn: ${isLoggedIn},
sampleFileExist: ${sampleFileExist},
purchasedFileExist: ${purchasedFileExist},
isLoading: ${isLoading},
isDownloading: ${isDownloading},
token: ${token},
branchUUID: ${branchUUID},
userName: ${userName},
address: ${address},
name: ${name},
userEmail: ${userEmail},
phone: ${phone},
userProfile: ${userProfile},
contactName: ${contactName},
userContactNumber: ${userContactNumber},
userId: ${userId},
selectPaymentMode: ${selectPaymentMode},
pageVariant: ${pageVariant},
downloadPercentageStore: ${downloadPercentageStore},
recentSearch: ${recentSearch},
cartCount: ${cartCount},
userBalance: ${userBalance},
total: ${total},
payableAmount: ${payableAmount},
connectivityResult: ${connectivityResult},
isAddToCart: ${isAddToCart},
isNetworkConnected: ${isNetworkConnected}
    ''';
  }
}
