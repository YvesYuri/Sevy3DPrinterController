import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sevy_3d_printer_controller/app/core/theme/colors_theme.dart';
import 'app/core/bindings/application_bindings.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ColorsTheme.backgroundColor,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web,);
  initServices();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3D Printer Controller',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: ColorsTheme.backgroundColor,       
      ),
      initialBinding: ApplicationBindings(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

void initServices()  {
  Get.put(() => ApplicationBindings().dependencies());
}
