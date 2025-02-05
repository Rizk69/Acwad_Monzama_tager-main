import 'package:connectivity_plus/connectivity_plus.dart';

class ApiHelper {
  static const baseUrl = "https://monazama.acwad-it.com/";
  static const loginUrl = "${baseUrl}api/vendor/login";

  static const changePasswordUrl = "${baseUrl}api/vendor/changePassword";

  static const invoiceBeneficary = "${baseUrl}api/invoice_beneficary/";

  static const invoiceBeneficaryDetails =
      "${baseUrl}api/invoice_BeneficaryReport/";

  static const getAllBeneficary = "${baseUrl}api/AllReports";
  static const getAllPaidProject = "${baseUrl}api/AllPaidProject/";
  static const getPaidProjectDetails = "${baseUrl}api/PaidProjectDetails/";
  static const getCategory = "${baseUrl}api/categoryDetails/";
  static const getDetailsCategory = "${baseUrl}api/WhoTakeCategory/";

  static const getDailyBeneficary = "${baseUrl}api/DailyReports/";

  static const getPaidBeneficary = "${baseUrl}api/PaidBeneficary/";
  static const getProductBeneficary = "${baseUrl}api/invoiceshow/";
  static const setInvoiceBeneficary = "${baseUrl}api/invoiceBeneficary";
  static const setBeneficarySignature = "${baseUrl}api/saveImage/";

  static const sendPaidOfflineUrl = "${baseUrl}api/invoiceBeneficaryOffline";


  static const offline = "${baseUrl}api/getAllData/";


  static bool isInternet = false ;
  Future<bool> connectedToInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isInternet=true;
      return true; // هنا يتم إعادة القيمة true إذا كان هناك اتصال بالإنترنت
    } else {
      isInternet=false;
      return false; // هنا يتم إعادة القيمة false إذا لم يكن هناك اتصال بالإنترنت
    }
  }
}


