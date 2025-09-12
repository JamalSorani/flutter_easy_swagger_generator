import 'dart:io';

/// A generator class that creates result handling utilities for Flutter applications.
///
/// This class generates three main components:
/// 1. A generic `Result<T>` class for handling operation states (init, loading, loaded, error)
/// 2. A `ResultBuilder` widget for building UI based on result states
/// 3. Freezed model classes for the Result type
///
/// The generated code follows best practices for state management in Flutter applications.
class ResultBuilderGenerator {
  /// The main path where the generated files will be created.
  ///
  /// This path is used to determine the correct location for the generated files,
  /// with special handling for example projects.
  final String mainPath;

  /// Creates a new instance of [ResultBuilderGenerator].
  ///
  /// [mainPath] The root path where the generated files should be created.
  ResultBuilderGenerator({required this.mainPath});

  /// Generates all result builder related files.
  ///
  /// This method generates:
  /// - result.dart: Contains the base Result class and extensions
  /// - result_builder.dart: Contains the ResultBuilder widget
  /// - result.freezed.dart: Generated file with Freezed models
  void generateResultBuilder() {
    _generateResult();
    _generateResultBuilder();
    _generateResultFreezed();
  }

  /// Generates the base Result class and its extensions.
  ///
  /// Creates a file at `lib/core/result_builder/result.dart` containing:
  /// - A generic `Result<T>` class with states: init, loading, loaded, and error
  /// - Extension methods for convenient state checking
  void _generateResult() {
    final buffer = StringBuffer();
    buffer.writeln(
      """
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _\$Result<T> {
  const factory Result.init() = _init<T>;

  const factory Result.loading() = _Lodaing<T>;

  const factory Result.loaded({required T data}) = _Loaded<T>;

  const factory Result.error({required String error}) = _Error<T>;
}

extension ResultExtension<T> on Result<T> {
  bool isLoading() => maybeWhen(orElse: () => false, loading: () => true);

  bool isLoaded() => maybeWhen(orElse: () => false, loaded: (data) => true);

  bool isInit() => maybeWhen(orElse: () => false, init: () => true);

  bool isError() => maybeWhen(orElse: () => false, error: (error) => true);

  T? getDataWhenSuccess() =>
      maybeWhen(orElse: () => null, loaded: (data) => data);

  String? get error => maybeWhen(
        orElse: () {
          return null;
        },
        error: (error) {
          return error;
        },
      );
}

""",
    );
    String filePath =
        "${mainPath.contains("example") ? "example/" : ""}lib/core/result_builder/result.dart";
    final file = File(filePath);
    if (!file.existsSync()) {
      file.parent.createSync(recursive: true);
      file.writeAsStringSync(buffer.toString());
    }
  }

  /// Generates the ResultBuilder widget.
  ///
  /// Creates a file at `lib/core/result_builder/result_builder.dart` containing:
  /// - A `ResultBuilder<T>` widget that builds different UIs based on result state
  /// - Default loading and init states with customizable overrides
  void _generateResultBuilder() {
    final buffer = StringBuffer();
    buffer.writeln("""
import 'result.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ResultBuilder<T> extends StatelessWidget {
  ResultBuilder({
    super.key,
    required this.success,
    this.loading,
    this.onError,
    this.init,
    required this.result,
  });

  final Result<T> result;
  Widget Function()? loading;
  final Widget Function(T data) success;
  final Function()? onError;
  Widget Function()? init;

  @override
  Widget build(BuildContext context) {
    Widget? next;

    loading ??= () => const Center(
          child: CircularProgressIndicator(),
        );
    init ??= () => const SizedBox();
    result.when(
      init: () => next = const SizedBox(),
      loading: () => next = loading!(),
      loaded: (data) => next = success(data),
      error: (message) => onError != null
          ? {
              next = const SizedBox(),
            }
          : const SizedBox.shrink(),
    );
    return next ?? const SizedBox();
  }
}
""");

    String filePath =
        "${mainPath.contains("example") ? "example/" : ""}lib/core/result_builder/result_builder.dart";
    final file = File(filePath);
    if (!file.existsSync()) {
      file.parent.createSync(recursive: true);
      file.writeAsStringSync(buffer.toString());
    }
  }

