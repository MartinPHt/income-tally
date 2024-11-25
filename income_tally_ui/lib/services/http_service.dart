import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:income_tally/Models/expense_request.dart';
import 'package:income_tally/services/constants.dart';
import 'package:income_tally/services/helpers.dart';

abstract class EntityHttpService {
  final String baseUrl;
  final String controllerName;
  final int defaultTimeoutSec;
  final Client _httpClient;

  EntityHttpService(
      {required this.baseUrl,
      required this.controllerName,
      this.defaultTimeoutSec = 30})
      : _httpClient = Client();

  // Post request
  Future<T> postAsync<T>(
      {required PostExpenseRequestBody requestBody, int? timeoutSec}) async {
    Uint8List? requestContent;
    final jsonString = JsonSerialize.serialize(requestBody);
    requestContent = utf8.encode(jsonString);

    final response = await _httpClient
        .post(
          Uri.parse('$baseUrl$controllerName'),
          headers: {'Content-Type': 'application/json'},
          body: requestContent,
        )
        .timeout(Duration(seconds: timeoutSec ?? defaultTimeoutSec));

    if (response.statusCode == 200) {
      return JsonSerialize.deserialize<T>(response.body);
    } else {
      throw HttpException('Request failed with status: ${response.statusCode}');
    }
  }

  // Get search request
  Future<T> getSearchAsync<T>(
      {required String filter,
      required String searchWord,
      int? timeoutSec}) async {
    final response = await _httpClient
        .get(
          Uri.parse('$baseUrl$controllerName/search/$filter/$searchWord'),
        )
        .timeout(Duration(seconds: timeoutSec ?? defaultTimeoutSec));

    if (response.statusCode == 200) {
      return JsonSerialize.deserialize<T>(response.body);
    } else {
      throw HttpException('Request failed with status: ${response.statusCode}');
    }
  }

  // Get request by ID
  Future<T> getAsync<T>({required String id, int? timeoutSec}) async {
    final response = await _httpClient
        .get(
          Uri.parse('$baseUrl$controllerName/$id'),
        )
        .timeout(Duration(seconds: timeoutSec ?? defaultTimeoutSec));

    if (response.statusCode == 200) {
      return JsonSerialize.deserialize<T>(response.body);
    } else {
      throw HttpException('Request failed with status: ${response.statusCode}');
    }
  }

  // Get all request
  Future<T> getAllAsync<T>({int? timeoutSec}) async {
    final response = await _httpClient
        .get(
          Uri.parse('$baseUrl$controllerName'),
        )
        .timeout(Duration(seconds: timeoutSec ?? defaultTimeoutSec));

    if (response.statusCode == 200) {
      return JsonSerialize.deserialize<T>(response.body);
    } else {
      throw HttpException('Request failed with status: ${response.statusCode}');
    }
  }

  // Put request
  Future<T> putAsync<T>(
      {required int id,
      required PutExpenseRequestBody request,
      int? timeoutSec}) async {
    Uint8List? requestContent;
    final jsonString = JsonSerialize.serialize(request);
    requestContent = utf8.encode(jsonString);

    final response = await _httpClient
        .put(
          Uri.parse('$baseUrl$controllerName/$id'),
          headers: {'Content-Type': 'application/json'},
          body: requestContent,
        )
        .timeout(Duration(seconds: timeoutSec ?? defaultTimeoutSec));

    if (response.statusCode == 200) {
      return JsonSerialize.deserialize<T>(response.body);
    } else {
      throw HttpException('Request failed with status: ${response.statusCode}');
    }
  }

  // Delete request
  Future<T> deleteAsync<T>({required String id, int? timeoutSec}) async {
    final response = await _httpClient
        .delete(
          Uri.parse('$baseUrl$controllerName/$id'),
        )
        .timeout(Duration(seconds: timeoutSec ?? defaultTimeoutSec));

    if (response.statusCode == 200) {
      return JsonSerialize.deserialize<T>(response.body);
    } else {
      throw HttpException('Request failed with status: ${response.statusCode}');
    }
  }
}

class ExpenseHttpService extends EntityHttpService {
  static ExpenseHttpService instance = ExpenseHttpService._internal(
      baseUrl: AppConstants.defaultApiUrl,
      controllerName: AppConstants.expensesController);

  ExpenseHttpService._internal(
      {required super.baseUrl, required super.controllerName});

  factory ExpenseHttpService() {
    return instance;
  }
}
