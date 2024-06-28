import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class DocusignServiceInterface {
  Future<bool> envelopeExists(String? envelopeId);

  Future<String> createEnvelope(EnvelopeDefinitionModel body);

  Future<String?> deleteEnvelope(String envelopeId);

  Future<String> getRecipientViewUrl(
      String envelopeId, RecipientViewRequestModel body);

  Future<List<int>> getEnvelopeDocument(String envelopeId, String documentId);

  Future<bool> hasRecipientSigned(String envelopeId, String recipientId);

  Future<bool> haveRecipientsSigned(
      String envelopeId, List<String> recipientIds);
}

// Implementation:--------------------------------------------------------------
class DocusignService implements DocusignServiceInterface {
  String accessToken = '';
  String _baseUrl =
      '${dotenv.env['DOCUSIGN_ACCOUNT_BASE_URI']}/v2.1/accounts/${dotenv.env['DOCUSIGN_ACCOUNT_ID']}';
  final String _audienceUrl = dotenv.env['DOCUSIGN_ACCOUNT_SERVER_URI'] ?? '';
  final String _integratorKey =
      dotenv.env['DOCUSIGN_ACCOUNT_INTEGRATOR_KEY'] ?? '';
  final String _userId = dotenv.env['DOCUSIGN_ACCOUNT_USER_ID'] ?? '';
  final String _privateRSAKey =
      (dotenv.env['DOCUSIGN_ACCOUNT_PRIVATE_RSA_KEY'] ?? '')
          .replaceAll('\\n', '\n');

  Map<String, String> getHeaders() {
    return {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
  }

  String _generateJWT() {
    final jwt = JWT({
      'iat': (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
      'exp': (DateTime.now()
                  .add(const Duration(minutes: 2))
                  .millisecondsSinceEpoch /
              1000)
          .floor(),
      'scope': 'signature impersonation'
    },
        audience: Audience([_audienceUrl]),
        subject: _userId,
        issuer: _integratorKey);

    final key = RSAPrivateKey(_privateRSAKey);
    String token = jwt.sign(key, algorithm: JWTAlgorithm.RS256);
    return token;
  }

  Future<void> _auth() async {
    String jwt = _generateJWT();
    var urlParams = {
      'assertion': jwt,
      'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
    };
    var url = Uri.https(_audienceUrl, '/oauth/token', urlParams);
    var response = await http.post(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      accessToken = jsonResponse['access_token'];
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> _setBaseUrl() async {
    AgencyServiceInterface agencyService = getIt<AgencyServiceInterface>();
    Agency? currentAgency = await agencyService.getCurrent();
    if (currentAgency == null) {
      return;
    }
    _baseUrl =
        '${dotenv.env['DOCUSIGN_ACCOUNT_BASE_URI']}/v2.1/accounts/${currentAgency.docusignAccountId ?? dotenv.env['DOCUSIGN_ACCOUNT_ID']}';
  }

  @override
  Future<bool> envelopeExists(String? envelopeId) async {
    if (envelopeId == null || envelopeId.trim() == '') {
      return false;
    }
    // auth
    await _auth();
    // set base url
    await _setBaseUrl();
    // create envelope
    var url = Uri.parse(
        '$_baseUrl/envelopes?envelope_ids=$envelopeId&folder_ids=sentitems');
    var response = await http.get(
      url,
      headers: getHeaders(),
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse.containsKey('envelopes')) {
        return true;
      }
      return false;
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<String> createEnvelope(EnvelopeDefinitionModel body) async {
    // auth
    await _auth();
    // set base url
    await _setBaseUrl();
    // create envelope
    var url = Uri.parse('$_baseUrl/envelopes');
    var response = await http.post(url,
        headers: getHeaders(), body: jsonEncode(body.toJson()));
    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse['envelopeId'];
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<String?> deleteEnvelope(String envelopeId) async {
    // auth
    await _auth();
    // set base url
    await _setBaseUrl();
    // move to recycle bin
    var url = Uri.parse('$_baseUrl/folders/recyclebin');
    var response = await http.put(url,
        headers: getHeaders(),
        body: jsonEncode({
          'envelopeIds': [envelopeId]
        }));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse['envelopes'][0]['envelopeId'];
    } else {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['errorCode'] != 'ENVELOPE_DOES_NOT_EXIST') {
        throw Exception(response.body);
      }
      return null;
    }
  }

  @override
  Future<String> getRecipientViewUrl(
      String envelopeId, RecipientViewRequestModel body) async {
    // auth
    await _auth();
    // set base url
    await _setBaseUrl();
    // get recipient view url
    var url = Uri.parse('$_baseUrl/envelopes/$envelopeId/views/recipient');
    var response = await http.post(url,
        headers: getHeaders(), body: jsonEncode(body.toJson()));
    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse['url'];
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<List<int>> getEnvelopeDocument(
      String envelopeId, String documentId) async {
    // auth
    await _auth();
    // set base url
    await _setBaseUrl();
    // get envelope documents
    var url =
        Uri.parse('$_baseUrl/envelopes/$envelopeId/documents/$documentId');
    var response = await http.get(url, headers: getHeaders());
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<bool> hasRecipientSigned(String envelopeId, String recipientId) async {
    if (recipientId.trim() == '') {
      return false;
    }
    // auth
    await _auth();
    // set base url
    await _setBaseUrl();
    // get envelope recipients status
    var url = Uri.parse('$_baseUrl/envelopes/$envelopeId/recipients');
    var response = await http.get(url, headers: getHeaders());
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse.containsKey('signers')) {
        var signers = jsonResponse['signers'] as List<dynamic>;
        if (signers.isEmpty) {
          return false;
        }
        for (var signer in signers) {
          if (signer['recipientId'] == recipientId) {
            return signer['status'] == 'completed';
          }
        }
      }
      return false;
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<bool> haveRecipientsSigned(
      String envelopeId, List<String> recipientIds) async {
    if (recipientIds.isEmpty) {
      return false;
    }
    // auth
    await _auth();
    // set base url
    await _setBaseUrl();
    // get envelope recipients status
    var url = Uri.parse('$_baseUrl/envelopes/$envelopeId/recipients');
    var response = await http.get(url, headers: getHeaders());
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse.containsKey('signers')) {
        var signers = jsonResponse['signers'] as List<dynamic>;
        for (var signer in signers) {
          if (recipientIds.contains(signer['recipientId'])) {
            if (signer['status'] != 'completed') {
              return false;
            }
          }
        }
        return true;
      }
      return false;
    } else {
      throw Exception(response.body);
    }
  }
}
