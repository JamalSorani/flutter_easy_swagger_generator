part of 'package_bloc.dart';

abstract class PackageEvent {}

class PackageGetAllEvent extends PackageEvent {
  final PackageGetAllParam packageGetAllParam;

  PackageGetAllEvent({required this.packageGetAllParam});
}

class PackageGetByIdEvent extends PackageEvent {
  final PackageGetByIdParam packageGetByIdParam;

  PackageGetByIdEvent({required this.packageGetByIdParam});
}

