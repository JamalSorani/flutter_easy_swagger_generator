part of 'package_bloc.dart';

class PackageState {
  Result<PackageGetAllModel> packageGetAllState;
  Result<PackageGetByIdModel> packageGetByIdState;

  PackageState({
    this.packageGetAllState = const Result.init(),
    this.packageGetByIdState = const Result.init(),
  });

  PackageState copyWith({
    Result<PackageGetAllModel>? packageGetAllState,
    Result<PackageGetByIdModel>? packageGetByIdState,
  }) {
    return PackageState(
      packageGetAllState: packageGetAllState ?? this.packageGetAllState,
      packageGetByIdState: packageGetByIdState ?? this.packageGetByIdState,
    );
  }
}
