import 'package:flutter/material.dart';
import 'package:my_drift/db/db_service.dart';
import 'package:my_drift/screen/add_user_screen.dart';
import 'package:my_drift/screen/home_screen.dart';
import 'package:my_drift/screen/update_user_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arg = settings.arguments ;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/addusers':
        return MaterialPageRoute(builder: (context) => const AddUserScreen());
      case '/updateusers':
      print(arg);
       if( arg is UserData){
        print(arg);
           return MaterialPageRoute(
          
            builder: (context) =>  UpdateUserScreen(user: arg,));
       }  
       return  errorRoute();
      default:
        return errorRoute();
    }
  }

  static MaterialPageRoute<dynamic> errorRoute() {
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text("No Route Available"),
          ),
        ),
      );
  }
}
