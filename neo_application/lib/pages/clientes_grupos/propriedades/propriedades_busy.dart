import 'package:flutter/foundation.dart';

class PropriedadesBusy extends ChangeNotifier {
  bool isLoading = false;

  void setOnLoad() {
    isLoading = true;

    notifyListeners();
  }

  void setOffLoad() {
    isLoading = false;

    notifyListeners();
  }

}