import 'package:inject/inject.dart';
import 'package:masterstudy_app/data/models/ReviewAddResponse.dart';
import 'package:masterstudy_app/data/models/ReviewResponse.dart';
import 'package:masterstudy_app/data/network/api_provider.dart';

abstract class ReviewRepository {
    Future<ReviewResponse> getReviews(int id);
    Future<ReviewAddResponse> addReview(int id, int mark, String review);
}

@provide
class ReviewRepositoryImpl extends ReviewRepository {
    final UserApiProvider apiProvider;

    ReviewRepositoryImpl(this.apiProvider);

    @override
    Future<ReviewResponse> getReviews(int id) {
        return apiProvider.getReviews(id);
    }

    @override
    Future<ReviewAddResponse> addReview(int id, int mark, String review) {
        return apiProvider.addReviews(id, mark, review);
    }
}