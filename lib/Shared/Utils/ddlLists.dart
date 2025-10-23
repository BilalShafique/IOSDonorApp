import 'dart:convert';
import 'dart:typed_data';

import 'package:donor_app/Modules/Profile/Model/donor_profile_model.dart';
import 'package:donor_app/Shared/Utils/SessionMangement.dart';
import 'package:donor_app/Shared/Utils/config.dart';
import 'package:http/http.dart' as http;

Future<List<Country>?> fetchCountry() async {
  try {
    SessionMangement sm = SessionMangement();
    String? sessionId = await sm.getQalamSessionId();
    final requestMap = {
      'jsonrpc': '2.0',
      'params': {},
    };
    final response = await http.post(
      Uri.parse('${qalamUrl}get_all_countries'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': sessionId!
      },
      body: jsonEncode(requestMap),
    );
    List list;
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      list = data["result"]["data"];
      var listData =
          list.map<Country>((json) => Country.fromJson(json)).toList();
      listData.sort((a, b) => a.country_name.compareTo(b.country_name));
      return listData;
    } else {
      throw Exception('Failed to load Country');
    }
  } catch (error) {
    return null;
  }
}

Future<List<GeoRegion>?> fetchGeoRegion() async {
  try {
    SessionMangement sm = SessionMangement();
    String? sessionId = await sm.getQalamSessionId();
    final requestMap = {
      'jsonrpc': '2.0',
      'params': {},
    };
    final response = await http.post(
      Uri.parse('${qalamUrl}get_all_geoarea'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': sessionId!
      },
      body: jsonEncode(requestMap),
    );
    List list;
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      list = data["result"]["data"];
      var listData =
          list.map<GeoRegion>((json) => GeoRegion.fromJson(json)).toList();
      listData.sort((a, b) => a.geo_name.compareTo(b.geo_name));
      return listData;
    } else {
      throw Exception('Failed to region');
    }
  } catch (error) {
    return null;
  }
}

Future<List<Sector>?> fetchSector() async {
  try {
    SessionMangement sm = SessionMangement();
    String? sessionId = await sm.getQalamSessionId();
    final requestMap = {
      'jsonrpc': '2.0',
      'params': {},
    };
    final response = await http.post(
      Uri.parse('${qalamUrl}get_all_sectors'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': sessionId!
      },
      body: jsonEncode(requestMap),
    );
    List list;
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      list = data["result"]["data"];
      var listData = list.map<Sector>((json) => Sector.fromJson(json)).toList();
      listData.sort((a, b) => a.sector_name.compareTo(b.sector_name));
      return listData;
    } else {
      throw Exception('Failed to load sector');
    }
  } catch (error) {
    return null;
  }
}

Future<List<City>?> fetchCity(int countryId) async {
  try {
    SessionMangement sm = SessionMangement();
    String? sessionId = await sm.getQalamSessionId();
    final requestMap = {
      'jsonrpc': '2.0',
      'params': {"country_id": countryId},
    };
    final response = await http.post(
      Uri.parse('${qalamUrl}get_all_cities'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': sessionId!
      },
      body: jsonEncode(requestMap),
    );
    List list;
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      list = data["result"]["data"];
      var listData = list.map<City>((json) => City.fromJson(json)).toList();
      listData.sort((a, b) => a.city_name.compareTo(b.city_name));
      return listData;
    } else {
      throw Exception('Failed to load sector');
    }
  } catch (error) {
    return null;
  }
}

Future<Uint8List?> _fetchImage(String stdPicture) async {
  SessionMangement sm = SessionMangement();

  String? sessionId = await sm.getQalamSessionId();

  final response = await http.get(
    Uri.parse(stdPicture),
    headers: {
      'Content-Type': 'image/jpeg',
      'Accept': 'application/json',
      'Cookie': sessionId!
    },
  );
  if (response.statusCode == 200) {
    return response.bodyBytes;
  } else {
    print('Failed to load image: ${response.statusCode}');
    return null;
  }
}
