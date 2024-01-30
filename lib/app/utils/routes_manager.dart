import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/screens/all_invoices.dart';
import 'package:smartcard/app/screens/login.dart';
import '../../app/screens/home_form.dart';
import '../screens/Recipts.dart';
import '../screens/contactcard.dart';
import '../screens/dailysales.dart';
import '../screens/invoicedetails.dart';
import '../screens/invoices.dart';
import '../screens/profile.dart';
import '/app/utils/strings_manager.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String homeFormRoute = "/homeForm"; //
  static const String loginFormRoute = "/loginForm"; //
  static const String addInvoiceRoute = "/addInvoice"; //
  static const String balanceWithdrawalRoute = "/balanceWithdrawal";
  static const String invoicesRoute = "/invoices"; //
  static const String allInvoiceRoute = "/allInvoices"; //
  static const String invoiceDetailsRoute = "/InvoiceDetails"; //
  static const String profileRoute = "/Profile"; //
  static const String contactCardRoute = "/contactCard"; //
  static const String invoicePrintContactRoute = "/invoicePrint_contact"; //
  static const String invoicePrintEmployeeRoute = "/invoicePrint_employee"; //
  static const String employeeCardRoute = "/employeeCard"; //
  static const String receiptsRoute = "/receipts"; //
  static const String dailySalesRoute = "/dailySales"; //
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.receiptsRoute:
        return MaterialPageRoute(builder: (_) => Receipts());
      case Routes.dailySalesRoute:
        return MaterialPageRoute(builder: (_) => DailyInvoices());
      case Routes.homeFormRoute:
        return MaterialPageRoute(builder: (_) => const HomeForm());
      case Routes.loginFormRoute:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case Routes.invoicesRoute:
        return MaterialPageRoute(builder: (_) => Invoices());
      case Routes.allInvoiceRoute:
        return MaterialPageRoute(builder: (_) => AllInvoicesView());
      case Routes.invoiceDetailsRoute:
        return MaterialPageRoute(builder: (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as InvoiceBeneficaryData?;
          return InvoiceDetails(item: args);
        });
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const Profile());
      case Routes.contactCardRoute:
        return MaterialPageRoute(builder: (_) => const ContactCard());
      default:
        return MaterialPageRoute(builder: (_) => const HomeForm());
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
