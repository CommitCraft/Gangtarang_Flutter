import 'package:collection/collection.dart';


import 'settings.dart';

class SystemStatus {
	Settings? settings;


	SystemStatus({
		this.settings, 

	});

	factory SystemStatus.fromJson(Map<String, Object?> json) => SystemStatus(
				settings: json['settings'] == null
						? null
						: Settings.fromJson(json['settings']! as Map<String, Object?>),
			);

	Map<String, Object?> toJson() => {
				'settings': settings?.toJson(),
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! SystemStatus) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => settings.hashCode;
}
