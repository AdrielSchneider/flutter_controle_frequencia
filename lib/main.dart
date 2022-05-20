import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/ui/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Controle de Frequência",
      home: HomePage(),
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [Locale('pt')],
    ));
