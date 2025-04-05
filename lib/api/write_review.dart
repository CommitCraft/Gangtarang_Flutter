import 'package:collection/collection.dart';

class WriteReview {
	int? productId;
	String? review;
	String? reviewer;
	String? reviewerEmail;
	int? rating;

	WriteReview({
		this.productId, 
		this.review, 
		this.reviewer, 
		this.reviewerEmail, 
		this.rating, 
	});

	factory WriteReview.fromJson(Map<String, Object?> json) => WriteReview(
				productId: json['product_id'] as int?,
				review: json['review'] as String?,
				reviewer: json['reviewer'] as String?,
				reviewerEmail: json['reviewer_email'] as String?,
				rating: json['rating'] as int?,
			);

	Map<String, Object?> toJson() => {
				'product_id': productId,
				'review': review,
				'reviewer': reviewer,
				'reviewer_email': reviewerEmail,
				'rating': rating,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! WriteReview) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			productId.hashCode ^
			review.hashCode ^
			reviewer.hashCode ^
			reviewerEmail.hashCode ^
			rating.hashCode;
}
