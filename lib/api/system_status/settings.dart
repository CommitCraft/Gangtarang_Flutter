import 'package:collection/collection.dart';

class Settings {
	bool? apiEnabled;
	bool? forceSsl;
	String? currency;
	String? currencySymbol;
	String? currencyPosition;
	String? thousandSeparator;
	String? decimalSeparator;
	int? numberOfDecimals;
	bool? geolocationEnabled;

	String? woocommerceComConnected;
	bool? enforceApprovedDownloadDirs;
	String? orderDatastore;
	bool? hposEnabled;
	bool? hposSyncEnabled;

	Settings({
		this.apiEnabled, 
		this.forceSsl, 
		this.currency, 
		this.currencySymbol, 
		this.currencyPosition, 
		this.thousandSeparator, 
		this.decimalSeparator, 
		this.numberOfDecimals, 
		this.geolocationEnabled, 

		this.woocommerceComConnected, 
		this.enforceApprovedDownloadDirs, 
		this.orderDatastore, 
		this.hposEnabled, 
		this.hposSyncEnabled, 
	});

	factory Settings.fromJson(Map<String, Object?> json) => Settings(
				apiEnabled: json['api_enabled'] as bool?,
				forceSsl: json['force_ssl'] as bool?,
				currency: json['currency'] as String?,
				currencySymbol: json['currency_symbol'] as String?,
				currencyPosition: json['currency_position'] as String?,
				thousandSeparator: json['thousand_separator'] as String?,
				decimalSeparator: json['decimal_separator'] as String?,
				numberOfDecimals: json['number_of_decimals'] as int?,
				geolocationEnabled: json['geolocation_enabled'] as bool?,
	woocommerceComConnected: json['woocommerce_com_connected'] as String?,
				enforceApprovedDownloadDirs: json['enforce_approved_download_dirs'] as bool?,
				orderDatastore: json['order_datastore'] as String?,
				hposEnabled: json['HPOS_enabled'] as bool?,
				hposSyncEnabled: json['HPOS_sync_enabled'] as bool?,
			);

	Map<String, Object?> toJson() => {
				'api_enabled': apiEnabled,
				'force_ssl': forceSsl,
				'currency': currency,
				'currency_symbol': currencySymbol,
				'currency_position': currencyPosition,
				'thousand_separator': thousandSeparator,
				'decimal_separator': decimalSeparator,
				'number_of_decimals': numberOfDecimals,
				'geolocation_enabled': geolocationEnabled,

				'woocommerce_com_connected': woocommerceComConnected,
				'enforce_approved_download_dirs': enforceApprovedDownloadDirs,
				'order_datastore': orderDatastore,
				'HPOS_enabled': hposEnabled,
				'HPOS_sync_enabled': hposSyncEnabled,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Settings) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode =>
			apiEnabled.hashCode ^
			forceSsl.hashCode ^
			currency.hashCode ^
			currencySymbol.hashCode ^
			currencyPosition.hashCode ^
			thousandSeparator.hashCode ^
			decimalSeparator.hashCode ^
			numberOfDecimals.hashCode ^
			geolocationEnabled.hashCode ^
	
			woocommerceComConnected.hashCode ^
			enforceApprovedDownloadDirs.hashCode ^
			orderDatastore.hashCode ^
			hposEnabled.hashCode ^
			hposSyncEnabled.hashCode;
}
