import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unico_check/unico_check.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    implements UnicoListener, UnicoSelfie {
  late UnicoCheckBuilder unicoCheck;
  late UnicoCheckCameraOpener opener;
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    initUnicoCamera();
  }

  void initUnicoCamera() async {
    final unicoConfigAndroid = UnicoConfig(
      getProjectNumber: '742626524617922449',
      getProjectId: 'com.crefaz.meu_crefaz',
      getMobileSdkAppId: '1:453197:android',
      getBundleIdentifier: 'com.crefaz.meucrefaz',
      getHostInfo:
          'nRMqSJJeWMZ0K4n9Dxs/Zhb5RslAxes+pmH0gJgmVtbnEaN0CLYrckRjS3YhpDBo',
      getHostKey:
          'nmnjvP/LuSU4f9n2FGDiqu128xd3/ncuOKRpGV4RwiXvEXiZ/H3c1CJVYM8+abou',
    );
    final unicoConfigIos = UnicoConfig(
      getProjectNumber: '742626524617922449',
      getProjectId: 'com.crefaz.meucrefaz',
      getMobileSdkAppId: '2:453088:ios',
      getBundleIdentifier: 'com.crefaz.meucrefaz',
      getHostInfo:
          'nRMqSJJeWMZ0K4n9Dxs/Zhb5RslAxes+pmH0gJgmVtbnEaN0CLYrckRjS3YhpDBo',
      getHostKey:
          'nmnjvP/LuSU4f9n2FGDiqu128xd3/ncuOKRpGV4RwiXvEXiZ/H3c1CJVYM8+abou',
    );
    unicoCheck = UnicoCheck(
      listener: this,
      unicoConfigAndroid: unicoConfigAndroid,
      unicoConfigIos: unicoConfigIos,
    );
    unicoCheck.setTimeoutSession(timeoutSession: 55);
  }

  void openCameraUnico() {
    opener = unicoCheck
        .setAutoCapture(autoCapture: true)
        .setSmartFrame(smartFrame: true)
        .build();
    opener.openCameraSelfie(listener: this);
  }

  @override
  void onErrorUnico(UnicoError error) {
    logger.e('onErrorUnico - ${error.description}');
    SnackbarUtil.showInfo(
        context, 'Erro - Mantenha o celular em pé para validação Selfie');
  }

  @override
  void onUserClosedCameraManually() {
    SnackbarUtil.showInfo(context, 'Usuario fechou camera manualmente!');
  }

  @override
  void onSystemChangedTypeCameraTimeoutFaceInference() {
    SnackbarUtil.showInfo(context, 'Sistema trocou o tipo da camera!');
  }

  @override
  void onSystemClosedCameraTimeoutSession() {
    SnackbarUtil.showInfo(
        context, 'Sistema fechou a camera devido tempo expirado !');
  }

  /// Selfie callbacks
  @override
  void onSuccessSelfie(CameraResult cameraResult) {
    logger.i('onSuccessSelfie - Sucesso na validação');
    SnackbarUtil.showInfo(context, 'Sucesso na validação');
    setState(() {});
  }

  @override
  void onErrorSelfie(UnicoError error) {
    logger.e('onErrorSelfie - ${error.description}');
    SnackbarUtil.showInfo(context, error.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                ]);
              },
              child: const Text('Modo Portrait'),
            ),
            ElevatedButton(
              onPressed: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
              },
              child: const Text('Modo Landscape'),
            ),
            ElevatedButton(
              onPressed: openCameraUnico,
              child: const Text('Validação Selfie'),
            ),
          ],
        ),
      ),
    );
  }
}

class SnackbarUtil {
  static void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
