import 'package:flutter/material.dart';
import 'package:kappu/models/serializable_model/signedinprovider.dart';

class ProviderProvider extends ChangeNotifier {
  late SignedInProvider provider;
  late String token;
  String providerprofilepicurl = '';
  String cutomorid = '';
}
