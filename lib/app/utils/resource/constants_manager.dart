
import '../helper/cache_helper.dart';

const int splashDelay = 3;
const String baseUrl = "https://monazama.acwad-it.com/api/";
const String empty = "";
const int zero = 0;
const int apiTimeOut = 60000;
const FIRST_TIME = "FIRST_TIME";
const IS_LOGGED_IN = "IS_LOGGED_IN";
const IS_NOTIFICATION = "IS_NOTIFICATION";
const IS_DARK_MODE = "IS_DARK_MODE";
const IS_LOADING = "IS_LOADING";
const IS_DOWNLOADING = "IS_DOWNLOADING";
const TOKEN = "TOKEN";
var FIRSTLOGIN = CashHelper.getData(key: "changePassword") ?? 0;
const BRANCHUUID = "BRANCHUUID";
const PLAYER_ID = "PLAYER_ID";
const USERNAME = "USERNAME";
const USER_BALANCE = "USER_BALANCE";
const USER_ID = "USER_ID";
const NAME = "NAME";
const ADDRESS = "ADDRESS";
const PHONE = "PHONE";
const CONTACTNAME = "CONTACTNAME";
const USER_EMAIL = "USER_EMAIL";
const USER_PROFILE = "USER_PROFILE";
const USER_CONTACT_NUMBER = "USER_CONTACT_NUMBER";
const SELECTED_PAYMENT_MODE = "SELECTED_PAYMENT_MODE";
const PAGE_VARIANT = 'PAGE_VARIANT';
const DOWNLOAD_PERCENTAGE = 'DOWNLOAD_PERCENTAGE';
const SEARCH_TEXT = 'SEARCH_TEXT';
const WISH_LIST_ITEM_CHANGED = 'WISH_LIST_ITEM_CHANGED';
const DOWNLOADING_BOOK = 'DOWNLOADING_BOOK';
const LIBRARY_BOOK_DATA = 'LIBRARY_BOOK_DATA';
const CHECK_SAMPLE_FILE = 'CHECK_SAMPLE_FILE';
const CHECK_PURCHASE_FILE = 'CHECK_PURCHASE_FILE';
const IS_EXIST_IN_CART = 'IS_EXIST_IN_CART';
const IS_ADD_TO_CART = 'IS_ADD_TO_CART';

///endregion

///Live Stream key
const LIVESTREAM_TOKEN = 'tokenStream';
const CART_COUNT = 'CART_COUNT';
const CART_COUNT_ACTION = "cart_count_action";
const CART_DATA_CHANGED = "CART_DATA_CHANGED";
const IS_REVIEW_CHANGE = "IS_REVIEW_CHANGE";
const UPDATE_DATA = "UPDATE_DATA";

///endregion

///setting screen
const PRIVACY = "PRIVACY";
const TERMS_CONDITIONS = "TERMS_CONDITIONS";
const RATE_US = "RATE_US";
const FEEDBACK = "FEEDBACK";
const ABOUT_APP = "ABOUT_APP";
const SHARE_APP = "SHARE";

///endregion

/// Transaction History Status
const TRANSACTION_PENDING = "Pending";
const TRANSACTION_SUCCESS = "Success";
const TRANSACTION_FAILED = "Failed";

///endregion

///Book Type
const TOP_SEARCH_BOOKS = "top_search_book";
const POPULAR_BOOKS = "popular_book";
const TOP_SELL_BOOKS = "top_sell_book";
const RECOMMENDED_BOOKS = "recommended_book";
const AUTHOR_BOOK = "AUTHOR_BOOK";

///end region

///payment status
const PAYMENT_STATUS_SUCCESS = "success";
const PAYMENT_STATUS_FAILED = "failed";
const PAYMENT_PAID = "PAYMENT_PAID";
const PAYMENT_FAILED = "Failed";

///end region

const DATE_FORMAT_1 = 'd MMM, yyyy';
const DATE_FORMAT_2 = 'M/d/yyyy hh:mm a';
const DATE_FORMAT_3 = 'hh:mm a';
const DATE_FORMAT_4 = 'd MMM';
const DATE_FORMAT_5 = 'yyyy';
const DATE_FORMAT_6 = 'd MMMM, yyyy';
const DATE_FORMAT_7 = 'yyyy-MM-dd';

const LAST_BOOK_PAGE = "LAST_BOOK_PAGE";
const REFRESH_lIBRARY_LIST = "REFRESH_LIST";

///PAYMENT STATUS
const PAYTM_STATUS = 1;
const PAYPAL_STATUS = 2;
const GOOGLE_PAY_STATUS = 3;
const STRIPE_STATUS = 4;
const PAY_STACK_STATUS = 5;
const FLUTTER_WAVE_STATUS = 6;
const RAZOR_PAY_STATUS = 7;

///Payment MethodCall
const PAYPAL = 'paypal';
const PAYTM = 'paytm';
const RAZOR_PAY = 'razorPay';
const STRIPE = 'stripe';
const PAY_STACK = 'payStack';
const FLUTTER_WAVE = 'flutterWave';

///cart key

const CART_TOTAL = 'CART_TOTAL';
const MRP = "MRP";
const DISCOUNT = 'DISCOUNT';
const DISCOUNT_PRICE = "DISCOUNT_PRICE";
const TOTAL_MRP = "TOTAL_MRP";
const TOTAl_DISCOUNT_AMOUNT = 'TOTAl_DISCOUNT_AMOUNT';

String token = "";

//user Data
int? userId = CashHelper.getData(key: "user_id");
String? username = CashHelper.getData(key: "username");
String? createdBy = CashHelper.getData(key: "createdBy");
String? phone = CashHelper.getData(key: "phone");
String? address = CashHelper.getData(key: "address");
