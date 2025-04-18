import 'package:either_dart/either.dart';
import '../../infrastructure/models/general_general_search_model.dart';
import '../entities/general_general_search_param.dart';

abstract class GeneralRepository {
  Future<Either<String, GeneralGeneralSearchModel>> generalGeneralSearch({required GeneralGeneralSearchParam generalGeneralSearchParam});

}
