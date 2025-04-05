const Map<String, String> charMap = {
  ':': '_c_',
  '/': '_s_',
  '.': '_d_',
  '-': '_h_',
  '?': '_q_',
  '=': '_e_',
  '&': '_a_',
  '%': '_p_',
};


/// Encode the URL using a custom mapping
String customEncode(String url) {
  String encodedUrl = url;
  charMap.forEach((key, value) {
    encodedUrl = encodedUrl.replaceAll(key, value);
  });
  return encodedUrl;
}

/// Decode the custom-encoded URL back to the original
String customDecode(String encodedUrl) {
  String decodedUrl = encodedUrl;
  charMap.forEach((key, value) {
    print("ForIT $key $value");
    decodedUrl = decodedUrl.replaceAll(value, key);
  });
  print("Decode $decodedUrl");
  return decodedUrl;
}

void main() {
  String originalUrl = 'https://clickcart.wprdx.com/demo/wp-content/uploads/2024/10/b4.png';
  
  // Encode
  String encodedUrl = customEncode(originalUrl);
  print('Encoded URL: $encodedUrl');
  
  // Decode
  String decodedUrl = customDecode(encodedUrl);
  print('Decoded URL: $decodedUrl');
}
