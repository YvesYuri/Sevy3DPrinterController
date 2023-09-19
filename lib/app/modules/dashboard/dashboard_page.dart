import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
          toolbarHeight: 100,
          title: const Text('Dashboard', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: const Center(
        child: Text(
          'DashboardPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
