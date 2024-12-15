// Mocks generated by Mockito 5.4.4 from annotations
// in flutter_nasa_apod/test/src/features/apod/data/repositories/apod_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_nasa_apod/src/features/apod/data/datasources/local/apod_local_data_source.dart'
    as _i5;
import 'package:flutter_nasa_apod/src/features/apod/data/datasources/remote/apod_remote_data_source.dart'
    as _i3;
import 'package:flutter_nasa_apod/src/features/apod/data/models/apod_model.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeApodModel_0 extends _i1.SmartFake implements _i2.ApodModel {
  _FakeApodModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ApodRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockApodRemoteDataSource extends _i1.Mock
    implements _i3.ApodRemoteDataSource {
  MockApodRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.ApodModel> getApodByDate(DateTime? date) =>
      (super.noSuchMethod(
        Invocation.method(
          #getApodByDate,
          [date],
        ),
        returnValue: _i4.Future<_i2.ApodModel>.value(_FakeApodModel_0(
          this,
          Invocation.method(
            #getApodByDate,
            [date],
          ),
        )),
      ) as _i4.Future<_i2.ApodModel>);
}

/// A class which mocks [ApodLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockApodLocalDataSource extends _i1.Mock
    implements _i5.ApodLocalDataSource {
  MockApodLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> saveFavorite(_i2.ApodModel? apod) => (super.noSuchMethod(
        Invocation.method(
          #saveFavorite,
          [apod],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> removeFavorite(_i2.ApodModel? apod) => (super.noSuchMethod(
        Invocation.method(
          #removeFavorite,
          [apod],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<List<_i2.ApodModel>> getFavorites() => (super.noSuchMethod(
        Invocation.method(
          #getFavorites,
          [],
        ),
        returnValue: _i4.Future<List<_i2.ApodModel>>.value(<_i2.ApodModel>[]),
      ) as _i4.Future<List<_i2.ApodModel>>);

  @override
  _i4.Future<bool> isFavorite(_i2.ApodModel? apod) => (super.noSuchMethod(
        Invocation.method(
          #isFavorite,
          [apod],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
