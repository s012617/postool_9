import 'package:flutter/material.dart';
import 'package:postool_9/enums/view_state.dart';
import 'package:postool_9/scope_model/base_model.dart';
import 'package:postool_9/service_locator.dart';
import 'package:postool_9/services/api_service.dart';
import 'package:postool_9/utils/http_helper.dart';
import 'package:postool_9/utils/show_alert.dart';
import 'package:postool_9/utils/token_helper.dart';

class LoginViewModel extends BaseModel {
  APIService _apiService = locator<APIService>();
  TokenHelper _tokenHelper = locator<TokenHelper>();

  login(String account, String password, String empId,
      BuildContext context) async {
    setState(ViewState.Busy);
    ResponseResultData response =
        await _apiService.login(account, password, empId);
    if (response.result) {
      _tokenHelper.updateToken(response.data['token']);
      setState(ViewState.DataFetched);
    } else {
      ShowAlert.show(context, "錯誤", response.data["errorMessage"] ?? "登入失敗");
      setState(ViewState.Error);
    }
  }

  checkAuth() async {
    ResponseResultData response = await _apiService.needAuth();
    if (response.result) print(response.data['token']);
    print(response.code);
  }
}
