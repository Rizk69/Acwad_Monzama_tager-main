import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/screens/beneficary/contactcard.dart';
import 'package:smartcard/app/screens/invoices/all_project_invoices.dart';
import 'package:smartcard/app/screens/auth/login.dart';
import 'package:smartcard/app/screens/invoices/cash_categroy.dart';
import 'package:smartcard/app/screens/invoices/cashdailyscreen.dart';
import '../../app/screens/home_form.dart';
import '../screens/invoices/daily_invoices.dart';
import '../screens/invoices/invoicedetails.dart';
import '../screens/invoices/vendor_invoices.dart';
import '../screens/auth/profile.dart';
import 'resource/strings_manager.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String homeFormRoute = "/homeForm";
  static const String loginFormRoute = "/loginForm";
  static const String addInvoiceRoute = "/addInvoice";
  static const String balanceWithdrawalRoute = "/balanceWithdrawal";
  static const String invoicesRoute = "/invoices";
  static const String allInvoiceRoute = "/allInvoices";
  static const String invoiceDetailsRoute = "/InvoiceDetails";
  static const String profileRoute = "/Profile";
  static const String contactCardRoute = "/contactCard";
  static const String invoicePrintContactRoute = "/invoicePrint_contact";
  static const String invoicePrintEmployeeRoute = "/invoicePrint_employee";
  static const String employeeCardRoute = "/employeeCard";
  static const String cashCategory = "/cashCategory";
  static const String cashDailyScreen = "/cashDailyScreen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.cashCategory:
        return MaterialPageRoute(builder: (_) => CashCategory());
      case Routes.cashDailyScreen:
        return MaterialPageRoute(builder: (_) => CashDailyScreen());
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
