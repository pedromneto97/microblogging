import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:microblogging/models/exceptions.dart';
import 'package:microblogging/utils/http_helper.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_helper_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  late final Client client;
  late final HttpHelper httpHelper;
  const url = 'http://test.com.br';

  setUpAll(() {
    client = MockClient();
    httpHelper = HttpHelper(client: client);
  });

  tearDown(() {
    reset(client);
  });

  test('Client', () {
    expect(
      httpHelper.client,
      client,
    );
  });

  test('get sucess', () async {
    const body = 'Teste';
    when(
      client.get(
        Uri.parse(url),
        headers: const {'Content-Type': 'application/json'},
      ),
    ).thenAnswer((realInvocation) async => Response(body, 200));

    final data = await httpHelper.get(url);

    expect(data, body);
  });

  test('Without internet connection', () async {
    when(
      client.get(
        Uri.parse(url),
        headers: const {'Content-Type': 'application/json'},
      ),
    ).thenThrow(
      const SocketException.closed(),
    );

    expect(
      () => httpHelper.get(url),
      throwsA(isA<NoInternet>()),
    );
  });

  test('Bad request', () async {
    const body = 'Teste';
    when(
      client.get(
        Uri.parse(url),
        headers: const {'Content-Type': 'application/json'},
      ),
    ).thenAnswer((realInvocation) async => Response(body, 400));

    expect(
      () => httpHelper.get(url),
      throwsA(isA<BadRequest>()),
    );
  });

  test('Server error', () async {
    const body = 'Teste';
    when(
      client.get(
        Uri.parse(url),
        headers: const {'Content-Type': 'application/json'},
      ),
    ).thenAnswer((realInvocation) async => Response(body, 500));

    expect(
      () => httpHelper.get(url),
      throwsA(isA<ServerError>()),
    );
  });
}
