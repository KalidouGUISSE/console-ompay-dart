import 'dart:convert';
import 'package:http/http.dart' as http;
import '../interfaces/i_api_client.dart';

class ApiClient implements IApiClient 
{
    final String baseUrl;
    @override
    String? token;
    @override
    String? numero;


    ApiClient({required this.baseUrl, this.token});

    Map<String, String> get _headers 
    {
        final headers = {'Content-Type': 'application/json'};
        if (token != null) headers['Authorization'] = 'Bearer $token';
        return headers;
    }

    @override
    Future<Map<String, dynamic>> get(String path) async 
    {
        final res = await http.get(Uri.parse('$baseUrl$path'), headers: _headers);
        return _processResponse(res);
    }

    @override
    Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) async 
    {
        final res = await http.post(Uri.parse('$baseUrl$path'),
        headers: _headers, body: jsonEncode(body));
        return _processResponse(res);
    }

    Map<String, dynamic> _processResponse(http.Response res) 
    {
        final data = jsonDecode(res.body);
        if (res.statusCode >= 200 && res.statusCode < 300) 
        {
            return data;
        } else 
        {
            throw Exception(data['message'] ?? 'Erreur API');
        }
    }
}
