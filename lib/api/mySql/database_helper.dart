import 'package:amazmart/api/customer.dart';
import 'package:amazmart/api/mySql/card_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'cart_item.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cart_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart (
        productId TEXT PRIMARY KEY,
        productName TEXT,
        productImage TEXT,
        rating REAL,
        reviewCount INTEGER,
        salePrice INTEGER,
        regularPrice INTEGER,
        discount INTEGER,
        returnLabel TEXT,
        itemCount INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE address (
        id TEXT PRIMARY KEY,
        name TEXT,
        mobile TEXT,
        pincode TEXT,
        address TEXT,
        locality_Town TEXT,
        city_District TEXT,
        state TEXT,
        type TEXT,
        addressSelected INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE cards (
        cardNo TEXT PRIMARY KEY,
        name TEXT,
        expire TEXT,
        cvv TEXT,
        type TEXT,
        bg TEXT
      )
    ''');
  }
// cards items
  Future<void> insertCardItem(Cards i) async {
    final db = await database;
    await db.insert('cards', i.toJson() ,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

    Future<List<Cards>> getCardsItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cards');

    return List.generate(maps.length, (i) {
      return Cards.fromJson(maps[i]);
    });
  }
// address items
  Future<void> insertAddressItem(Address i) async {
    final db = await database;
    await db.insert('address', i.toJson() ,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

    Future<List<Address>> getAddressItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('address');
    print('Address Data $maps');

    return List.generate(maps.length, (i) {
      return Address.fromJson(maps[i]);
    });
  }

    Future<void> updateDefaultAddress(String Id, int selected) async {
    final db = await database;

    await db.update(
      'address',
      {'addressSelected': selected},
      where: 'id = ?',
      whereArgs: [Id],
    );
  }


// cart items 
  Future<void> insertCartItem(CartItem cartItem) async {
    final db = await database;
    await db.insert('cart', cartItem.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');

    return List.generate(maps.length, (i) {
      return CartItem.fromJson(maps[i]);
    });
  }

  Future<void> updateCartItem(String productId, int itemCount) async {
    final db = await database;

    await db.update(
      'cart',
      {'itemCount': itemCount},
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<void> removeCartItem(String productId) async {
    final db = await database;
    await db.delete(
      'cart',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }
}

class Address {
  String id;
  String name;
  String mobile;
  String pincode;
  String address;
  String localityTown;
  String cityDistrict;
  String state;
  String type;
  int addressSelected;

  Address({
    required this.id,
    required this.name,
    required this.mobile,
    required this.pincode,
    required this.address,
    required this.localityTown,
    required this.cityDistrict,
    required this.state,
    required this.type,
    required this.addressSelected,
  });

  // Convert Address object to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'pincode': pincode,
      'address': address,
      'locality_Town': localityTown,
      'city_District': cityDistrict,
      'state': state,
      'type': type,
      'addressSelected': addressSelected,
    };
  }

  // Create Address object from JSON (Map)
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
      pincode: json['pincode'],
      address: json['address'],
      localityTown: json['locality_Town'],
      cityDistrict: json['city_District'],
      state: json['state'],
      type: json['type'],
      addressSelected: json['addressSelected'],
    );
  }
}
