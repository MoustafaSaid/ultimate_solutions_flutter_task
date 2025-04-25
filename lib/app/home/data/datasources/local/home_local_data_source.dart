import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/models/bill_model.dart';
import 'package:ultimate_solution_flutter_task/app/home/data/models/delivery_status_model.dart';
import 'package:ultimate_solution_flutter_task/core/error/exceptions.dart';

abstract class HomeLocalDataSource {
  Future<List<BillModel>> getCachedBills();
  Future<void> cacheBills(List<BillModel> bills);
  Future<List<DeliveryStatusModel>> getCachedDeliveryStatuses();
  Future<void> cacheDeliveryStatuses(List<DeliveryStatusModel> statuses);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final Database database;

  HomeLocalDataSourceImpl({required this.database});

  static Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'delivery_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create bills table
        await db.execute(
          '''
          CREATE TABLE bills(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            billType TEXT,
            billNo TEXT,
            billSerial TEXT,
            billDate TEXT,
            billTime TEXT,
            billAmount TEXT,
            taxAmount TEXT,
            deliveryAmount TEXT,
            mobileNo TEXT,
            customerName TEXT,
            regionName TEXT,
            buildingNo TEXT,
            floorNo TEXT,
            apartmentNo TEXT,
            address TEXT,
            latitude TEXT,
            longitude TEXT,
            deliveryStatusFlag TEXT,
            deliveryStatusName TEXT
          )
          ''',
        );

        // Create delivery status table
        await db.execute(
          '''
          CREATE TABLE delivery_statuses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            typeNo TEXT,
            typeName TEXT
          )
          ''',
        );
      },
    );
  }

  @override
  Future<void> cacheBills(List<BillModel> bills) async {
    try {
      // Clear the current bills
      await database.delete('bills');

      // Insert all bills
      for (var bill in bills) {
        await database.insert(
          'bills',
          {
            'billType': bill.billType,
            'billNo': bill.billNo,
            'billSerial': bill.billSerial,
            'billDate': bill.billDate,
            'billTime': bill.billTime,
            'billAmount': bill.billAmount,
            'taxAmount': bill.taxAmount,
            'deliveryAmount': bill.deliveryAmount,
            'mobileNo': bill.mobileNo,
            'customerName': bill.customerName,
            'regionName': bill.regionName,
            'buildingNo': bill.buildingNo,
            'floorNo': bill.floorNo,
            'apartmentNo': bill.apartmentNo,
            'address': bill.address,
            'latitude': bill.latitude,
            'longitude': bill.longitude,
            'deliveryStatusFlag': bill.deliveryStatusFlag,
            'deliveryStatusName': bill.deliveryStatusName,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<List<BillModel>> getCachedBills() async {
    try {
      final List<Map<String, dynamic>> maps = await database.query('bills');

      if (maps.isEmpty) {
        return [];
      }

      return List.generate(maps.length, (i) {
        return BillModel(
          billType: maps[i]['billType'],
          billNo: maps[i]['billNo'],
          billSerial: maps[i]['billSerial'],
          billDate: maps[i]['billDate'],
          billTime: maps[i]['billTime'],
          billAmount: maps[i]['billAmount'],
          taxAmount: maps[i]['taxAmount'],
          deliveryAmount: maps[i]['deliveryAmount'],
          mobileNo: maps[i]['mobileNo'],
          customerName: maps[i]['customerName'],
          regionName: maps[i]['regionName'],
          buildingNo: maps[i]['buildingNo'],
          floorNo: maps[i]['floorNo'],
          apartmentNo: maps[i]['apartmentNo'],
          address: maps[i]['address'],
          latitude: maps[i]['latitude'],
          longitude: maps[i]['longitude'],
          deliveryStatusFlag: maps[i]['deliveryStatusFlag'],
          deliveryStatusName: maps[i]['deliveryStatusName'],
        );
      });
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> cacheDeliveryStatuses(List<DeliveryStatusModel> statuses) async {
    try {
      // Clear the current statuses
      await database.delete('delivery_statuses');

      // Insert all statuses
      for (var status in statuses) {
        await database.insert(
          'delivery_statuses',
          {
            'typeNo': status.typeNo,
            'typeName': status.typeName,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<List<DeliveryStatusModel>> getCachedDeliveryStatuses() async {
    try {
      final List<Map<String, dynamic>> maps =
          await database.query('delivery_statuses');

      if (maps.isEmpty) {
        return [];
      }

      return List.generate(maps.length, (i) {
        return DeliveryStatusModel(
          typeNo: maps[i]['typeNo'],
          typeName: maps[i]['typeName'],
        );
      });
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
