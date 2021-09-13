import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_app/core/service/api_client.dart';
import 'package:weather_app/core/service/models/location.dart';

class MockDioClient extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  group('Api client', () {
    late Dio dio;
    late APIClient apiClient;

    setUp(() {
      dio = MockDioClient();
      apiClient = APIClient(dio: dio);
    });

    group('constructor', () {
      test('does not require an dio', () {
        expect(APIClient(), isNotNull);
      });
    });

    group('locationSearch', () {
      const query = 'mock-query';
      test('makes correct http request', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn('[]');
        when(() => dio.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.locationSearch(query);
        } catch (_) {}
        verify(
          () => dio.get('www.metaweather.com/api/location/search',
              queryParameters: <String, String>{'query': query}),
        ).called(1);
      });

      test('throws LocationIdRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => dio.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await apiClient.locationSearch(query),
          throwsA(isA<LocationIdRequestFailure>()),
        );
      });

      test('throws LocationNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn('[]');
        when(() => dio.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.locationSearch(query),
          throwsA(isA<LocationNotFoundFailure>()),
        );
      });

      test('returns Location on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn(
          '''[{
            "title": "mock-title",
            "location_type": "City",
            "latt_long": "-34.75,83.28",
            "woeid": 42
          }]''',
        );
        when(() => dio.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.locationSearch(query);
        expect(
          actual,
          isA<Location>()
              .having((l) => l.title, 'title', 'mock-title')
              .having((l) => l.locationType, 'type', LocationType.city)
              .having(
                (l) => l.latLng,
                'latLng',
                isA<LatLng>()
                    .having((c) => c.latitude, 'latitude', -34.75)
                    .having((c) => c.longitude, 'longitude', 83.28),
              )
              .having((l) => l.woeid, 'woeid', 42),
        );
      });
    });
  });
}
