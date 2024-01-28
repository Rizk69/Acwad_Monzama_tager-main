class ApiHelper {
  static const baseUrl = "https://monazama.acwad-it.com/";
  static const loginUrl = "${baseUrl}api/vendor/login";

  static const changePasswordUrl = "${baseUrl}api/vendor/changePassword";

  static const invoiceBeneficary = "${baseUrl}api/invoice_beneficary/";
  static const getAllBeneficary = "${baseUrl}api/AllReports";

  static const getDailyBeneficary = "${baseUrl}api/DailyReports/";

  static const getPaidBeneficary = "${baseUrl}api/PaidBeneficary/";
  static const setInvoiceBeneficary = "${baseUrl}api/invoiceBeneficary";
}