  /// Generates the Freezed model classes for the Result type.
  ///
  /// Creates a file at `lib/core/result_builder/result.freezed.dart` containing:
  /// - Freezed model definitions for all Result states
  /// - Required mixins and utilities for the Freezed implementation
  void _generateResultFreezed() {
    final buffer = StringBuffer();
    buffer.writeln("""
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _\$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    '''It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models''');

/// @nodoc
mixin _\$Result<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_init<T> value) init,
    required TResult Function(_Lodaing<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_Error<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_init<T> value)? init,
    TResult? Function(_Lodaing<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_Error<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_init<T> value)? init,
    TResult Function(_Lodaing<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class \$ResultCopyWith<T, \$Res> {
  factory \$ResultCopyWith(Result<T> value, \$Res Function(Result<T>) then) =
      _\$ResultCopyWithImpl<T, \$Res, Result<T>>;
}

/// @nodoc
class _\$ResultCopyWithImpl<T, \$Res, \$Val extends Result<T>>
    implements \$ResultCopyWith<T, \$Res> {
  _\$ResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final \$Val _value;
  // ignore: unused_field
  final \$Res Function(\$Val) _then;

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _\$\$initImplCopyWith<T, \$Res> {
  factory _\$\$initImplCopyWith(
          _\$initImpl<T> value, \$Res Function(_\$initImpl<T>) then) =
      __\$\$initImplCopyWithImpl<T, \$Res>;
}

/// @nodoc
class __\$\$initImplCopyWithImpl<T, \$Res>
    extends _\$ResultCopyWithImpl<T, \$Res, _\$initImpl<T>>
    implements _\$\$initImplCopyWith<T, \$Res> {
  __\$\$initImplCopyWithImpl(
      _\$initImpl<T> _value, \$Res Function(_\$initImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _\$initImpl<T> implements _init<T> {
  const _\$initImpl();

  @override
  String toString() {
    return 'Result<\$T>.init()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _\$initImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_init<T> value) init,
    required TResult Function(_Lodaing<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_Error<T> value) error,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_init<T> value)? init,
    TResult? Function(_Lodaing<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_Error<T> value)? error,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_init<T> value)? init,
    TResult Function(_Lodaing<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class _init<T> implements Result<T> {
  const factory _init() = _\$initImpl<T>;
}

/// @nodoc
abstract class _\$\$LodaingImplCopyWith<T, \$Res> {
  factory _\$\$LodaingImplCopyWith(
          _\$LodaingImpl<T> value, \$Res Function(_\$LodaingImpl<T>) then) =
      __\$\$LodaingImplCopyWithImpl<T, \$Res>;
}

/// @nodoc
class __\$\$LodaingImplCopyWithImpl<T, \$Res>
    extends _\$ResultCopyWithImpl<T, \$Res, _\$LodaingImpl<T>>
    implements _\$\$LodaingImplCopyWith<T, \$Res> {
  __\$\$LodaingImplCopyWithImpl(
      _\$LodaingImpl<T> _value, \$Res Function(_\$LodaingImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _\$LodaingImpl<T> implements _Lodaing<T> {
  const _\$LodaingImpl();

  @override
  String toString() {
    return 'Result<\$T>.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _\$LodaingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_init<T> value) init,
    required TResult Function(_Lodaing<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_Error<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_init<T> value)? init,
    TResult? Function(_Lodaing<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_Error<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_init<T> value)? init,
    TResult Function(_Lodaing<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Lodaing<T> implements Result<T> {
  const factory _Lodaing() = _\$LodaingImpl<T>;
}

/// @nodoc
abstract class _\$\$LoadedImplCopyWith<T, \$Res> {
  factory _\$\$LoadedImplCopyWith(
          _\$LoadedImpl<T> value, \$Res Function(_\$LoadedImpl<T>) then) =
      __\$\$LoadedImplCopyWithImpl<T, \$Res>;
  @useResult
  \$Res call({T data});
}

/// @nodoc
class __\$\$LoadedImplCopyWithImpl<T, \$Res>
    extends _\$ResultCopyWithImpl<T, \$Res, _\$LoadedImpl<T>>
    implements _\$\$LoadedImplCopyWith<T, \$Res> {
  __\$\$LoadedImplCopyWithImpl(
      _\$LoadedImpl<T> _value, \$Res Function(_\$LoadedImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  \$Res call({
    Object? data = freezed,
  }) {
    return _then(_\$LoadedImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _\$LoadedImpl<T> implements _Loaded<T> {
  const _\$LoadedImpl({required this.data});

  @override
  final T data;

  @override
  String toString() {
    return 'Result<\$T>.loaded(data: \$data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _\$LoadedImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _\$\$LoadedImplCopyWith<T, _\$LoadedImpl<T>> get copyWith =>
      __\$\$LoadedImplCopyWithImpl<T, _\$LoadedImpl<T>>(this, _\$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_init<T> value) init,
    required TResult Function(_Lodaing<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_Error<T> value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_init<T> value)? init,
    TResult? Function(_Lodaing<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_Error<T> value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_init<T> value)? init,
    TResult Function(_Lodaing<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded<T> implements Result<T> {
  const factory _Loaded({required final T data}) = _\$LoadedImpl<T>;

  T get data;

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _\$\$LoadedImplCopyWith<T, _\$LoadedImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _\$\$ErrorImplCopyWith<T, \$Res> {
  factory _\$\$ErrorImplCopyWith(
          _\$ErrorImpl<T> value, \$Res Function(_\$ErrorImpl<T>) then) =
      __\$\$ErrorImplCopyWithImpl<T, \$Res>;
  @useResult
  \$Res call({String error});
}

/// @nodoc
class __\$\$ErrorImplCopyWithImpl<T, \$Res>
    extends _\$ResultCopyWithImpl<T, \$Res, _\$ErrorImpl<T>>
    implements _\$\$ErrorImplCopyWith<T, \$Res> {
  __\$\$ErrorImplCopyWithImpl(
      _\$ErrorImpl<T> _value, \$Res Function(_\$ErrorImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  \$Res call({
    Object? error = null,
  }) {
    return _then(_\$ErrorImpl<T>(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _\$ErrorImpl<T> implements _Error<T> {
  const _\$ErrorImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'Result<\$T>.error(error: \$error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _\$ErrorImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _\$\$ErrorImplCopyWith<T, _\$ErrorImpl<T>> get copyWith =>
      __\$\$ErrorImplCopyWithImpl<T, _\$ErrorImpl<T>>(this, _\$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(T data) loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? loading,
    TResult? Function(T data)? loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(T data)? loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_init<T> value) init,
    required TResult Function(_Lodaing<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_Error<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_init<T> value)? init,
    TResult? Function(_Lodaing<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_Error<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_init<T> value)? init,
    TResult Function(_Lodaing<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error<T> implements Result<T> {
  const factory _Error({required final String error}) = _\$ErrorImpl<T>;

  String get error;

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _\$\$ErrorImplCopyWith<T, _\$ErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
""");

    String filePath =
        "${mainPath.contains("example") ? "example/" : ""}lib/core/result_builder/result.freezed.dart";
    File file = File(filePath);
    if (!file.existsSync()) {
      file.parent.createSync(recursive: true);
      file.writeAsStringSync(buffer.toString());
    }
  }
}
