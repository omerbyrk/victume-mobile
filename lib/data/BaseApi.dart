import 'package:flutter/material.dart';
import 'package:victume_mobile/data/network/dio_client.dart';

class BaseApi {
  @protected
  final DioClient dioClient;

  BaseApi(this.dioClient);

  bool get onProcess => dioClient.onProcess;
}
