
class CategoryDeleteParam {
  final String id;
  CategoryDeleteParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
    };
  }

}
