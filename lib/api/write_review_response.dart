import 'package:collection/collection.dart';

class WriteReviewResponse {
	int? id;
	String? dateCreated;
	String? dateCreatedGmt;
	int? productId;
	String? productName;
	String? productPermalink;
	String? status;
	String? reviewer;
	String? reviewerEmail;
	String? review;
	int? rating;
	bool? verified;

	WriteReviewResponse({
		this.id, 
		this.dateCreated, 
		this.dateCreatedGmt, 
		this.productId, 
		this.productName, 
		this.productPermalink, 
		this.status, 
		this.reviewer, 
		this.reviewerEmail, 
		this.review, 
		this.rating, 
		this.verified, 
	});

	factory WriteReviewResponse.fromJson(Map<String, Object?> json) {
		return WriteReviewResponse(
			id: json['id'] as int?,
			dateCreated: json['date_created'] as String?,
			dateCreatedGmt: json['date_created_gmt'] as String?,
			productId: json['product_id'] as int?,
			productName: json['product_name'] as String?,
			productPermalink: json['product_permalink'] as String?,
			status: json['status'] as String?,
			reviewer: json['reviewer'] as String?,
			reviewerEmail: json['reviewer_email'] as String?,
			review: json['review'] as String?,
			rating: json['rating'] as int?,
			verified: json['verified'] as bool?,
		);
	}



	Map<String, Object?> toJson() => {
				'id': id,
				'date_created': dateCreated,
				'date_created_gmt': dateCreatedGmt,
				'product_id': productId,
				'product_name': productName,
				'product_permalink': productPermalink,
				'status': status,
				'reviewer': reviewer,
				'reviewer_email': reviewerEmail,
				'review': review,
				'rating': rating,
				'verified': verified,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! WriteReviewResponse) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			id.hashCode ^
			dateCreated.hashCode ^
			dateCreatedGmt.hashCode ^
			productId.hashCode ^
			productName.hashCode ^
			productPermalink.hashCode ^
			status.hashCode ^
			reviewer.hashCode ^
			reviewerEmail.hashCode ^
			review.hashCode ^
			rating.hashCode ^
			verified.hashCode;
}
