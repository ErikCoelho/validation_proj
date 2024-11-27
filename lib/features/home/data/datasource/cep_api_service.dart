import 'package:dio/dio.dart';
import 'package:validator/features/home/data/models/cep.dart';

class CepApiService {
  final dio = Dio();

  Future<Cep> getCep(String codCep) async {
    final response = await dio.get('https://viacep.com.br/ws/${codCep}/json/');

    if (response.statusCode == 200) {
      final body = response.data as Map<String, dynamic>;
      return Cep.fromJson(body);
    } else {
      throw Exception('Failed to fetch CEP data');
    }
  }
}
