import 'package:either_dart/either.dart';
import '../../infrastructure/models/fill_style_get_all_model.dart';
import '../../infrastructure/models/fill_style_upsert_model.dart';
import '../../infrastructure/models/fill_style_delete_model.dart';
import '../entities/fill_style_get_all_param.dart';
import '../entities/fill_style_upsert_param.dart';
import '../entities/fill_style_delete_param.dart';

abstract class FillstyleRepository {
  Future<Either<String, FillStyleGetAllModel>> fillStyleGetAll({required FillStyleGetAllParam fillStyleGetAllParam});

  Future<Either<String, FillStyleUpsertModel>> fillStyleUpsert({required FillStyleUpsertParam fillStyleUpsertParam});

  Future<Either<String, FillStyleDeleteModel>> fillStyleDelete({required FillStyleDeleteParam fillStyleDeleteParam});

}
