import 'package:http/http.dart' as http;
import 'config.dart';

class TrashService {
  bool isLoading = false;

  Future<void> postTrashRequest(String type, String weight, String latitude, String longitude, String photo) async {
    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/register');

      final response = await http.post(
        url,
        body: {
          'trash_type': type,
          'trash_weight': weight,
          'latitude': latitude,
          'longitude': longitude,
          'thumb': photo,
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        // success
      } else {
        // failed
      }
    } catch (error) {
      print('Error posting request: $error');
      rethrow;
    }
  }
}