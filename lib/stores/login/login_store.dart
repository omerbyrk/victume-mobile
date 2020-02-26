import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:victume_mobile/data/UserApi.dart';
import 'package:victume_mobile/data/sharedpref/shared_preference_helper.dart';
import 'package:victume_mobile/main.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

import '../base_store.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore extends BaseStore with Store {
// store for handling form errors
  final LoginErrorStore formErrorStore = LoginErrorStore();
  final UserApi _userApi = appComponent.getUserApi();
  final SharedPreferenceHelper sharedPreferenceHelper =
      appComponent.getSharedPreferenceHelper();

  _LoginStore() {
    _setupValidations();
  }

  List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => userEmail, validateUserEmail),
      reaction((_) => password, validatePassword),
    ];
  }

  @observable
  String userEmail = '';

  @observable
  String password = '';

  @observable
  bool isLoggedIn = false;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin &&
      userEmail.isNotEmpty &&
      password.isNotEmpty;

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "Email can't be empty";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Please enter a valid email address';
    } else {
      formErrorStore.userEmail = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "Password can't be empty";
    } else if (value.length < 6) {
      formErrorStore.password = "Password must be at-least 6 characters long";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void setUserEmail(String userEmail) => this.userEmail = userEmail;
  @action
  void setPassword(String password) => this.password = password;

  @action
  Future login() async {
    try {
      AuthenticationResultDTO result =
          await _userApi.authenticate(userEmail, password);
      sharedPreferenceHelper.saveAuthToken(result.token);
    } on DioError catch (e) {
      uiMessageStore.setError(e.response.data["message"]);
    } finally {
      loading = false;
      isLoggedIn = await sharedPreferenceHelper.isLoggedIn;
    }
  }

  void logout() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.clear(); // Bu localdeki tüm kullanıcı bilgilerini temizliyor.
  }
}

class LoginErrorStore = _LoginErrorStore with _$LoginErrorStore;

abstract class _LoginErrorStore with Store {
  @observable
  String userEmail;

  @observable
  String password;

  @computed
  bool get hasErrorsInLogin => userEmail != null || password != null;
}
