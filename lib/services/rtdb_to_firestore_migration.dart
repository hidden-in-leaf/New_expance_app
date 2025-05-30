// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../models/transaction_model.dart';
// import 'firestore_service.dart';
// import 'utilitis.dart';

// Future<void> migrateDataToFirestore() async {
//   final _firestore = FirebaseFirestore.instance;
//   final _firestoreService = FirestoreService();
//   final _user = FirebaseAuth.instance.currentUser;

//   final Map<String, String> localCategories = {}; // categoryName -> categoryId

//   int batchSize = 0;
//   WriteBatch batch = _firestore.batch();

//   for (var entry in data.entries) {
//     final value = entry.value;
//     final rawCategory = value['category']?.toString().trim() ?? 'General';
//     final categoryName = rawCategory.isEmpty ? 'General' : rawCategory;

//     // Create category if not already added
//     String categoryId;
//     if (localCategories.containsKey(categoryName)) {
//       categoryId = localCategories[categoryName]!;
//     } else {
//       categoryId = await _firestoreService.addCategory(_user!.uid, categoryName);
//       localCategories[categoryName] = categoryId;
//     }

//     // Prepare TransactionModel
//     final tx = TransactionModel(
//       id: '',
//       amount: double.parse(value['Cost'].toString()),
//       categoryId: categoryId,
//       description: value['description'].toString(),
//       type: 'expense',
//       date: DateTime.fromMillisecondsSinceEpoch(
//         int.parse(value['timeStamp'].toString()),
//       ),
//     );

//     // Prepare document reference
//     final docRef = _firestore
//         .collection('users')
//         .doc(_user!.uid)
//         .collection('transactions')
//         .doc(); // auto ID

//     batch.set(docRef, tx.toMap());
//     batchSize++;

//     // Commit every 500 writes
//     if (batchSize == 1000) {
//       await batch.commit();
//       print('Committed 1000 records.');
//       batch = _firestore.batch();
//       batchSize = 0;
//     }
//   }

//   // Commit remaining if any
//   if (batchSize > 0) {
//     await batch.commit();
//     print('Committed final $batchSize records.');
//   }

//   print('Data migration completed successfully.');
// }



// // Future<void> migrateDataToFirestore() async {
// //   final _firestoreService = FirestoreService();

// //   final _user = FirebaseAuth.instance.currentUser;
// //   await Future.forEach(data.entries, (entry) async {
// //     final value = entry.value;

// //     if (!globalCategories.values.contains(value['category'].toString())) {
// //       final newCategoryId = await _firestoreService.addCategory(
// //         _user!.uid,
// //         value['category'].toString(),
// //       );

// //       globalCategories[newCategoryId] = value['category'].toString();
// //     }

// //     final tx = TransactionModel(
// //       id: '',
// //       amount: double.parse(value['Cost'].toString()),
// //       categoryId: globalCategories.keys.firstWhere(
// //         (k) => globalCategories[k] == value['category'].toString(),
// //         orElse: () => '',
// //       ),
// //       description: value['description'].toString(),
// //       type: 'expense',
// //       date: DateTime.fromMillisecondsSinceEpoch(
// //         int.parse(value['timeStamp'].toString()),
// //       ),
// //     );

// //     print(tx.toMap());
// //     print('\n\n\n');

// //     await _firestoreService.addTransaction(_user!.uid, tx);
// //   });
// //   print('Data migration completed successfully.');
// // }

// var data = {
//   "-NCW-ZJhA0Whwjv0Vyk5": {
//     "Cost": "100",
//     "dateTime": "2022-09-21 22_34_42.283166",
//     "description": "petrol",
//     "timeStamp": 1663779882285,
//     "category": "General"
//   },
//   "-NCW-dHGQ55KxwRq4Ta5": {
//     "Cost": "60",
//     "dateTime": "2022-09-21 22_35_02.609352",
//     "description": "chips",
//     "timeStamp": 1663779902610,
//     "category": "General"
//   },
//   "-NCW-gXaKIY_pbWSKwHP": {
//     "Cost": "70",
//     "dateTime": "2022-09-21 22_35_15.942168",
//     "description": "medical",
//     "timeStamp": 1663779915942,
//     "category": "General"
//   },
//   "-NCW-jsFYfIC7w3Ps65z": {
//     "Cost": "2000",
//     "dateTime": "2022-09-21 22_35_29.616409",
//     "description": "aai + bappa",
//     "timeStamp": 1663779929616,
//     "category": "General"
//   },
//   "-NCW-qPEXXa9tE_TCGM1": {
//     "Cost": "77",
//     "dateTime": "2022-09-21 22_35_56.367256",
//     "description": "tak icecream",
//     "timeStamp": 1663779956367,
//     "category": "General"
//   },
//   "-NCYR5FzfPdIOAxtr1dg": {
//     "Cost": "120",
//     "dateTime": "2022-09-22 09_54_13.630329",
//     "description": "nasta dhosa",
//     "timeStamp": 1663820653631,
//     "category": "General"
//   },
//   "-NCc_oDbd4qbsftgUSSa": {
//     "Cost": "80",
//     "dateTime": "2022-09-23 09_54_47.268816",
//     "description": "nasta",
//     "timeStamp": 1663907087271,
//     "category": "General"
//   },
//   "-NCfQ8DmdpyD_fHdY0BK": {
//     "Cost": "45",
//     "dateTime": "2022-09-23 23_07_01.361087",
//     "description": "icecream",
//     "timeStamp": 1663954621363,
//     "category": "General"
//   },
//   "-NCjteDj-EwdqH6OumMD": {
//     "Cost": "400.0",
//     "category": "Oasiz",
//     "dateTime": "2022-09-24 19_58_49.710759",
//     "description": "micro solder ",
//     "timeStamp": 1664029729711
//   },
//   "-NCkadb7L8sJuENC_bL6": {
//     "Cost": "6",
//     "dateTime": "2022-09-24 23_15_23.654994",
//     "description": "chapati",
//     "timeStamp": 1664041523656,
//     "category": "General"
//   },
//   "-NCkb4cuf-mM-poAfpn-": {
//     "Cost": "90",
//     "dateTime": "2022-09-24 23_17_18.457877",
//     "description": "ragda patic ghri",
//     "timeStamp": 1664041638458,
//     "category": "General"
//   },
//   "-NCnCEJo11RrXDLlCZSv": {
//     "Cost": "48",
//     "dateTime": "2022-09-25 11_23_14.034714",
//     "description": "chaha",
//     "timeStamp": 1664085194036,
//     "category": "General"
//   },
//   "-NCpFDGd31uQrxIw5vbW": {
//     "Cost": "100",
//     "dateTime": "2022-09-25 20_55_30.601268",
//     "description": "petrol kp waterfall",
//     "timeStamp": 1664119530601,
//     "category": "General"
//   },
//   "-NCtlGDmPZR_ITR0Eciw": {
//     "Cost": "7000.0",
//     "category": "Pop",
//     "dateTime": "2022-09-26 17_58_22.320218",
//     "description": "pappa ",
//     "timeStamp": 1664195302322
//   },
//   "-NCubJihoJeiJGxGT-dS": {
//     "Cost": "650",
//     "dateTime": "2022-09-26 21_54_32.427887",
//     "description": "khandi trek ",
//     "timeStamp": 1664209472429,
//     "category": "General"
//   },
//   "-NCyGFJQlgWtAOSiMVLt": {
//     "Cost": "1000.0",
//     "category": "Pop",
//     "dateTime": "2022-09-27 14_56_36.059128",
//     "description": "pappa",
//     "timeStamp": 1664270796059
//   },
//   "-ND1XrasJiCmyXI_9EIL": {
//     "Cost": "867",
//     "dateTime": "2022-09-28 10_52_02.293803",
//     "description": "tshirt pant ",
//     "timeStamp": 1664342522296,
//     "category": "General"
//   },
//   "-ND3kP2H0hsEYcYg27ey": {
//     "Cost": "80",
//     "dateTime": "2022-09-28 21_10_25.679992",
//     "description": "paneer",
//     "timeStamp": 1664379625682,
//     "category": "General"
//   },
//   "-ND3kRYIqPEeaAsfQf8u": {
//     "Cost": "10",
//     "dateTime": "2022-09-28 21_10_35.923218",
//     "description": "dok dukhi goli ",
//     "timeStamp": 1664379635924,
//     "category": "General"
//   },
//   "-NDDaNCUtJCUfIdaVrf8": {
//     "Cost": "30",
//     "dateTime": "2022-09-30 19_02_48.861874",
//     "description": "chaha",
//     "timeStamp": 1664544768863,
//     "category": "General"
//   },
//   "-NDGiA-EeQMP6X8ys77s": {
//     "Cost": "179",
//     "dateTime": "2022-10-01 09_35_43.566476",
//     "description": "vaibhav recharge",
//     "timeStamp": 1664597143568,
//     "category": "General"
//   },
//   "-NDNx2Phceb1ZPuuOYyX": {
//     "Cost": "145",
//     "dateTime": "2022-10-02 19_18_05.164357",
//     "description": "ramdara jevn ",
//     "timeStamp": 1664718485165,
//     "category": "General"
//   },
//   "-NDTZap5PQxbXoBf6Cq1": {
//     "Cost": "250",
//     "dateTime": "2022-10-03 21_28_59.908970",
//     "description": "petrol kataldhara",
//     "timeStamp": 1664812739910,
//     "category": "General"
//   },
//   "-NDTdZxNuBd43K4IJeCW": {
//     "Cost": "120",
//     "dateTime": "2022-10-03 21_50_42.966386",
//     "description": "dandya",
//     "timeStamp": 1664814042968,
//     "category": "General"
//   },
//   "-NDi-bmtl51ay4w9v7nG": {
//     "Cost": "103",
//     "dateTime": "2022-10-06 21_25_42.136612",
//     "description": "misal",
//     "timeStamp": 1665071742137,
//     "category": "General"
//   },
//   "-NDi-fFCAxvv4vsw10yx": {
//     "Cost": "408",
//     "dateTime": "2022-10-06 21_25_56.301020",
//     "description": "dmart",
//     "timeStamp": 1665071756301,
//     "category": "General"
//   },
//   "-NDi-gv_cKrWkcJxbGNB": {
//     "Cost": "260",
//     "dateTime": "2022-10-06 21_26_03.172324",
//     "description": "farsan",
//     "timeStamp": 1665071763173,
//     "category": "General"
//   },
//   "-NDi6iPmIWPh52K3tIRF": {
//     "Cost": "179",
//     "dateTime": "2022-10-06 21_56_44.273594",
//     "description": "aai recharge",
//     "timeStamp": 1665073604274,
//     "category": "General"
//   },
//   "-NDsmbD5W3JFQFvY5kid": {
//     "Cost": "3594",
//     "dateTime": "2022-10-08 23_40_19.141168",
//     "description": "kapde zudio",
//     "timeStamp": 1665252619142,
//     "category": "General"
//   },
//   "-NDsmeIcd-0Gzpq1OeJ8": {
//     "Cost": "1650",
//     "dateTime": "2022-10-08 23_40_31.783410",
//     "description": "kapde sangvi",
//     "timeStamp": 1665252631784,
//     "category": "General"
//   },
//   "-NDvKQKxguAIweTcm0TR": {
//     "Cost": "160",
//     "dateTime": "2022-10-09 11_31_39.964478",
//     "description": "spanner",
//     "timeStamp": 1665295299965,
//     "category": "General"
//   },
//   "-NDvKSu7T8tCQ-07ydxH": {
//     "Cost": "580",
//     "dateTime": "2022-10-09 11_31_50.471469",
//     "description": "wifi recharge",
//     "timeStamp": 1665295310472,
//     "category": "General"
//   },
//   "-NDwDMdODN730SPA6eAr": {
//     "Cost": "60",
//     "dateTime": "2022-10-09 15_40_27.031154",
//     "description": "cock and pani go carting",
//     "timeStamp": 1665310227033,
//     "category": "General"
//   },
//   "-NDwDVyPozhBsxV3EZPx": {
//     "Cost": "1400",
//     "dateTime": "2022-10-09 15_41_05.241922",
//     "description": "go cart mi + shubhya",
//     "timeStamp": 1665310265242,
//     "category": "General"
//   },
//   "-NDy1PkQSsq0sofl_Idz": {
//     "Cost": "288",
//     "dateTime": "2022-10-10 00_07_28.473178",
//     "description": "eye care",
//     "timeStamp": 1665340648476,
//     "category": "General"
//   },
//   "-NE03V-JeGE2yRMa3gq-": {
//     "Cost": "80",
//     "dateTime": "2022-10-10 14_15_25.907087",
//     "description": "pulav",
//     "timeStamp": 1665391525908,
//     "category": "General"
//   },
//   "-NE07lYww0QAxyH3BKGn": {
//     "Cost": "20",
//     "dateTime": "2022-10-10 14_34_06.395825",
//     "description": "chips",
//     "timeStamp": 1665392646396,
//     "category": "General"
//   },
//   "-NEBYOqohZ0kmIfWIA5H": {
//     "Cost": "100",
//     "dateTime": "2022-10-12 19_46_16.563171",
//     "description": "petrol",
//     "timeStamp": 1665584176564,
//     "category": "General"
//   },
//   "-NEMheZGBFUEzeqVm6-b": {
//     "Cost": "20.0",
//     "category": "West",
//     "dateTime": "2022-10-14 23_46_55.824657",
//     "description": "\ud83c\udf7f",
//     "timeStamp": 1665771415826
//   },
//   "-NEOvc-lj66eF84UP3Tc": {
//     "Cost": "11050.0",
//     "category": "Bhishi",
//     "dateTime": "2022-10-15 10_07_09.807863",
//     "description": "bhishi",
//     "timeStamp": 1665808629809
//   },
//   "-NEQG2xoxttaISNnYRoz": {
//     "Cost": "1070.0",
//     "category": "Pop",
//     "dateTime": "2022-10-15 16_20_26.546557",
//     "description": "gas cylinder",
//     "timeStamp": 1665831026548
//   },
//   "-NEQtaO2wZsSGPoSVfxv": {
//     "Cost": "32.0",
//     "category": "West",
//     "dateTime": "2022-10-15 19_17_33.312936",
//     "description": "ots",
//     "timeStamp": 1665841653315
//   },
//   "-NEQvPh6brMTj0fwWRv5": {
//     "Cost": "6010.0",
//     "category": "Pop",
//     "dateTime": "2022-10-15 19_25_29.732725",
//     "description": "sadya 4000",
//     "timeStamp": 1665842129736
//   },
//   "-NERaaHw4fJVS3HC1_zp": {
//     "Cost": "100",
//     "dateTime": "2022-10-15 22_34_09.404089",
//     "description": "petrol",
//     "timeStamp": 1665853449404,
//     "category": "General"
//   },
//   "-NE_ikzQWrxe7svmkQx4": {
//     "Cost": "540.0",
//     "category": "West",
//     "dateTime": "2022-10-17 17_06_25.306740",
//     "description": "revolt insurance",
//     "timeStamp": 1666006585307
//   },
//   "-NE_inNv3Sjc4_ZV_WMu": {
//     "Cost": "20.0",
//     "category": "Health",
//     "dateTime": "2022-10-17 17_06_35.130809",
//     "description": "swimming",
//     "timeStamp": 1666006595131
//   },
//   "-NEaLgVsOifuR1bWCZ17": {
//     "Cost": "541.0",
//     "category": "Health",
//     "dateTime": "2022-10-17 20_00_52.726175",
//     "description": "kalanvtin trek ",
//     "timeStamp": 1666017052728
//   },
//   "-NEd1FidBhs_y-d_jJso": {
//     "Cost": "20",
//     "dateTime": "2022-10-18 08_30_27.688122",
//     "description": "swimming costume",
//     "timeStamp": 1666062027689,
//     "category": "General"
//   },
//   "-NEenlRmxL2_s7mQgTGn": {
//     "Cost": "30",
//     "category": "Health",
//     "dateTime": "2022-10-18 16_46_23.985572",
//     "description": "swimming",
//     "timeStamp": 1666091783986
//   },
//   "-NEfhzxEVPtqKmKbjTP3": {
//     "Cost": "3000.0",
//     "category": "Pop",
//     "dateTime": "2022-10-18 21_00_47.758175",
//     "description": "kirana",
//     "timeStamp": 1666107047760
//   },
//   "-NEg9_LN4OhJnQsX5lqt": {
//     "Cost": "159.0",
//     "category": "Udhar dile",
//     "dateTime": "2022-10-18 23_05_40.951665",
//     "description": "dish washer ravi",
//     "timeStamp": 1666114540953
//   },
//   "-NEjqm8r1yRWK8OplJGZ": {
//     "Cost": "20",
//     "category": "Health",
//     "dateTime": "2022-10-19 16_17_39.380384",
//     "description": "swimming",
//     "timeStamp": 1666176459383
//   },
//   "-NEvOw0cc_SdUdjQPiLu": {
//     "Cost": "180",
//     "category": "General",
//     "dateTime": "2022-10-21 22_07_04.231736",
//     "description": "kes kaple",
//     "timeStamp": 1666370224232
//   },
//   "-NEyPa9Glk2iydgOesPc": {
//     "Cost": "599.0",
//     "category": "General",
//     "dateTime": "2022-10-22 12_08_48.463122",
//     "description": "trimmer omkar",
//     "timeStamp": 1666420728465
//   },
//   "-NEyQHpvbYDmFO8Jq17P": {
//     "Cost": "50",
//     "category": "Health",
//     "dateTime": "2022-10-22 12_11_51.482803",
//     "description": "medical",
//     "timeStamp": 1666420911483
//   },
//   "-NF-GviKDSmeiIdD2zgL": {
//     "Cost": "25",
//     "category": "General",
//     "dateTime": "2022-10-22 20_50_11.923050",
//     "description": "naral",
//     "timeStamp": 1666452011925
//   },
//   "-NF3syjxfzN_erTbfBCM": {
//     "Cost": "430",
//     "category": "West",
//     "dateTime": "2022-10-23 18_19_16.796546",
//     "description": "hotel jevn",
//     "timeStamp": 1666529356797
//   },
//   "-NF3tKIJn8--1fX_iKia": {
//     "Cost": "720",
//     "category": "General",
//     "dateTime": "2022-10-23 18_20_49.171138",
//     "description": "pant ",
//     "timeStamp": 1666529449172
//   },
//   "-NF45MhHgsS3IxlOxZzd": {
//     "Cost": "40",
//     "category": "General",
//     "dateTime": "2022-10-23 19_17_46.897566",
//     "description": "parking",
//     "timeStamp": 1666532866898
//   },
//   "-NF4FR5GaqeVbuh0x0p8": {
//     "Cost": "160.0",
//     "category": "Udhar dile",
//     "dateTime": "2022-10-23 20_01_46.319093",
//     "description": "Ravi ",
//     "timeStamp": 1666535506321
//   },
//   "-NF94TVL_TT0YQQ4GfWb": {
//     "Cost": "60.0",
//     "category": "General",
//     "dateTime": "2022-10-24 18_31_58.677070",
//     "description": "dahi ",
//     "timeStamp": 1666616518678
//   },
//   "-NF94UuGLaX8l-QjGR-g": {
//     "Cost": "14.0",
//     "category": "General",
//     "dateTime": "2022-10-24 18_32_04.432530",
//     "description": "pen",
//     "timeStamp": 1666616524433
//   },
//   "-NFCath8pAVNIFv2Ysqp": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2022-10-25 10_56_52.488601",
//     "description": "gadi wash ",
//     "timeStamp": 1666675612490
//   },
//   "-NFJLyCh6U8SyA6zBrli": {
//     "Cost": "10",
//     "category": "West",
//     "dateTime": "2022-10-26 18_24_37.163956",
//     "description": "chikat tape",
//     "timeStamp": 1666788877165
//   },
//   "-NFK6Fw1iLhg4zaoKLOx": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2022-10-26 21_55_36.768518",
//     "description": "petrol shidu",
//     "timeStamp": 1666801536770
//   },
//   "-NFK9bBu1IzcQTySCheV": {
//     "Cost": "19",
//     "category": "General",
//     "dateTime": "2022-10-26 22_10_14.394416",
//     "description": "data pack",
//     "timeStamp": 1666802414395
//   },
//   "-NFN3B4j-PuOKw7WpISj": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2022-10-27 11_41_02.126910",
//     "description": "sup",
//     "timeStamp": 1666851062128
//   },
//   "-NFO661jbPzqZvIu3gty": {
//     "Cost": "130",
//     "category": "Food",
//     "dateTime": "2022-10-27 16_33_25.102369",
//     "description": "pavbhaji",
//     "timeStamp": 1666868605103
//   },
//   "-NFTrpnz8HfXeZQy71kz": {
//     "Cost": "250",
//     "category": "General",
//     "dateTime": "2022-10-28 19_24_25.663003",
//     "description": "shorts",
//     "timeStamp": 1666965265663
//   },
//   "-NFTruPXyTGFZfi5yFIi": {
//     "Cost": "42",
//     "category": "Food",
//     "dateTime": "2022-10-28 19_24_44.510766",
//     "description": "Maggie khari",
//     "timeStamp": 1666965284514
//   },
//   "-NFYrnOTX7gcNmOoX6hq": {
//     "Cost": "110",
//     "category": "Food",
//     "dateTime": "2022-10-29 18_42_21.853396",
//     "description": "fries",
//     "timeStamp": 1667049141855
//   },
//   "-NFd0t06t35QkLWM9EBL": {
//     "Cost": "24.0",
//     "category": "Food",
//     "dateTime": "2022-10-30 18_44_32.390421",
//     "description": "\ud83c\udf7f ",
//     "timeStamp": 1667135672391
//   },
//   "-NFjBwZo7bunZ0FdJ6N8": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2022-10-31 23_30_33.843634",
//     "description": "icecream",
//     "timeStamp": 1667239233845
//   },
//   "-NFsMZbmW7eeYf0McnAB": {
//     "Cost": "100",
//     "category": "West",
//     "dateTime": "2022-11-02 18_13_34.257089",
//     "description": "camera checking",
//     "timeStamp": 1667393014258
//   },
//   "-NFyS2-j9_V4RA3Aleol": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2022-11-03 22_35_12.749991",
//     "description": "supe",
//     "timeStamp": 1667495112751
//   },
//   "-NG5Iqy25vYsoClzIZ1f": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2022-11-05 11_12_01.857611",
//     "description": "petrol",
//     "timeStamp": 1667626921860
//   },
//   "-NG5jhppk1AG_xl6HT8F": {
//     "Cost": "200.0",
//     "category": "General",
//     "dateTime": "2022-11-05 13_13_44.499370",
//     "description": "dan ",
//     "timeStamp": 1667634224501
//   },
//   "-NG7Gsay9FK0IS2NpvGz": {
//     "Cost": "129.0",
//     "category": "Food",
//     "dateTime": "2022-11-05 20_22_38.715993",
//     "description": "cafe ",
//     "timeStamp": 1667659958718
//   },
//   "-NG7H0J0EtWSVk5KGvdm": {
//     "Cost": "1264.0",
//     "category": "General",
//     "dateTime": "2022-11-05 20_23_14.369324",
//     "description": "train tickets kerla",
//     "timeStamp": 1667659994369
//   },
//   "-NGCagjcSeAu5HP1wYLE": {
//     "Cost": "5000.0",
//     "category": "General",
//     "dateTime": "2022-11-06 21_11_41.222644",
//     "description": "package advance kerla ",
//     "timeStamp": 1667749301224
//   },
//   "-NGK_llzK6ChOgNup7hW": {
//     "Cost": "101",
//     "category": "General",
//     "dateTime": "2022-11-08 10_24_37.438230",
//     "description": "petrol",
//     "timeStamp": 1667883277439
//   },
//   "-NGMHHpyx1lUOst-hkZt": {
//     "Cost": "44",
//     "category": "Food",
//     "dateTime": "2022-11-08 18_18_44.411850",
//     "description": "chaha",
//     "timeStamp": 1667911724414
//   },
//   "-NGXG6-QUKO5Xc8i9eij": {
//     "Cost": "380",
//     "category": "General",
//     "dateTime": "2022-11-10 21_29_23.162197",
//     "description": "sunflower oil ",
//     "timeStamp": 1668095963163
//   },
//   "-NGZrQFXOlTmcrkTqK39": {
//     "Cost": "11800",
//     "category": "Bhishi",
//     "dateTime": "2022-11-11 09_36_02.017804",
//     "description": "bhishi",
//     "timeStamp": 1668139562018
//   },
//   "-NGaw_325duD8x26tmpn": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2022-11-11 19_17_47.330601",
//     "description": "aai recharge",
//     "timeStamp": 1668174467332
//   },
//   "-NGbsZUoAF_dN7bAQEi0": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2022-11-11 23_39_53.651242",
//     "description": "chaha",
//     "timeStamp": 1668190193653
//   },
//   "-NGbsafnuNDS7qkmjGDE": {
//     "Cost": "75",
//     "category": "Food",
//     "dateTime": "2022-11-11 23_40_02.611245",
//     "description": "juice",
//     "timeStamp": 1668190202611
//   },
//   "-NGdyMM4-NerJk1DAJ3Z": {
//     "Cost": "101",
//     "category": "General",
//     "dateTime": "2022-11-12 09_24_27.139511",
//     "description": "petrol",
//     "timeStamp": 1668225267141
//   },
//   "-NGfKl-C_GY62WzcD5nb": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2022-11-12 15_46_18.699887",
//     "description": "cafe",
//     "timeStamp": 1668248178702
//   },
//   "-NGijfE11SwqY3MLxRge": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2022-11-13 07_38_22.465159",
//     "description": "chaha",
//     "timeStamp": 1668305302467
//   },
//   "-NGlA8cEPR7d4mpD54KT": {
//     "Cost": "65",
//     "category": "Food",
//     "dateTime": "2022-11-13 18_57_39.277901",
//     "description": "chaha",
//     "timeStamp": 1668346059280
//   },
//   "-NGlRPIeCTx8TfwQKUdH": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2022-11-13 20_13_04.040735",
//     "description": "petrol",
//     "timeStamp": 1668350584042
//   },
//   "-NGlRTAQASeyt1ZpbGE2": {
//     "Cost": "40",
//     "category": "General",
//     "dateTime": "2022-11-13 20_13_19.899011",
//     "description": "Cadbury assignment",
//     "timeStamp": 1668350599900
//   },
//   "-NGlkCOcQEv_vcI3C4cv": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2022-11-13 21_39_34.054899",
//     "description": "kel",
//     "timeStamp": 1668355774056
//   },
//   "-NGmJmkiDWuIZs4vX9t5": {
//     "Cost": "298.0",
//     "category": "General",
//     "dateTime": "2022-11-14 00_19_24.268521",
//     "description": "dmart",
//     "timeStamp": 1668365364270
//   },
//   "-NGwMXy4DoBM2cw9ef_S": {
//     "Cost": "1860",
//     "category": "West",
//     "dateTime": "2022-11-15 23_07_38.179996",
//     "description": "exam fee",
//     "timeStamp": 1668533858181
//   },
//   "-NGwMcAoPbtlI6zCLViK": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2022-11-15 23_07_59.540302",
//     "description": "petrol + jevn ",
//     "timeStamp": 1668533879541
//   },
//   "-NH-gFPOV5TFIQ--SrJV": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2022-11-16 19_16_36.055969",
//     "description": "chaha",
//     "timeStamp": 1668606396058
//   },
//   "-NH7vWViTMGiW5waPBZH": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2022-11-18 09_40_15.980888",
//     "description": "petrol",
//     "timeStamp": 1668744615982
//   },
//   "-NHA5Sv2uqgSPu8s9AGg": {
//     "Cost": "168",
//     "category": "General",
//     "dateTime": "2022-11-18 19_47_19.298440",
//     "description": "movie black panther",
//     "timeStamp": 1668781039300
//   },
//   "-NHAmtwJszB1rjut4Jgs": {
//     "Cost": "129",
//     "category": "General",
//     "dateTime": "2022-11-18 23_01_28.402961",
//     "description": "jevn ",
//     "timeStamp": 1668792688405
//   },
//   "-NHEKmJE7KVPehS8-pe9": {
//     "Cost": "139",
//     "category": "Food",
//     "dateTime": "2022-11-19 15_32_43.854372",
//     "description": "jevn ",
//     "timeStamp": 1668852163855
//   },
//   "-NHEpKWJSU26FJ7kqx10": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2022-11-19 17_50_34.514810",
//     "description": "torch",
//     "timeStamp": 1668860434516
//   },
//   "-NHEpMi_PNIR7cQON39s": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2022-11-19 17_50_43.556585",
//     "description": "Pitt goli ",
//     "timeStamp": 1668860443557
//   },
//   "-NHExcFsWbhGTM9s54uV": {
//     "Cost": "70",
//     "category": "General",
//     "dateTime": "2022-11-19 18_26_48.439295",
//     "description": "medical",
//     "timeStamp": 1668862608440
//   },
//   "-NHF-7M9d7aYMxHEO9Ok": {
//     "Cost": "385",
//     "category": "General",
//     "dateTime": "2022-11-19 18_37_44.201475",
//     "description": "kirana",
//     "timeStamp": 1668863264202
//   },
//   "-NHF-oONConehHliKhif": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2022-11-19 18_40_44.567985",
//     "description": "shrikhand",
//     "timeStamp": 1668863444569
//   },
//   "-NHF3S1q3GaO8bM3koN-": {
//     "Cost": "2360",
//     "category": "Pop",
//     "dateTime": "2022-11-19 18_56_37.494148",
//     "description": "Tel dabba",
//     "timeStamp": 1668864397494
//   },
//   "-NHIQAgyHpVgpSgRQIrT": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2022-11-20 10_34_47.421306",
//     "description": "petrol",
//     "timeStamp": 1668920687422
//   },
//   "-NHIV7yYmMPTSW3qeIXp": {
//     "Cost": "1526.55",
//     "category": "General",
//     "dateTime": "2022-11-20 10_56_26.978686",
//     "description": "passport",
//     "timeStamp": 1668921986979
//   },
//   "-NHJ4eynyjwCK3CSqUws": {
//     "Cost": "80.0",
//     "category": "Food",
//     "dateTime": "2022-11-20 13_40_25.586408",
//     "description": "abhi Mahajan ghr nasta",
//     "timeStamp": 1668931825587
//   },
//   "-NHKCwNX9o5G-kTGa7qr": {
//     "Cost": "174.5",
//     "category": "General",
//     "dateTime": "2022-11-20 18_56_11.233143",
//     "description": "perfume",
//     "timeStamp": 1668950771234
//   },
//   "-NHNMQf-n6x4I4RM2lpn": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2022-11-21 09_36_30.334919",
//     "description": "petrol",
//     "timeStamp": 1669003590337
//   },
//   "-NHOxlLXKapViIpSBg5q": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2022-11-21 17_03_37.825425",
//     "description": "chole bhature",
//     "timeStamp": 1669030417826
//   },
//   "-NHSaGtNn0PWK5AjOOVx": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2022-11-22 09_59_28.534786",
//     "description": "petrol",
//     "timeStamp": 1669091368536
//   },
//   "-NHXd8yjK_HqKC1eRAIo": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2022-11-23 09_30_08.622195",
//     "description": "medical",
//     "timeStamp": 1669176008623
//   },
//   "-NHXdA_w1-JK4urw-Zj8": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2022-11-23 09_30_15.227861",
//     "description": "petrol",
//     "timeStamp": 1669176015228
//   },
//   "-NHZL_ikvZj7EC0TtSko": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2022-11-23 17_28_15.982098",
//     "description": "chole bhature",
//     "timeStamp": 1669204695985
//   },
//   "-NHZiHHsP66wm6HJ5O8w": {
//     "Cost": "115",
//     "category": "Food",
//     "dateTime": "2022-11-23 19_11_47.831951",
//     "description": "paneer",
//     "timeStamp": 1669210907833
//   },
//   "-NHZpzU18_vrGaE2zIGZ": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2022-11-23 19_45_27.933768",
//     "description": "petrol",
//     "timeStamp": 1669212927938
//   },
//   "-NHdcV5M8L2xsR1lPcj3": {
//     "Cost": "200",
//     "category": "Food",
//     "dateTime": "2022-11-24 18_04_37.589442",
//     "description": "farsan",
//     "timeStamp": 1669293277591
//   },
//   "-NHdcWIncekim_ghQdor": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2022-11-24 18_04_42.546703",
//     "description": "petrol",
//     "timeStamp": 1669293282547
//   },
//   "-NHkn5871HvM_iwqmLLd": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2022-11-26 03_28_15.366187",
//     "description": "chaha",
//     "timeStamp": 1669413495368
//   },
//   "-NHmP377SNZpfeK_dVkt": {
//     "Cost": "455",
//     "category": "General",
//     "dateTime": "2022-11-26 10_58_07.943364",
//     "description": "recharge 3 months",
//     "timeStamp": 1669440487944
//   },
//   "-NHmxX9Wce-DhxR7bl4q": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2022-11-26 13_33_06.015745",
//     "description": "petrol",
//     "timeStamp": 1669449786017
//   },
//   "-NHn6LRXJ9GBCmF3VJWJ": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2022-11-26 14_15_59.457959",
//     "description": "dan",
//     "timeStamp": 1669452359458
//   },
//   "-NHo1n2jvjgOWZLeooTB": {
//     "Cost": "35",
//     "category": "General",
//     "dateTime": "2022-11-26 18_35_43.150160",
//     "description": "chaha",
//     "timeStamp": 1669467943151
//   },
//   "-NHoefD_jetWrHK6cE70": {
//     "Cost": "40.0",
//     "category": "West",
//     "dateTime": "2022-11-26 21_29_56.834642",
//     "description": "sting",
//     "timeStamp": 1669478396841
//   },
//   "-NHsWgyC3X9IZmQkCQ2C": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2022-11-27 15_29_13.548154",
//     "description": "petrol",
//     "timeStamp": 1669543153549
//   },
//   "-NHtUfzX6X_opD5jZV4u": {
//     "Cost": "4300.0",
//     "category": "Pop",
//     "dateTime": "2022-11-27 20_00_02.465320",
//     "description": "passion gadi pappa",
//     "timeStamp": 1669559402467
//   },
//   "-NHtunKcUDwDUyAQMILh": {
//     "Cost": "130.0",
//     "category": "West",
//     "dateTime": "2022-11-27 21_58_30.439041",
//     "description": "icecream",
//     "timeStamp": 1669566510441
//   },
//   "-NHyEfMlSYaQFm5YmEvy": {
//     "Cost": "15",
//     "category": "General",
//     "dateTime": "2022-11-28 18_08_11.697155",
//     "description": "medical cofcile",
//     "timeStamp": 1669639091697
//   },
//   "-NI5dHOlikV_S_F2ZPI_": {
//     "Cost": "210",
//     "category": "General",
//     "dateTime": "2022-11-30 09_17_02.896362",
//     "description": "petrol",
//     "timeStamp": 1669780022897
//   },
//   "-NI82SSjj11y3PqMc5kq": {
//     "Cost": "3655.0",
//     "category": "Pop",
//     "dateTime": "2022-11-30 20_30_38.381861",
//     "description": "kirana",
//     "timeStamp": 1669820438383
//   },
//   "-NIBLGa866B5mAti-mGR": {
//     "Cost": "6750.0",
//     "category": "General",
//     "dateTime": "2022-12-01 11_51_42.149569",
//     "description": "kerla package",
//     "timeStamp": 1669875702153
//   },
//   "-NICX9CPcvTU_12K7dxx": {
//     "Cost": "1000",
//     "category": "Udhar dile",
//     "dateTime": "2022-12-01 17_23_14.841234",
//     "description": "wifi optical fibre",
//     "timeStamp": 1669895594843
//   },
//   "-NIG2-z-k3e5DzJtQjGy": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2022-12-02 09_45_39.454385",
//     "description": "petrol",
//     "timeStamp": 1669954539456
//   },
//   "-NILVy2reMKXDqMDkSL9": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2022-12-03 11_14_37.879204",
//     "description": "petrol",
//     "timeStamp": 1670046277879
//   },
//   "-NIO3tIHoCypjMJ7CHvO": {
//     "Cost": "217.0",
//     "category": "West",
//     "dateTime": "2022-12-03 23_10_50.001134",
//     "description": "crispy rice",
//     "timeStamp": 1670089250002
//   },
//   "-NIS5M5COQsjLQe--ghQ": {
//     "Cost": "25",
//     "category": "General",
//     "dateTime": "2022-12-04 17_55_43.053055",
//     "description": "shrikhand",
//     "timeStamp": 1670156743053
//   },
//   "-NISTuJfktyIxA6YRVtu": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2022-12-04 19_42_58.795132",
//     "description": "petrol",
//     "timeStamp": 1670163178795
//   },
//   "-NIXu8fjYLoNob-YB3ML": {
//     "Cost": "1110",
//     "category": "General",
//     "dateTime": "2022-12-05 21_00_05.678168",
//     "description": "kan davaknaa",
//     "timeStamp": 1670254205680
//   },
//   "-NIejNiNLsbC1vx5M93U": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2022-12-07 09_30_01.431286",
//     "description": "petrol",
//     "timeStamp": 1670385601432
//   },
//   "-NIkx5fxNQF4UAMhfQWt": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2022-12-08 14_27_40.860125",
//     "description": "petrol",
//     "timeStamp": 1670489860861
//   },
//   "-NImRGQcNahvZ92b6tWv": {
//     "Cost": "400",
//     "category": "General",
//     "dateTime": "2022-12-08 21_23_28.550750",
//     "description": "hoodie",
//     "timeStamp": 1670514808553
//   },
//   "-NImRIF7Txxg6VyVAk2M": {
//     "Cost": "500",
//     "category": "General",
//     "dateTime": "2022-12-08 21_23_36.007414",
//     "description": "Cargo pant",
//     "timeStamp": 1670514816008
//   },
//   "-NImt5gHJgYwJAm-j3__": {
//     "Cost": "70",
//     "category": "General",
//     "dateTime": "2022-12-08 23_29_26.736530",
//     "description": "burger",
//     "timeStamp": 1670522366739
//   },
//   "-NIrO2kHJnRJY81SYJWN": {
//     "Cost": "97",
//     "category": "General",
//     "dateTime": "2022-12-09 20_27_32.177433",
//     "description": "medical",
//     "timeStamp": 1670597852179
//   },
//   "-NIrOyvbLHUngCVm20W_": {
//     "Cost": "5000.0",
//     "category": "Pop",
//     "dateTime": "2022-12-09 20_31_34.567356",
//     "description": "hospital pappa",
//     "timeStamp": 1670598094567
//   },
//   "-NIrl8DimX4jdU4mWdlG": {
//     "Cost": "150.0",
//     "category": "Food",
//     "dateTime": "2022-12-09 22_12_46.061582",
//     "description": "pizza",
//     "timeStamp": 1670604166063
//   },
//   "-NIuPksSfvK9_LfTmKsG": {
//     "Cost": "180",
//     "category": "General",
//     "dateTime": "2022-12-10 10_33_50.812722",
//     "description": "kes dadhi",
//     "timeStamp": 1670648630813
//   },
//   "-NIuPytp5UYlSIZrr-jD": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2022-12-10 10_34_48.245093",
//     "description": "aai recharge",
//     "timeStamp": 1670648688245
//   },
//   "-NIuQS1Lc2uQ4n2LxnQD": {
//     "Cost": "12670",
//     "category": "Bhishi",
//     "dateTime": "2022-12-10 10_36_51.669606",
//     "description": "bhishi",
//     "timeStamp": 1670648811670
//   },
//   "-NIv9kpxSMMRlACufePK": {
//     "Cost": "70",
//     "category": "General",
//     "dateTime": "2022-12-10 14_03_33.563322",
//     "description": "medical",
//     "timeStamp": 1670661213565
//   },
//   "-NIvB9PabKkfbbuE4FCs": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2022-12-10 14_09_40.454350",
//     "description": "juice",
//     "timeStamp": 1670661580455
//   },
//   "-NIvOYmRGyPWLrVPGCEL": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2022-12-10 15_08_12.250348",
//     "description": "carry bag",
//     "timeStamp": 1670665092252
//   },
//   "-NIwBWgRQmwHUIi1Yomm": {
//     "Cost": "107",
//     "category": "General",
//     "dateTime": "2022-12-10 18_50_53.019407",
//     "description": "petrol",
//     "timeStamp": 1670678453020
//   },
//   "-NIwEn0WFmrzc0mU1SeS": {
//     "Cost": "35",
//     "category": "Food",
//     "dateTime": "2022-12-10 19_05_10.432558",
//     "description": "Tomato sauce",
//     "timeStamp": 1670679310433
//   },
//   "-NIwV4aCvtEZ3RiT2nk4": {
//     "Cost": "15",
//     "category": "General",
//     "dateTime": "2022-12-10 20_16_20.811949",
//     "description": "local tickets",
//     "timeStamp": 1670683580814
//   },
//   "-NJ3N79FIcRKqrEYDwnm": {
//     "Cost": "110",
//     "category": "Food",
//     "dateTime": "2022-12-12 08_58_31.887632",
//     "description": "kerla nasta ",
//     "timeStamp": 1670815711889
//   },
//   "-NJ4osw0KHmEydRpAUME": {
//     "Cost": "204.0",
//     "category": "Food",
//     "dateTime": "2022-12-12 15_43_48.928623",
//     "description": "kerla jevn",
//     "timeStamp": 1670840028929
//   },
//   "-NJ5-WDl_bP5E6Y4KBk8": {
//     "Cost": "100",
//     "category": "West",
//     "dateTime": "2022-12-12 16_34_37.553139",
//     "description": "kerla garden",
//     "timeStamp": 1670843077553
//   },
//   "-NJACYBSVw0ZOUsJptRf": {
//     "Cost": "96",
//     "category": "General",
//     "dateTime": "2022-12-13 16_49_39.548696",
//     "description": "kerla jevn",
//     "timeStamp": 1670930379549
//   },
//   "-NJAFCuogWseU0hApK_3": {
//     "Cost": "107.0",
//     "category": "General",
//     "dateTime": "2022-12-13 17_01_18.835198",
//     "description": "kerla medical",
//     "timeStamp": 1670931078836
//   },
//   "-NJAMOzfsJZdfA7-ZqQN": {
//     "Cost": "50",
//     "category": "West",
//     "dateTime": "2022-12-13 17_32_43.306513",
//     "description": "kerla Rose garden",
//     "timeStamp": 1670932963307
//   },
//   "-NJAZ0nNoNhKvtrNTHqO": {
//     "Cost": "185",
//     "category": "Food",
//     "dateTime": "2022-12-13 18_27_52.087406",
//     "description": "chaha patti",
//     "timeStamp": 1670936272088
//   },
//   "-NJF3mwrZaz_uppBPOb3": {
//     "Cost": "585",
//     "category": "General",
//     "dateTime": "2022-12-14 15_29_30.870282",
//     "description": "kerla jeep ride",
//     "timeStamp": 1671011970871
//   },
//   "-NJF4op70GGXFtzZQTx4": {
//     "Cost": "232.0",
//     "category": "General",
//     "dateTime": "2022-12-14 15_34_00.709727",
//     "description": "kerla Marshall art show",
//     "timeStamp": 1671012240712
//   },
//   "-NJKKUoBxjd9pVA5EFjh": {
//     "Cost": "785.0",
//     "category": "General",
//     "dateTime": "2022-12-15 16_00_35.019035",
//     "description": "kerla aai sadi ",
//     "timeStamp": 1671100235020
//   },
//   "-NJO3IBoUDEF6IQU508C": {
//     "Cost": "300",
//     "category": "General",
//     "dateTime": "2022-12-16 09_23_55.762703",
//     "description": "kerla boat showpiece",
//     "timeStamp": 1671162835764
//   },
//   "-NJPEuRFUO5iT8QVHVWT": {
//     "Cost": "186",
//     "category": "General",
//     "dateTime": "2022-12-16 14_54_17.296396",
//     "description": "kerla jevn",
//     "timeStamp": 1671182657296
//   },
//   "-NJPeOsmHbiO6t8vNX2D": {
//     "Cost": "450",
//     "category": "General",
//     "dateTime": "2022-12-16 16_50_01.841167",
//     "description": "kerla lungi",
//     "timeStamp": 1671189601842
//   },
//   "-NJPeTKuVDMW6b-hCMSK": {
//     "Cost": "60",
//     "category": "General",
//     "dateTime": "2022-12-16 16_50_20.089039",
//     "description": "kerla fine",
//     "timeStamp": 1671189620090
//   },
//   "-NJQQI-zg5aLIwc8A5m_": {
//     "Cost": "450",
//     "category": "Udhar dile",
//     "dateTime": "2022-12-16 20_23_38.750146",
//     "description": "kerla Shubham ",
//     "timeStamp": 1671202418751
//   },
//   "-NJUsLbDqloVPR5JVIT8": {
//     "Cost": "380",
//     "category": "West",
//     "dateTime": "2022-12-17 17_09_04.524751",
//     "description": "kerla jevn",
//     "timeStamp": 1671277144527
//   },
//   "-NJVn-e8_l0EP4X1coRl": {
//     "Cost": "70",
//     "category": "General",
//     "dateTime": "2022-12-17 21_25_21.095519",
//     "description": "kerla nasta",
//     "timeStamp": 1671292521097
//   },
//   "-NJctVRjSQoBPr8Moucl": {
//     "Cost": "177",
//     "category": "General",
//     "dateTime": "2022-12-19 11_10_41.901959",
//     "description": "kerla boat ride",
//     "timeStamp": 1671428441903
//   },
//   "-NJefBYOyZXsYfqqDohA": {
//     "Cost": "80",
//     "category": "General",
//     "dateTime": "2022-12-19 19_27_24.823220",
//     "description": "computer repair",
//     "timeStamp": 1671458244825
//   },
//   "-NJejrkmc1kKxjebqOQ6": {
//     "Cost": "320",
//     "category": "General",
//     "dateTime": "2022-12-19 19_47_50.385888",
//     "description": "cake Abhishek",
//     "timeStamp": 1671459470386
//   },
//   "-NJhwFsOSCD9eB4b0bCW": {
//     "Cost": "5000",
//     "category": "Pop",
//     "dateTime": "2022-12-20 10_40_50.648218",
//     "description": "pappa",
//     "timeStamp": 1671513050650
//   },
//   "-NJjee16byjjKk9VCc3J": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2022-12-20 18_43_09.509560",
//     "description": "chaha",
//     "timeStamp": 1671541989511
//   },
//   "-NJmTWn0Jpeqw9mNJ8JU": {
//     "Cost": "125",
//     "category": "Food",
//     "dateTime": "2022-12-21 07_49_01.697268",
//     "description": "cake",
//     "timeStamp": 1671589141697
//   },
//   "-NJotXtQoCnQajLkQCKv": {
//     "Cost": "150",
//     "category": "West",
//     "dateTime": "2022-12-21 19_06_18.521322",
//     "description": "revolt service ",
//     "timeStamp": 1671629778523
//   },
//   "-NJu7Gqt4TINJjYZTkmh": {
//     "Cost": "426",
//     "category": "General",
//     "dateTime": "2022-12-22 19_28_46.968500",
//     "description": "davaknaa",
//     "timeStamp": 1671717526969
//   },
//   "-NJyRBcndHSzP1wjKZM0": {
//     "Cost": "180",
//     "category": "Pop",
//     "dateTime": "2022-12-23 15_34_17.329507",
//     "description": "putty",
//     "timeStamp": 1671789857331
//   },
//   "-NJzc2D9a3ssYejGRs9J": {
//     "Cost": "24",
//     "category": "General",
//     "dateTime": "2022-12-23 21_05_41.705071",
//     "description": "chaha",
//     "timeStamp": 1671809741707
//   },
//   "-NK3djhGKY-pykYvIHLS": {
//     "Cost": "180",
//     "category": "Food",
//     "dateTime": "2022-12-24 20_31_12.142870",
//     "description": "malasa dosa",
//     "timeStamp": 1671894072145
//   },
//   "-NK6v2PwOO4HqcxR-Nxz": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2022-12-25 11_45_40.986824",
//     "description": "petrol",
//     "timeStamp": 1671948940988
//   },
//   "-NK73z7KLmVO0opI5o4f": {
//     "Cost": "1590",
//     "category": "Pop",
//     "dateTime": "2022-12-25 12_29_04.852440",
//     "description": "colour ",
//     "timeStamp": 1671951544853
//   },
//   "-NK8BzdyGRR3ODtz0Fa2": {
//     "Cost": "720",
//     "category": "Pop",
//     "dateTime": "2022-12-25 17_43_41.373488",
//     "description": "colour",
//     "timeStamp": 1671970421374
//   },
//   "-NK8k9-0AA5alWHDdps_": {
//     "Cost": "5000",
//     "category": "Pop",
//     "dateTime": "2022-12-25 20_17_18.784566",
//     "description": "colour",
//     "timeStamp": 1671979638785
//   },
//   "-NK9Cqo4qHv-mcTnQjR-": {
//     "Cost": "24",
//     "category": "Food",
//     "dateTime": "2022-12-25 22_27_04.516951",
//     "description": "Maggie",
//     "timeStamp": 1671987424517
//   },
//   "-NKNzp7XxjCmVxsUVjbS": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2022-12-28 19_20_05.857615",
//     "description": "petrol",
//     "timeStamp": 1672235405858
//   },
//   "-NKOQHy-U4F0Id_wEE0n": {
//     "Cost": "3350",
//     "category": "Pop",
//     "dateTime": "2022-12-28 21_20_05.949577",
//     "description": "home RGB",
//     "timeStamp": 1672242605952
//   },
//   "-NKc-BiRBwTiChZ070_X": {
//     "Cost": "150",
//     "category": "Food",
//     "dateTime": "2022-12-31 17_16_00.732175",
//     "description": "misal",
//     "timeStamp": 1672487160732
//   },
//   "-NKmxgEFAlmr-qO9c9fZ": {
//     "Cost": "1014.8",
//     "category": "Oasiz",
//     "dateTime": "2023-01-02 20_20_52.751588",
//     "description": "Oasiz domain",
//     "timeStamp": 1672671052752
//   },
//   "-NKuw4chSvupHOOzl0Mz": {
//     "Cost": "20.0",
//     "category": "Oasiz",
//     "dateTime": "2023-01-04 09_30_50.219372",
//     "description": "bulb holder",
//     "timeStamp": 1672804850221
//   },
//   "-NL7KhxUMjT58VE2G0lS": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2023-01-06 23_57_52.798641",
//     "description": "chaha",
//     "timeStamp": 1673029672799
//   },
//   "-NL9l0eBCkCTxpzX0ZAC": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-01-07 11_16_25.802784",
//     "description": "petrol",
//     "timeStamp": 1673070385804
//   },
//   "-NL9vdZDCvDNrXULKjqe": {
//     "Cost": "580",
//     "category": "General",
//     "dateTime": "2023-01-07 12_02_50.701156",
//     "description": "WiFi recharge",
//     "timeStamp": 1673073170702
//   },
//   "-NLGP_Nw4I5VJjBnFEGk": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2023-01-08 18_15_43.354553",
//     "description": "chaha",
//     "timeStamp": 1673181943356
//   },
//   "-NLGZgvyqkfp68j_3aXG": {
//     "Cost": "80",
//     "category": "General",
//     "dateTime": "2023-01-08 18_59_55.709488",
//     "description": "gadi wash",
//     "timeStamp": 1673184595710
//   },
//   "-NLGj3h_VxXu1yxrWkR_": {
//     "Cost": "2438",
//     "category": "Oasiz",
//     "dateTime": "2023-01-08 19_45_14.532939",
//     "description": "PCB board",
//     "timeStamp": 1673187314533
//   },
//   "-NLLFeXn9zfv97MZkdXN": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2023-01-09 16_50_29.106169",
//     "description": "chaha",
//     "timeStamp": 1673263229107
//   },
//   "-NLLLOJmA22hvqUKXkLb": {
//     "Cost": "200",
//     "category": "Food",
//     "dateTime": "2023-01-09 17_15_31.441140",
//     "description": "farsan",
//     "timeStamp": 1673264731442
//   },
//   "-NLLnzXwkajYOpWzdZ-S": {
//     "Cost": "13335",
//     "category": "Bhishi",
//     "dateTime": "2023-01-09 19_24_50.171296",
//     "description": "bhishi",
//     "timeStamp": 1673272490172
//   },
//   "-NLM8_6Ge9d9f2FrirLv": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2023-01-09 20_59_09.071548",
//     "description": "panipuri",
//     "timeStamp": 1673278149073
//   },
//   "-NLPOYrXpHd6eG_65QcC": {
//     "Cost": "1000.0",
//     "category": "Pop",
//     "dateTime": "2023-01-10 12_07_49.921132",
//     "description": "pappa",
//     "timeStamp": 1673332669922
//   },
//   "-NLPOpAbmguOVqWIXWc9": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2023-01-10 12_09_00.839470",
//     "description": "aai recharge",
//     "timeStamp": 1673332740840
//   },
//   "-NLV5Qh4ae_5cGvVyAaa": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2023-01-11 14_41_59.042766",
//     "description": "lassi",
//     "timeStamp": 1673428319045
//   },
//   "-NLZ3EWkZmgZs8Do2Ls6": {
//     "Cost": "152",
//     "category": "General",
//     "dateTime": "2023-01-12 09_10_53.742532",
//     "description": "Bappa recharge",
//     "timeStamp": 1673494853744
//   },
//   "-NLZu2q0DFtQhqHxylf8": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2023-01-12 13_06_01.663634",
//     "description": "adhar card Omkar",
//     "timeStamp": 1673508961665
//   },
//   "-NLfoK5n_3NmixMY99BQ": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2023-01-13 21_18_20.017791",
//     "description": "Cadbury",
//     "timeStamp": 1673624900019
//   },
//   "-NLfuIGlAk5xYJ2gvfA2": {
//     "Cost": "800",
//     "category": "General",
//     "dateTime": "2023-01-13 21_44_25.392121",
//     "description": "bappa sweter",
//     "timeStamp": 1673626465393
//   },
//   "-NLfuJyGXxH9-N1BG8v5": {
//     "Cost": "1000",
//     "category": "General",
//     "dateTime": "2023-01-13 21_44_32.337195",
//     "description": "aai ",
//     "timeStamp": 1673626472337
//   },
//   "-NLkxpooYJ-PHbIh34hC": {
//     "Cost": "340",
//     "category": "General",
//     "dateTime": "2023-01-14 21_17_59.411413",
//     "description": "jevn ",
//     "timeStamp": 1673711279412
//   },
//   "-NLq8c0eqIbv0Gud1lrI": {
//     "Cost": "230",
//     "category": "Food",
//     "dateTime": "2023-01-15 21_27_34.696212",
//     "description": "icecream",
//     "timeStamp": 1673798254698
//   },
//   "-NLtmsfZySlFAmZ8NOkI": {
//     "Cost": "85",
//     "category": "General",
//     "dateTime": "2023-01-16 14_26_42.467173",
//     "description": "Xerox",
//     "timeStamp": 1673859402469
//   },
//   "-NLtntgaLBKaHIbf5hL5": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2023-01-16 14_31_08.773651",
//     "description": "biskit",
//     "timeStamp": 1673859668774
//   },
//   "-NLuyDtlPwKoVKnP8Cwr": {
//     "Cost": "85.0",
//     "category": "Food",
//     "dateTime": "2023-01-16 19_55_54.288243",
//     "description": "dahi vada",
//     "timeStamp": 1673879154289
//   },
//   "-NM4boXKf6LwwgvT8bft": {
//     "Cost": "292",
//     "category": "Food",
//     "dateTime": "2023-01-18 21_33_48.500237",
//     "description": "jevn",
//     "timeStamp": 1674057828502
//   },
//   "-NM8-31JUFb5PIoWKOHm": {
//     "Cost": "116",
//     "category": "General",
//     "dateTime": "2023-01-19 13_18_35.090325",
//     "description": "petrol",
//     "timeStamp": 1674114515092
//   },
//   "-NMCTKEyZHz5pkMxybv3": {
//     "Cost": "589",
//     "category": "Oasiz",
//     "dateTime": "2023-01-20 10_09_18.779683",
//     "description": "components hnh cart",
//     "timeStamp": 1674189558782
//   },
//   "-NMCUnfjohZDgS_TPjtH": {
//     "Cost": "911",
//     "category": "Oasiz",
//     "dateTime": "2023-01-20 10_15_45.582684",
//     "description": "components electronic comp",
//     "timeStamp": 1674189945583
//   },
//   "-NMEd0k4yYxxNtisOpd9": {
//     "Cost": "60.0",
//     "category": "General",
//     "dateTime": "2023-01-20 20_15_16.930705",
//     "description": "medical",
//     "timeStamp": 1674225916933
//   },
//   "-NMFLTGSju73eoIQoIlB": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2023-01-20 23_33_50.236013",
//     "description": "Cream roll",
//     "timeStamp": 1674237830238
//   },
//   "-NMHVX4LAialh75MwLvU": {
//     "Cost": "11",
//     "category": "General",
//     "dateTime": "2023-01-21 09_37_01.717394",
//     "description": "Xerox",
//     "timeStamp": 1674274021718
//   },
//   "-NMHhNShq9qZo8L-5jfA": {
//     "Cost": "500",
//     "category": "West",
//     "dateTime": "2023-01-21 10_33_10.186328",
//     "description": "passport",
//     "timeStamp": 1674277390189
//   },
//   "-NMHp0hpymldBKx1OCyE": {
//     "Cost": "90",
//     "category": "Food",
//     "dateTime": "2023-01-21 11_06_34.164971",
//     "description": "paneer",
//     "timeStamp": 1674279394165
//   },
//   "-NMHpXDksrQWwMzHDs5Z": {
//     "Cost": "1000",
//     "category": "General",
//     "dateTime": "2023-01-21 11_08_47.344025",
//     "description": "Omkar bday",
//     "timeStamp": 1674279527344
//   },
//   "-NMJ3CdSpiowcAkAxSfI": {
//     "Cost": "2400",
//     "category": "Pop",
//     "dateTime": "2023-01-21 16_52_32.412424",
//     "description": "fan",
//     "timeStamp": 1674300152413
//   },
//   "-NMJEjSQ91nCOJjro-as": {
//     "Cost": "40",
//     "category": "Oasiz",
//     "dateTime": "2023-01-21 17_42_54.489727",
//     "description": "soldering wire",
//     "timeStamp": 1674303174491
//   },
//   "-NMJXDeUEBIG1hgclLRT": {
//     "Cost": "70",
//     "category": "Food",
//     "dateTime": "2023-01-21 19_03_40.893613",
//     "description": "juce",
//     "timeStamp": 1674308020895
//   },
//   "-NMJm9GX4zcjh2sytuoB": {
//     "Cost": "2400",
//     "category": "Pop",
//     "dateTime": "2023-01-21 20_13_17.216598",
//     "description": "zumbar",
//     "timeStamp": 1674312197219
//   },
//   "-NMO_VbJTOACgVarty98": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2023-01-22 18_36_06.929987",
//     "description": "chaha",
//     "timeStamp": 1674392766932
//   },
//   "-NMU3ytnXpHtzf_7hOLr": {
//     "Cost": "30",
//     "category": "Pop",
//     "dateTime": "2023-01-23 20_11_43.537587",
//     "description": "khile",
//     "timeStamp": 1674484903539
//   },
//   "-NMZNFYs3SBgOD0rGCiF": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2023-01-24 20_54_02.678756",
//     "description": "revolt",
//     "timeStamp": 1674573842680
//   },
//   "-NMgUAhJcU7PwK2zTVRN": {
//     "Cost": "1988",
//     "category": "West",
//     "dateTime": "2023-01-26 10_41_15.539073",
//     "description": "oppo earbuds ",
//     "timeStamp": 1674709875540
//   },
//   "-NMhRyVn2giMgzm59Wqo": {
//     "Cost": "180",
//     "category": "General",
//     "dateTime": "2023-01-26 15_11_14.417799",
//     "description": "dmart",
//     "timeStamp": 1674726074420
//   },
//   "-NMismGwwYU21pRh2YCN": {
//     "Cost": "80",
//     "category": "General",
//     "dateTime": "2023-01-26 21_52_21.562984",
//     "description": "ghoradeswar parking",
//     "timeStamp": 1674750141564
//   },
//   "-NMisr30JQinmPonx13J": {
//     "Cost": "1000",
//     "category": "General",
//     "dateTime": "2023-01-26 21_52_41.152656",
//     "description": "pappa jacket",
//     "timeStamp": 1674750161153
//   },
//   "-NMisvaUNGcghAvNg8rC": {
//     "Cost": "150",
//     "category": "Food",
//     "dateTime": "2023-01-26 21_52_59.743085",
//     "description": "dosa cafe",
//     "timeStamp": 1674750179743
//   },
//   "-NMx5DujXolkgDMvoHGj": {
//     "Cost": "39",
//     "category": "West",
//     "dateTime": "2023-01-29 16_05_47.758526",
//     "description": "chaha",
//     "timeStamp": 1674988547759
//   },
//   "-NN2Ftlth6I8Ds-A6grf": {
//     "Cost": "60",
//     "category": "General",
//     "dateTime": "2023-01-30 20_50_08.056127",
//     "description": "petrol",
//     "timeStamp": 1675092008058
//   },
//   "-NN6eIdd9Sq6Xhm000cw": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2023-01-31 17_19_36.486794",
//     "description": "medical",
//     "timeStamp": 1675165776489
//   },
//   "-NN7YXbq0G9ZV4x4-PN2": {
//     "Cost": "90",
//     "category": "Food",
//     "dateTime": "2023-01-31 21_29_40.020417",
//     "description": "juice",
//     "timeStamp": 1675180780022
//   },
//   "-NNHaYxw_U1t5lDwQkL3": {
//     "Cost": "10000",
//     "category": "Gold bhishi",
//     "dateTime": "2023-02-02 20_19_04.123268",
//     "description": "gold bhishi",
//     "timeStamp": 1675349344124
//   },
//   "-NNI9YG0vlSSnB7Dze4r": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2023-02-02 22_56_18.431940",
//     "description": "cutting",
//     "timeStamp": 1675358778434
//   },
//   "-NNKTjBe7tJbopaygZuL": {
//     "Cost": "5",
//     "category": "General",
//     "dateTime": "2023-02-03 09_43_44.617224",
//     "description": "feviquick",
//     "timeStamp": 1675397624618
//   },
//   "-NNMg8kL0cCeQpDKd4CM": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2023-02-03 20_01_35.701991",
//     "description": "screen gard",
//     "timeStamp": 1675434695702
//   },
//   "-NNMv3LLaSw8UJEDhWNk": {
//     "Cost": "130",
//     "category": "Food",
//     "dateTime": "2023-02-03 21_06_45.717272",
//     "description": "burger",
//     "timeStamp": 1675438605718
//   },
//   "-NNMvxUeEdR8FbvkUgGm": {
//     "Cost": "105",
//     "category": "Food",
//     "dateTime": "2023-02-03 21_10_39.785852",
//     "description": "vadapav",
//     "timeStamp": 1675438839786
//   },
//   "-NNVOj27Sa3wWivKyOsc": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2023-02-05 12_37_42.662866",
//     "description": "chaha",
//     "timeStamp": 1675580862664
//   },
//   "-NNWYZnrFCuyj6-rNtjD": {
//     "Cost": "150",
//     "category": "Food",
//     "dateTime": "2023-02-05 18_00_19.382461",
//     "description": "misal",
//     "timeStamp": 1675600219383
//   },
//   "-NNh57iNPzkIw6x14Bc2": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2023-02-07 23_47_08.757548",
//     "description": "aai recharge",
//     "timeStamp": 1675793828761
//   },
//   "-NNqNg42eqOguXmNeqV4": {
//     "Cost": "10.0",
//     "category": "General",
//     "dateTime": "2023-02-09 19_04_47.106393",
//     "description": "revolt hawa",
//     "timeStamp": 1675949687107
//   },
//   "-NNuC7ko3aFnfI9PvFK8": {
//     "Cost": "13700.0",
//     "category": "Bhishi",
//     "dateTime": "2023-02-10 12_52_47.730706",
//     "description": "bhishi",
//     "timeStamp": 1676013767732
//   },
//   "-NNuPSt2x4eY7aAHr69Q": {
//     "Cost": "180",
//     "category": "General",
//     "dateTime": "2023-02-10 13_51_02.146197",
//     "description": "revolt punchier",
//     "timeStamp": 1676017262148
//   },
//   "-NNwCBJVCGXD3xR35uBD": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2023-02-10 22_12_16.735781",
//     "description": "icecream",
//     "timeStamp": 1676047336736
//   },
//   "-NNyypesBjEjV-IA35LA": {
//     "Cost": "172",
//     "category": "General",
//     "dateTime": "2023-02-11 11_08_25.591136",
//     "description": "medical",
//     "timeStamp": 1676093905592
//   },
//   "-NO03PnmiCrbpqxFRhPO": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2023-02-11 20_52_02.865321",
//     "description": "mentos",
//     "timeStamp": 1676128922866
//   },
//   "-NO0Hp1IoqKQR5J4nxf_": {
//     "Cost": "12",
//     "category": "Food",
//     "dateTime": "2023-02-11 21_55_00.307456",
//     "description": "Chapati",
//     "timeStamp": 1676132700308
//   },
//   "-NO0LNDA9mQU-Ej668Xl": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-02-11 22_10_30.858564",
//     "description": "cock",
//     "timeStamp": 1676133630859
//   },
//   "-NO3yH_dZYb_yLdjI7Xu": {
//     "Cost": "140",
//     "category": "Food",
//     "dateTime": "2023-02-12 15_03_45.191400",
//     "description": "Apple",
//     "timeStamp": 1676194425193
//   },
//   "-NOFVurgdD3tmT3P8XSX": {
//     "Cost": "10000.0",
//     "category": "Gold bhishi",
//     "dateTime": "2023-02-14 20_50_52.459198",
//     "description": "gold bhishi",
//     "timeStamp": 1676388052460
//   },
//   "-NOIHgiaEOkIg3rLMuuM": {
//     "Cost": "300",
//     "category": "Udhar dile",
//     "dateTime": "2023-02-15 09_47_36.164608",
//     "description": "Ravi",
//     "timeStamp": 1676434656166
//   },
//   "-NOYUX2vVmtcxvJt9rcO": {
//     "Cost": "455",
//     "category": "General",
//     "dateTime": "2023-02-18 13_17_35.802554",
//     "description": "my recharge 3 month",
//     "timeStamp": 1676706455804
//   },
//   "-NOZ-WfsFFq9j1to8y72": {
//     "Cost": "70",
//     "category": "General",
//     "dateTime": "2023-02-18 15_41_45.015627",
//     "description": "gadi wash revolt",
//     "timeStamp": 1676715105017
//   },
//   "-NOZiqHS09nU59-dicl8": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2023-02-18 19_04_08.027866",
//     "description": "lassi",
//     "timeStamp": 1676727248029
//   },
//   "-NOcPEmAsmHSpKfmKreQ": {
//     "Cost": "70",
//     "category": "Udhar dile",
//     "dateTime": "2023-02-19 12_12_36.298067",
//     "description": "har pradeep",
//     "timeStamp": 1676788956300
//   },
//   "-NOc_uPRHGEXxFyrsAxm": {
//     "Cost": "160",
//     "category": "General",
//     "dateTime": "2023-02-19 13_03_34.492346",
//     "description": "petrol",
//     "timeStamp": 1676792014492
//   },
//   "-NOdh3G9T3eWvjiJMGlJ": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-02-19 18_14_27.081477",
//     "description": "chips",
//     "timeStamp": 1676810667082
//   },
//   "-NOjl1HmjAGtS2VtyEUF": {
//     "Cost": "157",
//     "category": "Food",
//     "dateTime": "2023-02-20 22_29_30.864595",
//     "description": "jevn ",
//     "timeStamp": 1676912370866
//   },
//   "-NOjl9hw0aDThZcVmS1L": {
//     "Cost": "480.0",
//     "category": "Udhar dile",
//     "dateTime": "2023-02-20 22_30_05.371702",
//     "description": "rvya, Sandy,shubya",
//     "timeStamp": 1676912405372
//   },
//   "-NOoET3CKm9BHKDt4u9X": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2023-02-21 19_20_57.804485",
//     "description": "petrol",
//     "timeStamp": 1676987457805
//   },
//   "-NOxVZIQGkd7CQ8rdHNx": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-02-23 14_32_14.747196",
//     "description": "tak",
//     "timeStamp": 1677142934747
//   },
//   "-NPBqY-dl2_6VM2duUQo": {
//     "Cost": "3000.0",
//     "category": "General",
//     "dateTime": "2023-02-26 14_02_34.855006",
//     "description": "aai",
//     "timeStamp": 1677400354857
//   },
//   "-NPBsI0f7A2uR36t1lWL": {
//     "Cost": "12",
//     "category": "Food",
//     "dateTime": "2023-02-26 14_10_13.674353",
//     "description": "pav ladi",
//     "timeStamp": 1677400813675
//   },
//   "-NPBsJEPmub4tMS6OmJs": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-02-26 14_10_18.650001",
//     "description": "tak",
//     "timeStamp": 1677400818650
//   },
//   "-NPChdkcmEy9UBCGWn-a": {
//     "Cost": "700",
//     "category": "Pop",
//     "dateTime": "2023-02-26 18_03_20.422634",
//     "description": "pappa ",
//     "timeStamp": 1677414800424
//   },
//   "-NPIieM2dIxfZJ4cM6_v": {
//     "Cost": "185",
//     "category": "Food",
//     "dateTime": "2023-02-27 22_05_28.322466",
//     "description": "icecream",
//     "timeStamp": 1677515728323
//   },
//   "-NPMNSd0KEYDmks_W2EM": {
//     "Cost": "63",
//     "category": "Food",
//     "dateTime": "2023-02-28 15_06_57.920503",
//     "description": "tak",
//     "timeStamp": 1677577017921
//   },
//   "-NPVpirfLfbWAq6erZ1Z": {
//     "Cost": "380",
//     "category": "Udhar dile",
//     "dateTime": "2023-03-02 11_11_25.610691",
//     "description": "Ravi wallet",
//     "timeStamp": 1677735685612
//   },
//   "-NPWbNS1m6huYCAZ3BHw": {
//     "Cost": "28",
//     "category": "Food",
//     "dateTime": "2023-03-02 14_48_20.993360",
//     "description": "tak",
//     "timeStamp": 1677748700994
//   },
//   "-NPY1eXaYqDDfuvizJkF": {
//     "Cost": "160",
//     "category": "Food",
//     "dateTime": "2023-03-02 21_27_10.180879",
//     "description": "jevn",
//     "timeStamp": 1677772630183
//   },
//   "-NPa0Cg4P44MfrqZTnCI": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2023-03-03 11_19_41.508444",
//     "description": "petrol",
//     "timeStamp": 1677822581509
//   },
//   "-NPbxUEMIPqTaGxZIWnV": {
//     "Cost": "372",
//     "category": "Oasiz",
//     "dateTime": "2023-03-03 20_22_39.254194",
//     "description": "election components",
//     "timeStamp": 1677855159255
//   },
//   "-NPkhAzPi6maxJM6Kq3N": {
//     "Cost": "20000.0",
//     "category": "Gold bhishi",
//     "dateTime": "2023-03-05 13_08_01.048450",
//     "description": "gold bhishi",
//     "timeStamp": 1678001881050
//   },
//   "-NPld_ssbpEipl_eKw8-": {
//     "Cost": "387",
//     "category": "Food",
//     "dateTime": "2023-03-05 17_31_55.766666",
//     "description": "cafe",
//     "timeStamp": 1678017715769
//   },
//   "-NPmHVFH6ZYyWCjw1n9t": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2023-03-05 20_30_40.591939",
//     "description": "jalebi",
//     "timeStamp": 1678028440594
//   },
//   "-NPmISHPCdtvVM8Bsj3R": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2023-03-05 20_34_50.585638",
//     "description": "us ras",
//     "timeStamp": 1678028690586
//   },
//   "-NPmInDWDHZ8WrxWf0du": {
//     "Cost": "180",
//     "category": "Food",
//     "dateTime": "2023-03-05 20_36_20.448666",
//     "description": "vadapav",
//     "timeStamp": 1678028780449
//   },
//   "-NPmL78CIt1-1cf7kGW1": {
//     "Cost": "360",
//     "category": "Food",
//     "dateTime": "2023-03-05 20_46_30.412577",
//     "description": "cake",
//     "timeStamp": 1678029390413
//   },
//   "-NPpzDx2oW2Yfc-tel_Q": {
//     "Cost": "63",
//     "category": "Food",
//     "dateTime": "2023-03-06 13_44_57.857900",
//     "description": "tak",
//     "timeStamp": 1678090497859
//   },
//   "-NPw-0ZK_MEM0GcKFGNj": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2023-03-07 17_46_08.467827",
//     "description": "color",
//     "timeStamp": 1678191368471
//   },
//   "-NPw-7bqL-ZRD4a343Ci": {
//     "Cost": "3026",
//     "category": "General",
//     "dateTime": "2023-03-07 17_46_37.365657",
//     "description": "revolt insurance",
//     "timeStamp": 1678191397366
//   },
//   "-NPx0KRnPrYjh5brXtr7": {
//     "Cost": "180",
//     "category": "General",
//     "dateTime": "2023-03-07 22_31_29.265815",
//     "description": "aai recharge",
//     "timeStamp": 1678208489267
//   },
//   "-NQ-M8NwwDy9kk8bnkL4": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-03-08 14_05_38.682667",
//     "description": "tak",
//     "timeStamp": 1678264538684
//   },
//   "-NQ0SUgbSJGU66tKM5__": {
//     "Cost": "140",
//     "category": "General",
//     "dateTime": "2023-03-08 19_13_00.133942",
//     "description": "light bulb",
//     "timeStamp": 1678282980135
//   },
//   "-NQ0SXus3A4B55vtjFlC": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2023-03-08 19_13_13.335834",
//     "description": "kachhi dabeli",
//     "timeStamp": 1678282993336
//   },
//   "-NQ18KPZ5tScK5pvKJXk": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2023-03-08 22_24_32.355476",
//     "description": "prasad",
//     "timeStamp": 1678294472356
//   },
//   "-NQ4ajoFH7Cq9o4SmqJc": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2023-03-09 14_31_54.318099",
//     "description": "chappal shilai",
//     "timeStamp": 1678352514320
//   },
//   "-NQ5gFbidPGazXimwx1K": {
//     "Cost": "90",
//     "category": "Food",
//     "dateTime": "2023-03-09 19_35_36.621598",
//     "description": "icecream",
//     "timeStamp": 1678370736622
//   },
//   "-NQ9QqNXNvsjBHYdss_1": {
//     "Cost": "14270",
//     "category": "Bhishi",
//     "dateTime": "2023-03-10 13_02_23.713459",
//     "description": "bhishi",
//     "timeStamp": 1678433543714
//   },
//   "-NQ9hRVPeO_eZz0RoVDR": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-03-10 14_19_16.312128",
//     "description": "tak",
//     "timeStamp": 1678438156314
//   },
//   "-NQB3uMbSycEEg89u83V": {
//     "Cost": "418",
//     "category": "General",
//     "dateTime": "2023-03-10 20_41_25.158730",
//     "description": "perfume",
//     "timeStamp": 1678461085159
//   },
//   "-NQEmW_XxvfPzhgmv0gD": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2023-03-11 13_59_33.921205",
//     "description": "chole bhature",
//     "timeStamp": 1678523373922
//   },
//   "-NQEmjCWHyZo7dwl9eJT": {
//     "Cost": "40",
//     "category": "General",
//     "dateTime": "2023-03-11 14_00_29.728420",
//     "description": "pani bottle",
//     "timeStamp": 1678523429729
//   },
//   "-NQEmv9d1b7dsduaBd7s": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2023-03-11 14_01_18.696259",
//     "description": "tak",
//     "timeStamp": 1678523478697
//   },
//   "-NQFUJ6HCHg3Hb5eUnuN": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2023-03-11 17_15_15.215958",
//     "description": "revolt",
//     "timeStamp": 1678535115218
//   },
//   "-NQImUCf8atKdgeazqzY": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2023-03-12 08_37_53.064548",
//     "description": "pani bottle",
//     "timeStamp": 1678590473067
//   },
//   "-NQJqFRiHQ_WNzGQ56Lm": {
//     "Cost": "115",
//     "category": "Food",
//     "dateTime": "2023-03-12 13_33_58.380838",
//     "description": "vadapav nasta",
//     "timeStamp": 1678608238382
//   },
//   "-NQKFb3ei_IWzMPN-joE": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-03-12 15_29_06.792955",
//     "description": "tak",
//     "timeStamp": 1678615146795
//   },
//   "-NQKgKmhZTOozmgbA_uY": {
//     "Cost": "280",
//     "category": "General",
//     "dateTime": "2023-03-12 17_30_16.043940",
//     "description": "cake",
//     "timeStamp": 1678622416045
//   },
//   "-NQQmz-itUZw7HM6TRRg": {
//     "Cost": "950",
//     "category": "General",
//     "dateTime": "2023-03-13 21_57_01.037379",
//     "description": "kapde",
//     "timeStamp": 1678724821038
//   },
//   "-NQUIHT9Ie2f5v53zkAs": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2023-03-14 14_17_01.000989",
//     "description": "tak",
//     "timeStamp": 1678783621002
//   },
//   "-NQW1J8mD2oVE6U2tC6U": {
//     "Cost": "530",
//     "category": "General",
//     "dateTime": "2023-03-14 22_22_05.871165",
//     "description": "underware",
//     "timeStamp": 1678812725874
//   },
//   "-NQZSyy1DJcG1V-4Y_yZ": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2023-03-15 14_21_50.786313",
//     "description": "tak",
//     "timeStamp": 1678870310786
//   },
//   "-NQdanO0Jk7DBK5o9pJt": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2023-03-16 14_18_28.735760",
//     "description": "tak",
//     "timeStamp": 1678956508737
//   },
//   "-NQegXnBuXDnzI0EZl1E": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2023-03-16 19_23_10.860131",
//     "description": "vadapav",
//     "timeStamp": 1678974790860
//   },
//   "-NQfE5Cwes7HH_Ww4Oc4": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2023-03-16 21_54_08.826481",
//     "description": "icecream",
//     "timeStamp": 1678983848828
//   },
//   "-NQke0vzHgnEm4VA0JxE": {
//     "Cost": "5500",
//     "category": "Pop",
//     "dateTime": "2023-03-17 23_09_55.261611",
//     "description": "painter",
//     "timeStamp": 1679074795263
//   },
//   "-NQpqdAuE0n2NlhqspBZ": {
//     "Cost": "610",
//     "category": "General",
//     "dateTime": "2023-03-18 23_23_07.832873",
//     "description": "anna sister gift",
//     "timeStamp": 1679161987834
//   },
//   "-NQthweLuYr12BJxxIfj": {
//     "Cost": "70",
//     "category": "Food",
//     "dateTime": "2023-03-19 17_23_37.173105",
//     "description": "chips",
//     "timeStamp": 1679226817174
//   },
//   "-NQtiWJYFZnCLpckyjJf": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2023-03-19 17_26_07.331080",
//     "description": "kalingad",
//     "timeStamp": 1679226967332
//   },
//   "-NQtio3sEMn6ILZ1ilIb": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2023-03-19 17_27_24.151787",
//     "description": "chaku",
//     "timeStamp": 1679227044153
//   },
//   "-NQzF6pODEpPsfSDXEjz": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2023-03-20 19_11_01.912363",
//     "description": "idli",
//     "timeStamp": 1679319661913
//   },
//   "-NR-D6qQl45sLr37UigM": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2023-03-20 23_41_54.906996",
//     "description": "kulfi",
//     "timeStamp": 1679335914907
//   },
//   "-NR6MMMiAbCXc08SeCPU": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-03-22 08_59_38.285353",
//     "description": "petrol",
//     "timeStamp": 1679455778286
//   },
//   "-NRCdg52dDnUdEyX5_lG": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2023-03-23 14_17_25.058415",
//     "description": "tak",
//     "timeStamp": 1679561245059
//   },
//   "-NRGh7-wECpPc0kHnUVT": {
//     "Cost": "19",
//     "category": "General",
//     "dateTime": "2023-03-24 09_10_54.715455",
//     "description": "aai recharge",
//     "timeStamp": 1679629254717
//   },
//   "-NRGjIBlJibXtJ7PsucB": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-03-24 09_20_24.816557",
//     "description": "petrol",
//     "timeStamp": 1679629824817
//   },
//   "-NRMNHmlapHz7IHNRXFx": {
//     "Cost": "40.0",
//     "category": "Food",
//     "dateTime": "2023-03-25 11_37_37.133735",
//     "description": "tak",
//     "timeStamp": 1679724457137
//   },
//   "-NRMbvPZf-XGqARlHOE4": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2023-03-25 12_45_55.684242",
//     "description": "revolt wash",
//     "timeStamp": 1679728555685
//   },
//   "-NRMukHBWldC8cnpR1VN": {
//     "Cost": "676",
//     "category": "General",
//     "dateTime": "2023-03-25 14_08_10.826017",
//     "description": "dmart",
//     "timeStamp": 1679733490828
//   },
//   "-NRPTxZ-AR70A4HVbL4t": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-03-26 02_05_36.831586",
//     "description": "chakhli",
//     "timeStamp": 1679776536832
//   },
//   "-NRRv6obeCiblf2eTHFs": {
//     "Cost": "2000",
//     "category": "General",
//     "dateTime": "2023-03-26 13_27_53.318033",
//     "description": "yatra",
//     "timeStamp": 1679817473319
//   },
//   "-NRY6BcC_OubjBYx0Xku": {
//     "Cost": "190",
//     "category": "General",
//     "dateTime": "2023-03-27 18_18_22.029390",
//     "description": "nasta",
//     "timeStamp": 1679921302030
//   },
//   "-NRi3tkT7EtfUiEbKSdx": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2023-03-29 21_24_09.820578",
//     "description": "icecream",
//     "timeStamp": 1680105249822
//   },
//   "-NRmzd-bRxpOY4JJqf9l": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2023-03-30 20_19_16.582504",
//     "description": "kes",
//     "timeStamp": 1680187756584
//   },
//   "-NRn1mGct6Dn1h75sdEk": {
//     "Cost": "9",
//     "category": "General",
//     "dateTime": "2023-03-30 20_33_00.966653",
//     "description": "eno",
//     "timeStamp": 1680188580968
//   },
//   "-NRnTuJaye5XrE2IG42u": {
//     "Cost": "570",
//     "category": "Food",
//     "dateTime": "2023-03-30 22_35_53.954914",
//     "description": "faluda",
//     "timeStamp": 1680195953958
//   },
//   "-NRpnynKbikANCceo6p8": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-03-31 09_27_11.763286",
//     "description": "petrol",
//     "timeStamp": 1680235031765
//   },
//   "-NRxWfIoeXrRoM3_2dvO": {
//     "Cost": "84",
//     "category": "Food",
//     "dateTime": "2023-04-01 21_24_11.059174",
//     "description": "vadapav",
//     "timeStamp": 1680364451061
//   },
//   "-NS1p7svxLi9selQuwrZ": {
//     "Cost": "5100",
//     "category": "West",
//     "dateTime": "2023-04-02 22_07_19.034738",
//     "description": "Birthday",
//     "timeStamp": 1680453439036
//   },
//   "-NSBkO7UBtGmp7O70OGD": {
//     "Cost": "60",
//     "category": "General",
//     "dateTime": "2023-04-04 20_22_47.006333",
//     "description": "SSD cable",
//     "timeStamp": 1680619967007
//   },
//   "-NSM4BmZtS3d63gRSLtb": {
//     "Cost": "170",
//     "category": "Food",
//     "dateTime": "2023-04-06 20_29_53.634756",
//     "description": "aloo bhujiya",
//     "timeStamp": 1680793193637
//   },
//   "-NSR1QILUblmoQnzTrRV": {
//     "Cost": "141",
//     "category": "Food",
//     "dateTime": "2023-04-07 19_35_52.724534",
//     "description": "kulfi",
//     "timeStamp": 1680876352726
//   },
//   "-NSUkm2D0dQ4DvbGgZXa": {
//     "Cost": "500",
//     "category": "General",
//     "dateTime": "2023-04-08 12_57_16.172874",
//     "description": "bai",
//     "timeStamp": 1680938836174
//   },
//   "-NSUt8tg5_G-10iIEGNZ": {
//     "Cost": "170",
//     "category": "Food",
//     "dateTime": "2023-04-08 13_33_51.020193",
//     "description": "nasta",
//     "timeStamp": 1680941031020
//   },
//   "-NSVR20owP6a4WiFbNt1": {
//     "Cost": "35",
//     "category": "General",
//     "dateTime": "2023-04-08 16_06_17.906800",
//     "description": "st tickets",
//     "timeStamp": 1680950177908
//   },
//   "-NSVR6M-lcuH3y9TVS_o": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2023-04-08 16_06_35.647794",
//     "description": "tai ajji",
//     "timeStamp": 1680950195648
//   },
//   "-NSW-AiqZ8nnhzwbjv6p": {
//     "Cost": "119",
//     "category": "General",
//     "dateTime": "2023-04-08 18_44_10.740634",
//     "description": "jio recharge",
//     "timeStamp": 1680959650742
//   },
//   "-NSZe5PeWOKXouV9ELdp": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2023-04-09 11_46_10.663142",
//     "description": "icecream",
//     "timeStamp": 1681020970666
//   },
//   "-NS_NAQOxmxJBYAaFtFU": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2023-04-09 15_07_29.815738",
//     "description": "aai recharge",
//     "timeStamp": 1681033049817
//   },
//   "-NSaK_DE7mBm7LfsrETu": {
//     "Cost": "142",
//     "category": "Food",
//     "dateTime": "2023-04-09 19_35_46.253534",
//     "description": "icecream",
//     "timeStamp": 1681049146255
//   },
//   "-NSdxPrqThN7CjN59KHt": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-04-10 12_28_41.268491",
//     "description": "icecream",
//     "timeStamp": 1681109921271
//   },
//   "-NSiFpL-vfqDS3F6DPGG": {
//     "Cost": "60",
//     "category": "General",
//     "dateTime": "2023-04-11 08_31_59.294128",
//     "description": "tickets",
//     "timeStamp": 1681182119296
//   },
//   "-NSiwRmOIh8ZcFNEnA-g": {
//     "Cost": "1225",
//     "category": "General",
//     "dateTime": "2023-04-11 11_42_33.047384",
//     "description": "ssd",
//     "timeStamp": 1681193553049
//   },
//   "-NSixBY0qYLhmt3NX4mt": {
//     "Cost": "14666",
//     "category": "Bhishi",
//     "dateTime": "2023-04-11 11_45_48.673483",
//     "description": "bhishi",
//     "timeStamp": 1681193748674
//   },
//   "-NSixKK_BhKAMVoDx0Sd": {
//     "Cost": "20000",
//     "category": "Gold bhishi",
//     "dateTime": "2023-04-11 11_46_24.676725",
//     "description": "gold bhishi",
//     "timeStamp": 1681193784677
//   },
//   "-NSkB_rPLMhmKitzc7Dp": {
//     "Cost": "160",
//     "category": "Food",
//     "dateTime": "2023-04-11 17_32_41.753047",
//     "description": "pulav",
//     "timeStamp": 1681214561754
//   },
//   "-NSoVpzhK4mbnTWxIv8C": {
//     "Cost": "45",
//     "category": "Food",
//     "dateTime": "2023-04-12 13_39_39.563687",
//     "description": "jevn ",
//     "timeStamp": 1681286979565
//   },
//   "-NSoZ5ZRt0LBTVrFCrf0": {
//     "Cost": "25",
//     "category": "Food",
//     "dateTime": "2023-04-12 13_53_53.883600",
//     "description": "lassi",
//     "timeStamp": 1681287833884
//   },
//   "-NSpq_5HITeHg-cUPl8C": {
//     "Cost": "160",
//     "category": "General",
//     "dateTime": "2023-04-12 19_54_14.737418",
//     "description": "number plate revolt",
//     "timeStamp": 1681309454738
//   },
//   "-NStizLxpwfC140ky2OO": {
//     "Cost": "45",
//     "category": "Food",
//     "dateTime": "2023-04-13 13_59_34.012053",
//     "description": "jevn",
//     "timeStamp": 1681374574013
//   },
//   "-NStncYZ3FtRyfxjToLu": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2023-04-13 14_19_51.331859",
//     "description": "chips",
//     "timeStamp": 1681375791332
//   },
//   "-NSvTOBW2-5FKs9rZI7g": {
//     "Cost": "75",
//     "category": "Food",
//     "dateTime": "2023-04-13 22_06_17.824648",
//     "description": "vadapav",
//     "timeStamp": 1681403777826
//   },
//   "-NSyrR0alDHVyo-qzOjf": {
//     "Cost": "45.0",
//     "category": "Food",
//     "dateTime": "2023-04-14 13_54_34.661268",
//     "description": "jevn",
//     "timeStamp": 1681460674663
//   },
//   "-NSywGx8kkvDw-WmS9QF": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2023-04-14 14_15_44.136836",
//     "description": "chips",
//     "timeStamp": 1681461944138
//   },
//   "-NT3ECStiaAHEO7ayAaQ": {
//     "Cost": "1063",
//     "category": "West",
//     "dateTime": "2023-04-15 14_56_32.568165",
//     "description": "party",
//     "timeStamp": 1681550792570
//   },
//   "-NT3t5SoCj0DWbsbNmwZ": {
//     "Cost": "355",
//     "category": "Health",
//     "dateTime": "2023-04-15 17_59_33.940167",
//     "description": "rajmachi trip",
//     "timeStamp": 1681561773940
//   },
//   "-NT42v2iG_dWMI17cz_7": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2023-04-15 18_46_50.797587",
//     "description": "chaha",
//     "timeStamp": 1681564610798
//   },
//   "-NT4c2W3wNzKgVxLIWVt": {
//     "Cost": "1500.0",
//     "category": "Pop",
//     "dateTime": "2023-04-15 21_24_42.626821",
//     "description": "pappa",
//     "timeStamp": 1681574082629
//   },
//   "-NT8EGTvPF3db5oWtLcG": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2023-04-16 14_14_55.098117",
//     "description": "petrol rajmachi",
//     "timeStamp": 1681634695099
//   },
//   "-NT8FLfDLVdtRSXKfbE3": {
//     "Cost": "70",
//     "category": "Food",
//     "dateTime": "2023-04-16 14_19_38.508525",
//     "description": "us ras",
//     "timeStamp": 1681634978510
//   },
//   "-NT9m2JTafFvokCbPJTR": {
//     "Cost": "70",
//     "category": "West",
//     "dateTime": "2023-04-16 21_26_29.339712",
//     "description": "icecream",
//     "timeStamp": 1681660589343
//   },
//   "-NTJXelOP7T7VqcqnIjl": {
//     "Cost": "130",
//     "category": "Food",
//     "dateTime": "2023-04-18 18_55_28.792240",
//     "description": "juce",
//     "timeStamp": 1681824328793
//   },
//   "-NTav9U_G-DYY2WJIAqO": {
//     "Cost": "350",
//     "category": "General",
//     "dateTime": "2023-04-22 08_35_40.068207",
//     "description": "petrol sandan valley",
//     "timeStamp": 1682132740069
//   },
//   "-NTbV1LgL4SbL4ROVLUy": {
//     "Cost": "40",
//     "category": "General",
//     "dateTime": "2023-04-22 11_16_46.058747",
//     "description": "charging cable",
//     "timeStamp": 1682142406060
//   },
//   "-NTlHCiNVTGe0p5e2QKY": {
//     "Cost": "855",
//     "category": "General",
//     "dateTime": "2023-04-24 08_52_34.774466",
//     "description": "sandan valley",
//     "timeStamp": 1682306554776
//   },
//   "-NU63TwFI_mFUniGWI2_": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2023-04-28 14_24_14.030944",
//     "description": "Jim jam",
//     "timeStamp": 1682672054033
//   },
//   "-NU7-iAPaMz0L9377QlB": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2023-04-28 18_47_25.080937",
//     "description": "cake",
//     "timeStamp": 1682687845082
//   },
//   "-NUBl5_fZAbH_m6ape2R": {
//     "Cost": "8083",
//     "category": "Oasiz",
//     "dateTime": "2023-04-29 16_57_16.841555",
//     "description": "heat gun and solder pest",
//     "timeStamp": 1682767636843
//   },
//   "-NUD6baBkRxqxDtImbqD": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2023-04-29 23_15_16.426489",
//     "description": "chips",
//     "timeStamp": 1682790316428
//   },
//   "-NUHlACp8gBx4cWUHBaR": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2023-04-30 20_55_19.092752",
//     "description": "paratha",
//     "timeStamp": 1682868319093
//   },
//   "-NUL9QMYmsNMbxQXiR1r": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2023-05-01 12_44_30.498701",
//     "description": "chaha",
//     "timeStamp": 1682925270499
//   },
//   "-NULBdWOx9O1-VCwxDX4": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2023-05-01 12_54_12.760503",
//     "description": "petrol",
//     "timeStamp": 1682925852761
//   },
//   "-NUMHTTu69A1inmGzB4x": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2023-05-01 17_59_17.624524",
//     "description": "pani",
//     "timeStamp": 1682944157626
//   },
//   "-NURaDG9oRN8Wp-BKTz2": {
//     "Cost": "22",
//     "category": "Food",
//     "dateTime": "2023-05-02 18_43_40.168643",
//     "description": "chaha",
//     "timeStamp": 1683033220170
//   },
//   "-NUXNYg_iqzUib9mfC_n": {
//     "Cost": "90",
//     "category": "General",
//     "dateTime": "2023-05-03 21_41_41.219806",
//     "description": "petrol",
//     "timeStamp": 1683130301221
//   },
//   "-NUgPuvycJv4lTeA5mE3": {
//     "Cost": "290",
//     "category": "West",
//     "dateTime": "2023-05-05 20_28_12.859694",
//     "description": "movie jhon wick",
//     "timeStamp": 1683298692862
//   },
//   "-NUm9MaepK4D_KWZ2zyp": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2023-05-06 23_13_37.128310",
//     "description": "petrol plus valley",
//     "timeStamp": 1683395017130
//   },
//   "-NUmEWvbC5Y83qaYHVkP": {
//     "Cost": "42",
//     "category": "Food",
//     "dateTime": "2023-05-06 23_36_10.150771",
//     "description": "nasta plus valley",
//     "timeStamp": 1683396370152
//   },
//   "-NUowQCuTj2nSjIVXU2u": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2023-05-07 12_11_33.561690",
//     "description": "petrol",
//     "timeStamp": 1683441693563
//   },
//   "-NUp1G-hxAnFzflEQABK": {
//     "Cost": "158",
//     "category": "Food",
//     "dateTime": "2023-05-07 12_37_04.620143",
//     "description": "jevn plus valley",
//     "timeStamp": 1683443224621
//   },
//   "-NUrANte2s3R4m-B7lkW": {
//     "Cost": "20000",
//     "category": "Gold bhishi",
//     "dateTime": "2023-05-07 22_36_10.661979",
//     "description": "gold bhishi",
//     "timeStamp": 1683479170666
//   },
//   "-NUw0b8Jkd4VnUqX1txN": {
//     "Cost": "20300",
//     "category": "General",
//     "dateTime": "2023-05-08 21_11_33.651483",
//     "description": "phone ",
//     "timeStamp": 1683560493652
//   },
//   "-NUzogbi6kACZAsc5go-": {
//     "Cost": "13062",
//     "category": "West",
//     "dateTime": "2023-05-09 14_53_37.068564",
//     "description": "college fee",
//     "timeStamp": 1683624217070
//   },
//   "-NUzr8e2MhLvE4LxL5kF": {
//     "Cost": "2055",
//     "category": "West",
//     "dateTime": "2023-05-09 15_04_20.289801",
//     "description": "exam fee",
//     "timeStamp": 1683624860291
//   },
//   "-NV-RwaCCjIBzqgefsKP": {
//     "Cost": "13000",
//     "category": "West",
//     "dateTime": "2023-05-09 17_49_28.268324",
//     "description": "clg fee",
//     "timeStamp": 1683634768269
//   },
//   "-NV9yd1Q-OkGTABFmmky": {
//     "Cost": "14350",
//     "category": "Bhishi",
//     "dateTime": "2023-05-11 18_52_53.208686",
//     "description": "bhishi",
//     "timeStamp": 1683811373211
//   },
//   "-NVF9Lq_C8KKHZDEV61V": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2023-05-12 19_02_10.532034",
//     "description": "revolt wash",
//     "timeStamp": 1683898330533
//   },
//   "-NVG3Ws2qnEIyxkkqrcN": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2023-05-12 23_16_20.033751",
//     "description": "spirit",
//     "timeStamp": 1683913580035
//   },
//   "-NVIEPsISz5gUMIlvp4D": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2023-05-13 09_23_09.393352",
//     "description": "my recharge",
//     "timeStamp": 1683949989396
//   },
//   "-NVIL9X99Rv4lbLzWWZv": {
//     "Cost": "8500.0",
//     "category": "Bhishi 2",
//     "dateTime": "2023-05-13 09_52_37.449872",
//     "description": "bhishi 1st bhrna",
//     "timeStamp": 1683951757450
//   },
//   "-NVTSSBpZshK6rG5VD4w": {
//     "Cost": "331",
//     "category": "Health",
//     "dateTime": "2023-05-15 13_40_18.291329",
//     "description": "plus valley milkibar",
//     "timeStamp": 1684138218293
//   },
//   "-NVZkTWkDFk_xJqLdVZr": {
//     "Cost": "76",
//     "category": "General",
//     "dateTime": "2023-05-16 19_01_07.758769",
//     "description": "medical",
//     "timeStamp": 1684243867761
//   },
//   "-NVe0OHBt5iQBO4ARluh": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2023-05-17 19_33_08.809710",
//     "description": "computer cell",
//     "timeStamp": 1684332188812
//   },
//   "-NVkCmgqH9-HR_PQBs0B": {
//     "Cost": "660",
//     "category": "West",
//     "dateTime": "2023-05-19 00_25_01.940973",
//     "description": "black book college",
//     "timeStamp": 1684436101942
//   },
//   "-NVm7XhhuFal0S2IJu2h": {
//     "Cost": "152",
//     "category": "General",
//     "dateTime": "2023-05-19 09_21_20.172480",
//     "description": "bappa recharge",
//     "timeStamp": 1684468280173
//   },
//   "-NVn9u6AWE0HBOYtZV3S": {
//     "Cost": "150",
//     "category": "Food",
//     "dateTime": "2023-05-19 14_11_17.514674",
//     "description": "jevn",
//     "timeStamp": 1684485677515
//   },
//   "-NVxalDEZTkdpW8hfBT-": {
//     "Cost": "120",
//     "category": "General",
//     "dateTime": "2023-05-21 14_49_13.294706",
//     "description": "kes cutting",
//     "timeStamp": 1684660753295
//   },
//   "-NVxcAVZ15nxCFI3pPeQ": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2023-05-21 14_55_23.108175",
//     "description": "katri",
//     "timeStamp": 1684661123108
//   },
//   "-NWNxgPuq8vvScgdaKKf": {
//     "Cost": "160",
//     "category": "Health",
//     "dateTime": "2023-05-26 22_19_07.768334",
//     "description": "rajmachi night trek",
//     "timeStamp": 1685119747770
//   },
//   "-NWRzvw4VHaMu6AO6fO-": {
//     "Cost": "30",
//     "category": "Health",
//     "dateTime": "2023-05-27 17_07_24.483453",
//     "description": "train tickets rajmachi trek ",
//     "timeStamp": 1685187444486
//   },
//   "-NWWdUymlE_USBXNI2Yt": {
//     "Cost": "50.0",
//     "category": "Health",
//     "dateTime": "2023-05-28 14_47_28.882365",
//     "description": "tak ",
//     "timeStamp": 1685265448882
//   },
//   "-NWXMq2v_opbdLE0yisz": {
//     "Cost": "465",
//     "category": "Food",
//     "dateTime": "2023-05-28 18_09_57.945496",
//     "description": "dmart",
//     "timeStamp": 1685277597947
//   },
//   "-NWXPVZgu0m4pWlAUX61": {
//     "Cost": "85",
//     "category": "Health",
//     "dateTime": "2023-05-28 18_21_36.363266",
//     "description": "rajmachi trek rikshaw",
//     "timeStamp": 1685278296364
//   },
//   "-NW__wEJCZkoLxNWjc-Z": {
//     "Cost": "214.0",
//     "category": "Health",
//     "dateTime": "2023-05-29 09_10_24.914812",
//     "description": "rajmachi trek travel",
//     "timeStamp": 1685331624916
//   },
//   "-NWa86mjnzcZ1GjpJIXB": {
//     "Cost": "10000.0",
//     "category": "General",
//     "dateTime": "2023-05-29 11_44_07.278500",
//     "description": "dan",
//     "timeStamp": 1685340847279
//   },
//   "-NX-wNbtAAuq6Zr9K6i3": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2023-06-03 16_38_13.176215",
//     "description": "katori chat",
//     "timeStamp": 1685790493177
//   },
//   "-NX175je1ZAiuJMIjdA8": {
//     "Cost": "440",
//     "category": "Food",
//     "dateTime": "2023-06-03 22_09_02.889187",
//     "description": "paratha",
//     "timeStamp": 1685810342890
//   },
//   "-NX5IT_aO-5pvsjSfUAy": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2023-06-04 17_37_12.996935",
//     "description": "pani bottle",
//     "timeStamp": 1685880432999
//   },
//   "-NX8ioUrcNxq14OzrA8N": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-06-05 09_35_32.277629",
//     "description": "petrol",
//     "timeStamp": 1685937932279
//   },
//   "-NX8lH6qozLDLmpb09fm": {
//     "Cost": "50.0",
//     "category": "Food",
//     "dateTime": "2023-06-05 09_46_17.909830",
//     "description": "nasta",
//     "timeStamp": 1685938577910
//   },
//   "-NXDwMj-qr2fiwPcv6iI": {
//     "Cost": "3000.0",
//     "category": "Udhar dile",
//     "dateTime": "2023-06-06 09_52_50.558563",
//     "description": "pradeep",
//     "timeStamp": 1686025370560
//   },
//   "-NXDwVBx-yYN9JC7pX97": {
//     "Cost": "20000",
//     "category": "Gold bhishi",
//     "dateTime": "2023-06-06 09_53_25.245057",
//     "description": "gold bhishi",
//     "timeStamp": 1686025405245
//   },
//   "-NXE-h8wUZ6_3IUketa7": {
//     "Cost": "50.0",
//     "category": "Food",
//     "dateTime": "2023-06-06 10_11_46.875190",
//     "description": "nasta",
//     "timeStamp": 1686026506876
//   },
//   "-NXIx1z80eGotRdOzN-s": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-06-07 09_13_53.799792",
//     "description": "petrol",
//     "timeStamp": 1686109433801
//   },
//   "-NXLAOKKUaoNdtffVEKy": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2023-06-07 19_35_49.780351",
//     "description": "kapde",
//     "timeStamp": 1686146749781
//   },
//   "-NXOU54tOpvn11_Z5snQ": {
//     "Cost": "15000.0",
//     "category": "Bhishi 2",
//     "dateTime": "2023-06-08 11_00_45.495407",
//     "description": "boss bhish 2nd bhrna",
//     "timeStamp": 1686202245497
//   },
//   "-NXOdZFQEd7iBRVpA0lK": {
//     "Cost": "70",
//     "category": "General",
//     "dateTime": "2023-06-08 11_46_30.490142",
//     "description": "dadhi",
//     "timeStamp": 1686204990492
//   },
//   "-NXOilo_e4SDD123oDey": {
//     "Cost": "60",
//     "category": "General",
//     "dateTime": "2023-06-08 12_09_16.772509",
//     "description": "petrol",
//     "timeStamp": 1686206356773
//   },
//   "-NXOpe3TgRwK15FRhOlN": {
//     "Cost": "34",
//     "category": "Food",
//     "dateTime": "2023-06-08 12_39_20.026107",
//     "description": "ots",
//     "timeStamp": 1686208160030
//   },
//   "-NXPiH5rSDycXCWwvXYm": {
//     "Cost": "300",
//     "category": "General",
//     "dateTime": "2023-06-08 16_46_44.086026",
//     "description": "petrol",
//     "timeStamp": 1686223004087
//   },
//   "-NXYBe7G7zYeKivK0Q9E": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2023-06-10 08_16_24.528421",
//     "description": "my recharge",
//     "timeStamp": 1686365184530
//   },
//   "-NXYg1sX588anuMXDfZp": {
//     "Cost": "110",
//     "category": "Food",
//     "dateTime": "2023-06-10 10_33_32.384218",
//     "description": "bhel gokundi",
//     "timeStamp": 1686373412386
//   },
//   "-NXZ0Am0T20ktPyRkJwh": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2023-06-10 12_05_53.854998",
//     "description": "us ras gokundi",
//     "timeStamp": 1686378953857
//   },
//   "-NXZ9bXoof8fPVNRVCpC": {
//     "Cost": "160",
//     "category": "Food",
//     "dateTime": "2023-06-10 12_47_06.867313",
//     "description": "pani gokundi",
//     "timeStamp": 1686381426868
//   },
//   "-NXdH51SabVXflmc2Qno": {
//     "Cost": "105.0",
//     "category": "General",
//     "dateTime": "2023-06-11 12_37_52.858895",
//     "description": "petrol",
//     "timeStamp": 1686467272861
//   },
//   "-NXezfgFYDXmXJAerW0D": {
//     "Cost": "162",
//     "category": "Food",
//     "dateTime": "2023-06-11 20_36_40.782092",
//     "description": "jevn nasta ",
//     "timeStamp": 1686496000784
//   },
//   "-NXfNL7Rkc0_pv9ZtSaQ": {
//     "Cost": "250",
//     "category": "Health",
//     "dateTime": "2023-06-11 22_24_26.076030",
//     "description": "petrol gokundi",
//     "timeStamp": 1686502466076
//   },
//   "-NXhrkitNIcFkJ_iqYrP": {
//     "Cost": "15000.0",
//     "category": "Bhishi",
//     "dateTime": "2023-06-12 10_00_55.928547",
//     "description": "bhish",
//     "timeStamp": 1686544255930
//   },
//   "-NXjsf74Zre8YgzLtSi7": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2023-06-12 19_24_09.539376",
//     "description": "biskut",
//     "timeStamp": 1686578049541
//   },
//   "-NXnqjDtJwGpXO9e0wFS": {
//     "Cost": "35",
//     "category": "Food",
//     "dateTime": "2023-06-13 13_54_10.936387",
//     "description": "dahi",
//     "timeStamp": 1686644650937
//   },
//   "-NY1NH0Pr1yMgcAiXX23": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-06-16 09_35_25.209200",
//     "description": "petrol",
//     "timeStamp": 1686888325210
//   },
//   "-NY9GI3AHlO8rhNTW4Ui": {
//     "Cost": "210",
//     "category": "Food",
//     "dateTime": "2023-06-17 22_21_52.202253",
//     "description": "icecream",
//     "timeStamp": 1687020712203
//   },
//   "-NYDr0S6GnjsSsjaXbnS": {
//     "Cost": "64",
//     "category": "Food",
//     "dateTime": "2023-06-18 19_45_10.406422",
//     "description": "cake farewell",
//     "timeStamp": 1687097710407
//   },
//   "-NYDyBqKGdkmWdypids_": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-06-18 20_16_32.085470",
//     "description": "panipuri",
//     "timeStamp": 1687099592085
//   },
//   "-NYR9EaqszUo7uH8kZUC": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2023-06-21 09_44_12.916745",
//     "description": "mask",
//     "timeStamp": 1687320852918
//   },
//   "-NYTQpyfcp8uJLUW2YDX": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2023-06-21 20_20_20.969880",
//     "description": "eno",
//     "timeStamp": 1687359020971
//   },
//   "-NYXC6WR4ity1Bo3j4HS": {
//     "Cost": "40",
//     "category": "General",
//     "dateTime": "2023-06-22 13_54_29.530982",
//     "description": "copy",
//     "timeStamp": 1687422269532
//   },
//   "-NYYEhkqoQZic0ACouZA": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2023-06-22 18_45_27.669729",
//     "description": "nasta",
//     "timeStamp": 1687439727670
//   },
//   "-NYYF-B2KO4Zq4BdovDy": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2023-06-22 18_46_43.138864",
//     "description": "naral pani ",
//     "timeStamp": 1687439803139
//   },
//   "-NYm0Bu2F42vki90UTFC": {
//     "Cost": "341",
//     "category": "Food",
//     "dateTime": "2023-06-25 15_36_21.313526",
//     "description": "farewell jevn",
//     "timeStamp": 1687687581315
//   },
//   "-NZLPNCn57k2CK5jEwRp": {
//     "Cost": "700.0",
//     "category": "Health",
//     "dateTime": "2023-07-02 17_12_41.009635",
//     "description": "Ratangad",
//     "timeStamp": 1688298161011
//   },
//   "-NZQ94cVd7NvLkRjbl5w": {
//     "Cost": "20000",
//     "category": "Gold bhishi",
//     "dateTime": "2023-07-03 15_19_36.671280",
//     "description": "gold bhishi",
//     "timeStamp": 1688377776672
//   },
//   "-NZUzjLzInFEI0fRy_Yg": {
//     "Cost": "45",
//     "category": "Food",
//     "dateTime": "2023-07-04 13_52_30.078195",
//     "description": "jevn",
//     "timeStamp": 1688458950079
//   },
//   "-NZ_4WaV81uWZsko36c3": {
//     "Cost": "45",
//     "category": "Food",
//     "dateTime": "2023-07-05 13_35_52.671035",
//     "description": "jevn",
//     "timeStamp": 1688544352673
//   },
//   "-NZjSH7957pL7CwAlpmX": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2023-07-07 13_55_52.905691",
//     "description": "jevn",
//     "timeStamp": 1688718352907
//   },
//   "-NZjpRAq0DXIY3H-9LiQ": {
//     "Cost": "10000",
//     "category": "General",
//     "dateTime": "2023-07-07 15_41_25.556990",
//     "description": "experience letter",
//     "timeStamp": 1688724685558
//   },
//   "-NZmdvo_xgltjCoGiEhF": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2023-07-08 04_50_01.059438",
//     "description": "my recharge",
//     "timeStamp": 1688772001061
//   },
//   "-NZqIPFMOl1SvAwPzc0Z": {
//     "Cost": "257.0",
//     "category": "Food",
//     "dateTime": "2023-07-08 21_50_05.270436",
//     "description": "kataldhara food",
//     "timeStamp": 1688833205271
//   },
//   "-NZqITi82EykR21GCabu": {
//     "Cost": "210.0",
//     "category": "General",
//     "dateTime": "2023-07-08 21_50_23.560490",
//     "description": "kataldhara petrol",
//     "timeStamp": 1688833223561
//   },
//   "-NZtW8NIQ2fNnC8D80Tg": {
//     "Cost": "1320.0",
//     "category": "General",
//     "dateTime": "2023-07-09 12_48_57.809002",
//     "description": "wifi recharge Apr 870 + July 450",
//     "timeStamp": 1688887137811
//   },
//   "-NZtrp7d-iCE-hXn6ePv": {
//     "Cost": "9000.0",
//     "category": "Bhishi 2",
//     "dateTime": "2023-07-09 14_28_04.200430",
//     "description": "bhishi 3rd bhrna",
//     "timeStamp": 1688893084202
//   },
//   "-N_CuMxgf0SBHyz5VbMg": {
//     "Cost": "500.0",
//     "category": "Udhar dile",
//     "dateTime": "2023-07-13 11_51_35.465993",
//     "description": "amezon prime me + pradeep",
//     "timeStamp": 1689229295469
//   },
//   "-N_Hr1JQVGrVCs1BhyHu": {
//     "Cost": "15200",
//     "category": "Bhishi",
//     "dateTime": "2023-07-14 10_55_06.458240",
//     "description": "bhishi",
//     "timeStamp": 1689312306460
//   },
//   "-N_KBRW2yeupYwsP_CFc": {
//     "Cost": "60",
//     "category": "General",
//     "dateTime": "2023-07-14 21_47_53.217468",
//     "description": "petrol",
//     "timeStamp": 1689351473219
//   },
//   "-N_SLpZ_QNdIOVD6k9wk": {
//     "Cost": "105",
//     "category": "Food",
//     "dateTime": "2023-07-16 11_50_15.011698",
//     "description": "petrol",
//     "timeStamp": 1689488415013
//   },
//   "-N_UDJJqEHZUmVcPMIum": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2023-07-16 20_32_16.118100",
//     "description": "puncher",
//     "timeStamp": 1689519736118
//   },
//   "-N_URRtY0oxLbhuz-Wxp": {
//     "Cost": "110",
//     "category": "Food",
//     "dateTime": "2023-07-16 21_34_01.251212",
//     "description": "jevn",
//     "timeStamp": 1689523441251
//   },
//   "-N_UUjLMzAGGs7O8uA6E": {
//     "Cost": "60",
//     "category": "General",
//     "dateTime": "2023-07-16 21_48_23.254526",
//     "description": "papad jali",
//     "timeStamp": 1689524303255
//   },
//   "-N_b91QlKii-t6osSy-f": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-07-18 09_30_31.983961",
//     "description": "petrol",
//     "timeStamp": 1689652831985
//   },
//   "-N_imDYpJR5kYLYrltyt": {
//     "Cost": "12",
//     "category": "General",
//     "dateTime": "2023-07-19 21_03_27.922938",
//     "description": "Xerox",
//     "timeStamp": 1689780807925
//   },
//   "-Na2L7ZXQ1ECYMSq64V2": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-07-23 20_52_44.895947",
//     "description": "keli",
//     "timeStamp": 1690125764898
//   },
//   "-Na_u3UMVrl-PTtTRrCV": {
//     "Cost": "135",
//     "category": "Food",
//     "dateTime": "2023-07-30 13_56_50.710719",
//     "description": "paneer",
//     "timeStamp": 1690705610711
//   },
//   "-NadwYjoecuuqbMpQLX6": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2023-07-31 08_46_11.891264",
//     "description": "khari",
//     "timeStamp": 1690773371892
//   },
//   "-NayjzVdCfnIBq4LFMIa": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-08-04 09_43_19.271408",
//     "description": "petrol",
//     "timeStamp": 1691122399273
//   },
//   "-Nb4L8P1SOWmsLhV86V0": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2023-08-05 16_27_44.576381",
//     "description": "audio jack",
//     "timeStamp": 1691233064578
//   },
//   "-Nb8NidXS_cfXU7FOvv3": {
//     "Cost": "20000.0",
//     "category": "Gold bhishi",
//     "dateTime": "2023-08-06 11_17_30.273925",
//     "description": "gold bhishi",
//     "timeStamp": 1691300850274
//   },
//   "-Nb8O6qnHfJg6ySSogth": {
//     "Cost": "297",
//     "category": "Food",
//     "dateTime": "2023-08-06 11_19_13.522127",
//     "description": "jevn",
//     "timeStamp": 1691300953523
//   },
//   "-Nb9YSL7pF8SQ-QNihQw": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-08-06 16_44_00.198388",
//     "description": "petrol",
//     "timeStamp": 1691320440200
//   },
//   "-Nb9rnYU2PB_8z6Hw8tJ": {
//     "Cost": "450",
//     "category": "Udhar dile",
//     "dateTime": "2023-08-06 18_12_54.046163",
//     "description": "ravi bullet brek",
//     "timeStamp": 1691325774048
//   },
//   "-NbA7ip5sgJqgEe-SoCP": {
//     "Cost": "310.0",
//     "category": "Udhar dile",
//     "dateTime": "2023-08-06 19_26_51.141437",
//     "description": "phone cover me + ravi 180",
//     "timeStamp": 1691330211143
//   },
//   "-NbAAqO7VTbqfQ7qHj5h": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2023-08-06 19_40_28.551519",
//     "description": "nasta",
//     "timeStamp": 1691331028553
//   },
//   "-NbAJ-CnB2IQOSDS9mcG": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2023-08-06 20_16_05.938683",
//     "description": "massage roles",
//     "timeStamp": 1691333165939
//   },
//   "-NbPdpz67CPBZenFKGrg": {
//     "Cost": "9500",
//     "category": "Bhishi 2",
//     "dateTime": "2023-08-09 19_45_49.445807",
//     "description": "bhishi 4th bhrna",
//     "timeStamp": 1691590549447
//   },
//   "-NbPkp-91o4xCav7cIHx": {
//     "Cost": "120.0",
//     "category": "General",
//     "dateTime": "2023-08-09 20_16_20.424155",
//     "description": "kes cutting",
//     "timeStamp": 1691592380426
//   },
//   "-NbcTyoGpH18WO77AT7Z": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-08-12 12_13_03.056640",
//     "description": "petrol",
//     "timeStamp": 1691822583057
//   },
//   "-NbiOD4lba8WBK5--MLy": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2023-08-13 15_45_36.048115",
//     "description": "shengdane",
//     "timeStamp": 1691921736049
//   },
//   "-NbiaYud0HHBPyuPLaP_": {
//     "Cost": "180.0",
//     "category": "General",
//     "dateTime": "2023-08-13 16_43_53.320027",
//     "description": "prasad shirvardhan",
//     "timeStamp": 1691925233321
//   },
//   "-Nbk1gyfhuvAMeUvEn5E": {
//     "Cost": "175",
//     "category": "Food",
//     "dateTime": "2023-08-13 23_26_27.690202",
//     "description": "icecream shrivardhan",
//     "timeStamp": 1691949387691
//   },
//   "-NbmVUA3FY3mN7pgeaIQ": {
//     "Cost": "1850",
//     "category": "General",
//     "dateTime": "2023-08-14 10_55_49.889917",
//     "description": "shirvardhan room + nasta",
//     "timeStamp": 1691990749892
//   },
//   "-Nbu-O5g0NPJKdsXwgrc": {
//     "Cost": "2500",
//     "category": "General",
//     "dateTime": "2023-08-15 21_52_34.154448",
//     "description": "kapde",
//     "timeStamp": 1692116554156
//   },
//   "-NbuCD0N39NAPl4dtvGw": {
//     "Cost": "901",
//     "category": "Food",
//     "dateTime": "2023-08-15 22_48_36.631425",
//     "description": "jevn shirvardhan",
//     "timeStamp": 1692119916632
//   },
//   "-NbwhpE8JqvFbgvJd97q": {
//     "Cost": "15600",
//     "category": "Bhishi",
//     "dateTime": "2023-08-16 10_30_20.295775",
//     "description": "bhishi",
//     "timeStamp": 1692162020297
//   },
//   "-Nbyg2g4FH-upSCBuhPI": {
//     "Cost": "48",
//     "category": "Food",
//     "dateTime": "2023-08-16 19_41_49.636252",
//     "description": "vadapav",
//     "timeStamp": 1692195109638
//   },
//   "-Nc5prXgJsabbZ2KtxBW": {
//     "Cost": "5000",
//     "category": "General",
//     "dateTime": "2023-08-18 09_41_39.051426",
//     "description": "Omkar class fee",
//     "timeStamp": 1692331899053
//   },
//   "-NcCMPyV0vmWe8soORvD": {
//     "Cost": "185",
//     "category": "General",
//     "dateTime": "2023-08-19 16_05_58.238407",
//     "description": "medical",
//     "timeStamp": 1692441358240
//   },
//   "-NcDYkEQC4DOYkoaqwUb": {
//     "Cost": "715",
//     "category": "General",
//     "dateTime": "2023-08-19 21_39_28.282215",
//     "description": "dmart",
//     "timeStamp": 1692461368284
//   },
//   "-NcD_gqNROLpimW09N2v": {
//     "Cost": "240",
//     "category": "General",
//     "dateTime": "2023-08-19 21_47_58.679822",
//     "description": "farsan",
//     "timeStamp": 1692461878680
//   },
//   "-NcH35rj2Gx9qk9TTyFA": {
//     "Cost": "49",
//     "category": "Food",
//     "dateTime": "2023-08-20 13_59_41.229464",
//     "description": "pohe",
//     "timeStamp": 1692520181231
//   },
//   "-NcJ5CGqaL8gmedF49r4": {
//     "Cost": "254",
//     "category": "Udhar dile",
//     "dateTime": "2023-08-20 23_28_06.196869",
//     "description": "Shubham Chaudhary amezon",
//     "timeStamp": 1692554286198
//   },
//   "-NcLZEyPIhfzmw7p0ebt": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2023-08-21 10_58_35.993366",
//     "description": "petrol",
//     "timeStamp": 1692595715994
//   },
//   "-NcQQz1zUWvR7ucP-XRn": {
//     "Cost": "388",
//     "category": "General",
//     "dateTime": "2023-08-22 09_40_35.582375",
//     "description": "petrol",
//     "timeStamp": 1692677435583
//   },
//   "-NcgYuBSMInS2L7vVtre": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2023-08-25 17_28_45.530080",
//     "description": "Xerox",
//     "timeStamp": 1692964725533
//   },
//   "-NclJXnGRGYnrXACZ1pF": {
//     "Cost": "120",
//     "category": "General",
//     "dateTime": "2023-08-26 15_39_43.631868",
//     "description": "medical",
//     "timeStamp": 1693044583633
//   },
//   "-NclJc8D3BGZghFGazMb": {
//     "Cost": "620.0",
//     "category": "General",
//     "dateTime": "2023-08-26 15_40_05.518041",
//     "description": "jevn",
//     "timeStamp": 1693044605518
//   },
//   "-NcwOiQuy9JAagQsXeFA": {
//     "Cost": "385",
//     "category": "West",
//     "dateTime": "2023-08-28 19_18_11.385230",
//     "description": "convocation mcs",
//     "timeStamp": 1693230491386
//   },
//   "-Nd0bjvfD9LnhzET2Ze5": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2023-08-29 19_37_33.610330",
//     "description": "petrol",
//     "timeStamp": 1693318053612
//   },
//   "-Nd5RA4K3tmqL6lu56gF": {
//     "Cost": "105",
//     "category": "Food",
//     "dateTime": "2023-08-30 18_05_05.172250",
//     "description": "vadapav",
//     "timeStamp": 1693398905173
//   },
//   "-Nd8my_wbWqe2F25B2p-": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-08-31 09_43_34.971587",
//     "description": "petrol",
//     "timeStamp": 1693455214972
//   },
//   "-NdGgC1lgHswen7m-5U7": {
//     "Cost": "75",
//     "category": "Food",
//     "dateTime": "2023-09-01 22_30_56.879162",
//     "description": "chips",
//     "timeStamp": 1693587656881
//   },
//   "-NdGgI7PREyuiw1Lm3-h": {
//     "Cost": "140",
//     "category": "General",
//     "dateTime": "2023-09-01 22_31_21.817493",
//     "description": "keshking oil",
//     "timeStamp": 1693587681818
//   },
//   "-NdOdDWNhSrrJH9SbDBX": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2023-09-03 11_34_54.230687",
//     "description": "my recharge",
//     "timeStamp": 1693721094232
//   },
//   "-NdOo2b0zWpqH2wuOFNp": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2023-09-03 12_22_13.119472",
//     "description": "aai recharge",
//     "timeStamp": 1693723933122
//   },
//   "-NdTJX4-ZfSZ686I_56D": {
//     "Cost": "2000",
//     "category": "General",
//     "dateTime": "2023-09-04 09_22_35.391688",
//     "description": "aai",
//     "timeStamp": 1693799555392
//   },
//   "-NdTKsXwMCHv7KcAVD8Y": {
//     "Cost": "106",
//     "category": "General",
//     "dateTime": "2023-09-04 09_28_29.563690",
//     "description": "petrol",
//     "timeStamp": 1693799909564
//   },
//   "-NdTU0z0ffDdZ4642VPh": {
//     "Cost": "170",
//     "category": "Food",
//     "dateTime": "2023-09-04 10_08_27.520721",
//     "description": "nasta",
//     "timeStamp": 1693802307521
//   },
//   "-Nd_akSi2C-YvOlSDddt": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-09-05 19_19_33.421378",
//     "description": "petrol",
//     "timeStamp": 1693921773422
//   },
//   "-NdhnU-fAJjMhz3RzbOg": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-09-07 09_32_07.529592",
//     "description": "petrol",
//     "timeStamp": 1694059327531
//   },
//   "-Ndq42U0zVdQEoVY1pm0": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-09-09 00_05_51.105005",
//     "description": "chips",
//     "timeStamp": 1694198151105
//   },
//   "-NdyCc7HnuomBxiXqH33": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2023-09-10 14_00_16.080476",
//     "description": "shrikhand",
//     "timeStamp": 1694334616082
//   },
//   "-Ne-UlHAOAZZwqC6UUSs": {
//     "Cost": "20000.0",
//     "category": "Gold bhishi",
//     "dateTime": "2023-09-11 00_38_46.600891",
//     "description": "gold bhishi",
//     "timeStamp": 1694372926603
//   },
//   "-Ne-UtDX2gnpY5SiLEA2": {
//     "Cost": "10000.0",
//     "category": "Bhishi 2",
//     "dateTime": "2023-09-11 00_39_19.138142",
//     "description": "bhishi 5th bhrna",
//     "timeStamp": 1694372959138
//   },
//   "-Ne-UwemuOszClZ4d3f1": {
//     "Cost": "16800.0",
//     "category": "Bhishi",
//     "dateTime": "2023-09-11 00_39_33.234023",
//     "description": "bhishi 18th bhrna ",
//     "timeStamp": 1694372973235
//   },
//   "-NeR_AYgrMeuxg7jg9D0": {
//     "Cost": "85",
//     "category": "Food",
//     "dateTime": "2023-09-16 11_31_46.986377",
//     "description": "nasta",
//     "timeStamp": 1694844106988
//   },
//   "-NegtxGd8rGXH8HXCJPc": {
//     "Cost": "1020",
//     "category": "General",
//     "dateTime": "2023-09-19 15_36_28.965472",
//     "description": "ganpati",
//     "timeStamp": 1695117988969
//   },
//   "-NehMBTD7NxIJEZMH30d": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2023-09-19 17_44_13.389155",
//     "description": "fal ",
//     "timeStamp": 1695125653391
//   },
//   "-NeiVeq0lpSCum8It-2s": {
//     "Cost": "110",
//     "category": "Food",
//     "dateTime": "2023-09-19 23_05_14.302684",
//     "description": "dudh",
//     "timeStamp": 1695144914305
//   },
//   "-Nf0Zth3_EMvqTrQnu4l": {
//     "Cost": "14",
//     "category": "Food",
//     "dateTime": "2023-09-23 15_56_30.850949",
//     "description": "Maggie",
//     "timeStamp": 1695464790852
//   },
//   "-Nf5zZ_uCHP5vDrXsNvn": {
//     "Cost": "167",
//     "category": "Food",
//     "dateTime": "2023-09-24 17_11_08.346166",
//     "description": "pav bhaji",
//     "timeStamp": 1695555668347
//   },
//   "-Nf63SbgIWw7mCKkSjPW": {
//     "Cost": "400.0",
//     "category": "Udhar dile",
//     "dateTime": "2023-09-24 17_32_30.507394",
//     "description": "ravi Jimmy medical",
//     "timeStamp": 1695556950508
//   },
//   "-Nf7AW0nLsUd0Zdt4x-Y": {
//     "Cost": "97",
//     "category": "General",
//     "dateTime": "2023-09-24 22_42_56.688936",
//     "description": "Tel dan",
//     "timeStamp": 1695575576691
//   },
//   "-NfEcrH6O6FCMfm9tYKR": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-09-26 09_28_30.533530",
//     "description": "petrol",
//     "timeStamp": 1695700710535
//   },
//   "-Nf_baHJDZxiUqBMkhiD": {
//     "Cost": "54",
//     "category": "Food",
//     "dateTime": "2023-09-30 15_54_37.522003",
//     "description": "nasta",
//     "timeStamp": 1696069477524
//   },
//   "-Nff6dIlgkWQlOUT7iSy": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2023-10-01 17_32_44.589995",
//     "description": "my recharge",
//     "timeStamp": 1696161764593
//   },
//   "-NffYpuhX55RW2u5mbxO": {
//     "Cost": "425.0",
//     "category": "Health",
//     "dateTime": "2023-10-01 19_35_56.267993",
//     "description": "kalu waterfall ( stay, nasta,fee)",
//     "timeStamp": 1696169156269
//   },
//   "-Nfg2gf5JVrv6zcTaMln": {
//     "Cost": "220.0",
//     "category": "Food",
//     "dateTime": "2023-10-01 21_55_07.014185",
//     "description": "kalu waterfall jevn",
//     "timeStamp": 1696177507014
//   },
//   "-Ng9QmQELVvnErlcxHcN": {
//     "Cost": "55",
//     "category": "General",
//     "dateTime": "2023-10-07 19_28_58.509834",
//     "description": "Petrol",
//     "timeStamp": 1696687138511
//   },
//   "-NgRdeSCGzZ5aHyhEwy_": {
//     "Cost": "20000.0",
//     "category": "Gold bhishi",
//     "dateTime": "2023-10-11 08_22_45.772728",
//     "description": "bhishi gold",
//     "timeStamp": 1696992765774
//   },
//   "-NgSwHSDkpHe7r33qAuP": {
//     "Cost": "9800.0",
//     "category": "Bhishi 2",
//     "dateTime": "2023-10-11 14_23_45.421952",
//     "description": "bhishi 6th bhrna",
//     "timeStamp": 1697014425422
//   },
//   "-NglBSvr5WL3xaFQ1ezI": {
//     "Cost": "50.0",
//     "category": "General",
//     "dateTime": "2023-10-15 08_07_13.845094",
//     "description": "riksha chaurai",
//     "timeStamp": 1697337433847
//   },
//   "-NglLO5aOxn6xASqpbUw": {
//     "Cost": "16670.0",
//     "category": "Bhishi",
//     "dateTime": "2023-10-15 08_50_35.493420",
//     "description": "19th bhrna",
//     "timeStamp": 1697340035494
//   },
//   "-NgqlRU7x0PwvP_bNQ2V": {
//     "Cost": "129.0",
//     "category": "General",
//     "dateTime": "2023-10-16 10_06_53.318774",
//     "description": "tent chaurai",
//     "timeStamp": 1697431013320
//   },
//   "-NgrIcmicego_zHasGTn": {
//     "Cost": "113",
//     "category": "Food",
//     "dateTime": "2023-10-16 12_36_16.619970",
//     "description": "jevn chaurai",
//     "timeStamp": 1697439976622
//   },
//   "-NhCfJAvX79xva7HLMYW": {
//     "Cost": "248",
//     "category": "Food",
//     "dateTime": "2023-10-20 20_51_22.425508",
//     "description": "jevn",
//     "timeStamp": 1697815282427
//   },
//   "-NhG24iWyE2j6ffcAxNZ": {
//     "Cost": "170",
//     "category": "General",
//     "dateTime": "2023-10-21 12_34_06.304343",
//     "description": "aai recharge",
//     "timeStamp": 1697871846305
//   },
//   "-NhIFGHyd1a_KjSym_BM": {
//     "Cost": "220",
//     "category": "Food",
//     "dateTime": "2023-10-21 22_50_55.996995",
//     "description": "jevn",
//     "timeStamp": 1697908855998
//   },
//   "-NhIPIsKzbSWXwR6tqI6": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2023-10-21 23_34_48.019351",
//     "description": "icecream",
//     "timeStamp": 1697911488021
//   },
//   "-NhNDAmm_NawY8ChrvCN": {
//     "Cost": "120",
//     "category": "General",
//     "dateTime": "2023-10-22 21_59_55.248837",
//     "description": "kes cutting",
//     "timeStamp": 1697992195251
//   },
//   "-NhRvOoShaxS9h5CGvEt": {
//     "Cost": "65",
//     "category": "Food",
//     "dateTime": "2023-10-23 19_55_58.044322",
//     "description": "nasta",
//     "timeStamp": 1698071158045
//   },
//   "-NhV4K3TdQLqgvvOFRc2": {
//     "Cost": "92",
//     "category": "Food",
//     "dateTime": "2023-10-24 10_38_11.677744",
//     "description": "jevn",
//     "timeStamp": 1698124091678
//   },
//   "-Nhm3GRj287rZMA68_wU": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2023-10-27 22_26_44.590056",
//     "description": "chili mili",
//     "timeStamp": 1698425804591
//   },
//   "-NhyxMb1kJvoBE_xXk7O": {
//     "Cost": "155",
//     "category": "General",
//     "dateTime": "2023-10-30 10_31_38.625903",
//     "description": "my jio recharge",
//     "timeStamp": 1698642098626
//   },
//   "-Ni3PCwyz0X4nqHnOebR": {
//     "Cost": "145",
//     "category": "General",
//     "dateTime": "2023-10-31 11_55_47.325214",
//     "description": "medial ceeam",
//     "timeStamp": 1698733547326
//   },
//   "-Ni8SuCcbgY-M9uPH-l-": {
//     "Cost": "29",
//     "category": "General",
//     "dateTime": "2023-11-01 11_30_01.126406",
//     "description": "medical cream",
//     "timeStamp": 1698818401128
//   },
//   "-NiDoS8oLbhA79fiTM6o": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2023-11-02 12_26_37.491440",
//     "description": "my recharge",
//     "timeStamp": 1698908197492
//   },
//   "-NiQ6ztaAkCeOre8OXtx": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2023-11-04 21_47_27.140988",
//     "description": "golya",
//     "timeStamp": 1699114647142
//   },
//   "-Nii7N1rO_9flYJfsFtd": {
//     "Cost": "80.0",
//     "category": "Food",
//     "dateTime": "2023-11-08 14_21_53.142095",
//     "description": "juce",
//     "timeStamp": 1699433513143
//   },
//   "-NioV_MtTW_YRd61zT_K": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2023-11-09 20_05_22.488081",
//     "description": "wallet",
//     "timeStamp": 1699540522490
//   },
//   "-NioyWNbBcdFTxtrFIWb": {
//     "Cost": "500",
//     "category": "General",
//     "dateTime": "2023-11-09 22_16_10.470780",
//     "description": "aai",
//     "timeStamp": 1699548370472
//   },
//   "-NirlcfC6be83Dn6llqB": {
//     "Cost": "115.0",
//     "category": "General",
//     "dateTime": "2023-11-10 11_18_44.108340",
//     "description": "train tickets",
//     "timeStamp": 1699595324109
//   },
//   "-NisvdfSMIzU6dF5mLLJ": {
//     "Cost": "20000.0",
//     "category": "Gold bhishi",
//     "dateTime": "2023-11-10 16_42_06.875648",
//     "description": "gold bhishi ",
//     "timeStamp": 1699614726877
//   },
//   "-NitzJ9lHxv0QsCcVsRd": {
//     "Cost": "10100.0",
//     "category": "Bhishi 2",
//     "dateTime": "2023-11-10 21_37_44.560315",
//     "description": "bhishi 7th bhrna",
//     "timeStamp": 1699632464562
//   },
//   "-Nj6-GPPAgCbvQgOgol4": {
//     "Cost": "500",
//     "category": "General",
//     "dateTime": "2023-11-13 10_16_59.225650",
//     "description": "tai aajji",
//     "timeStamp": 1699850819226
//   },
//   "-Nj6V6hAOCUPnAP-cRcn": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2023-11-13 12_36_08.073187",
//     "description": "safarchand",
//     "timeStamp": 1699859168075
//   },
//   "-NjCu64G_tS6i2cwpvsE": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2023-11-14 18_27_24.559894",
//     "description": "pappa",
//     "timeStamp": 1699966644561
//   },
//   "-NjGxPsJzRw1zr0ZTa27": {
//     "Cost": "1000",
//     "category": "General",
//     "dateTime": "2023-11-15 13_20_20.947048",
//     "description": "bai bappa",
//     "timeStamp": 1700034620948
//   },
//   "-NjNrThFDI6Tzj7nLXlV": {
//     "Cost": "25",
//     "category": "Food",
//     "dateTime": "2023-11-16 21_31_44.271033",
//     "description": "dudh",
//     "timeStamp": 1700150504272
//   },
//   "-NjQc1f4fMT_Nw5KuMlq": {
//     "Cost": "17000.0",
//     "category": "Bhishi",
//     "dateTime": "2023-11-17 10_23_08.932006",
//     "description": "bhishi 20th bhrna",
//     "timeStamp": 1700196788933
//   },
//   "-NjVZBLwexyJXxkvMVdJ": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2023-11-18 09_24_26.106834",
//     "description": "dadhi",
//     "timeStamp": 1700279666108
//   },
//   "-Nj_xBIrFZxWQPzTc_JP": {
//     "Cost": "42",
//     "category": "Food",
//     "dateTime": "2023-11-19 10_31_45.589794",
//     "description": "dahi",
//     "timeStamp": 1700370105591
//   },
//   "-Nja12N2lN5S8rR3ItM5": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2023-11-19 10_52_59.714644",
//     "description": "vahi",
//     "timeStamp": 1700371379715
//   },
//   "-NjbjdqVmyb_G1oofYZ9": {
//     "Cost": "2389",
//     "category": "General",
//     "dateTime": "2023-11-19 18_51_51.006485",
//     "description": "kapde diwali",
//     "timeStamp": 1700400111008
//   },
//   "-NjcQUZRUbKU0E3LdJ2v": {
//     "Cost": "940.0",
//     "category": "Food",
//     "dateTime": "2023-11-19 22_03_23.227090",
//     "description": "hotel bigvan",
//     "timeStamp": 1700411603229
//   },
//   "-NjmJNQ34_u1gZffXAuG": {
//     "Cost": "370",
//     "category": "Food",
//     "dateTime": "2023-11-21 20_08_31.106917",
//     "description": "cake",
//     "timeStamp": 1700577511109
//   },
//   "-NjmwaloitU1LPb9Qc0B": {
//     "Cost": "17",
//     "category": "General",
//     "dateTime": "2023-11-21 23_04_15.666155",
//     "description": "cell",
//     "timeStamp": 1700588055668
//   },
//   "-NjqH7Aop69NaQnMCYn0": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-11-22 14_37_09.170741",
//     "description": "chips",
//     "timeStamp": 1700644029172
//   },
//   "-Njrf8nGWKVAIbYrPbcf": {
//     "Cost": "106",
//     "category": "General",
//     "dateTime": "2023-11-22 21_06_06.608492",
//     "description": "petrol",
//     "timeStamp": 1700667366609
//   },
//   "-NjvImz4n9mUCvdRixD4": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2023-11-23 14_02_32.708589",
//     "description": "tak",
//     "timeStamp": 1700728352710
//   },
//   "-Nk0UnFSD3KIsPGRwrKq": {
//     "Cost": "72",
//     "category": "Food",
//     "dateTime": "2023-11-24 18_52_42.844444",
//     "description": "vadapav",
//     "timeStamp": 1700832162845
//   },
//   "-Nk4qiR8aTI10K9acIfp": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2023-11-25 15_11_21.286304",
//     "description": "petrol",
//     "timeStamp": 1700905281289
//   },
//   "-Nk4qmGL9NROjS-u3Joi": {
//     "Cost": "400.0",
//     "category": "Health",
//     "dateTime": "2023-11-25 15_11_36.982066",
//     "description": "devkund view trek ",
//     "timeStamp": 1700905296982
//   },
//   "-NkGG2GF6705rfH4BwMS": {
//     "Cost": "42",
//     "category": "Oasiz",
//     "dateTime": "2023-11-27 20_22_11.727674",
//     "description": "stationary",
//     "timeStamp": 1701096731728
//   },
//   "-NkTlViwEAMCc2pelgx9": {
//     "Cost": "179.0",
//     "category": "General",
//     "dateTime": "2023-11-30 11_19_04.826415",
//     "description": "my recharge",
//     "timeStamp": 1701323344828
//   },
//   "-NkTlXdEKgwIvapb7oj6": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2023-11-30 11_19_12.655257",
//     "description": "aai recharge",
//     "timeStamp": 1701323352655
//   },
//   "-NkeOjgLRsqJUv9chhIv": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2023-12-02 17_30_41.237135",
//     "description": "pani bottol",
//     "timeStamp": 1701518441238
//   },
//   "-NkfHmK5oUir6kSf2Xra": {
//     "Cost": "55",
//     "category": "Food",
//     "dateTime": "2023-12-02 21_39_54.243849",
//     "description": "shev pav",
//     "timeStamp": 1701533394246
//   },
//   "-Nkhiwx6IALIB3XzhIyw": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2023-12-03 09_02_12.229812",
//     "description": "khandi",
//     "timeStamp": 1701574332231
//   },
//   "-NkkDeqeyLnm3-sUwDqm": {
//     "Cost": "450",
//     "category": "Food",
//     "dateTime": "2023-12-03 20_40_01.129612",
//     "description": "pani puri",
//     "timeStamp": 1701616201130
//   },
//   "-NkkfB5_-YoF3ebX_3BY": {
//     "Cost": "80",
//     "category": "General",
//     "dateTime": "2023-12-03 22_44_37.348535",
//     "description": "eye elovera mask",
//     "timeStamp": 1701623677349
//   },
//   "-NkzNyocfDF0LbE9_gQg": {
//     "Cost": "450",
//     "category": "Oasiz",
//     "dateTime": "2023-12-06 19_19_22.599235",
//     "description": "oasis box",
//     "timeStamp": 1701870562600
//   },
//   "-NkzPSQbWV5kmlwlywtX": {
//     "Cost": "3.0",
//     "category": "General",
//     "dateTime": "2023-12-06 19_25_50.118481",
//     "description": "bandage",
//     "timeStamp": 1701870950119
//   },
//   "-Nl1cs2-AHqhfWuBA6lp": {
//     "Cost": "106",
//     "category": "General",
//     "dateTime": "2023-12-07 10_27_40.798515",
//     "description": "petrol",
//     "timeStamp": 1701925060801
//   },
//   "-Nl3mEjsMkeXc6TjaVWm": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2023-12-07 20_27_51.607549",
//     "description": "chips",
//     "timeStamp": 1701961071608
//   },
//   "-Nl3xZx4HXj2t4dziQdu": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2023-12-07 21_17_22.052560",
//     "description": "bulb",
//     "timeStamp": 1701964042054
//   },
//   "-Nl7n_8eEY7GO9Zh_UHl": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-12-08 15_12_10.281",
//     "description": "chips",
//     "timeStamp": 1702028530282
//   },
//   "-Nl8VODVWX-OdozEfIiC": {
//     "Cost": "90",
//     "category": "Food",
//     "dateTime": "2023-12-08 18_27_57.919097",
//     "description": "nasta",
//     "timeStamp": 1702040277921
//   },
//   "-NlCGXoKrCfnLKX1u4-n": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2023-12-09 12_01_33.908270",
//     "description": "davakhana",
//     "timeStamp": 1702103493909
//   },
//   "-NlCHSiUs36-Et_fgOLU": {
//     "Cost": "188",
//     "category": "General",
//     "dateTime": "2023-12-09 12_05_35.198423",
//     "description": "medical",
//     "timeStamp": 1702103735199
//   },
//   "-NlCbh7zzaVSLiCGsn6t": {
//     "Cost": "2175.0",
//     "category": "Udhar dile",
//     "dateTime": "2023-12-09 13_38_23.357962",
//     "description": "udhar dile aai chandukaka saraf",
//     "timeStamp": 1702109303359
//   },
//   "-NlDPSLryrTKNUBbbemz": {
//     "Cost": "160",
//     "category": "Food",
//     "dateTime": "2023-12-09 17_20_08.053687",
//     "description": "nasta",
//     "timeStamp": 1702122608055
//   },
//   "-NlH2d_0ldol1FAul_3C": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2023-12-10 10_18_57.664017",
//     "description": "petrol",
//     "timeStamp": 1702183737665
//   },
//   "-NlHJ9lcSMIHr6Hy7Ru1": {
//     "Cost": "348.0",
//     "category": "General",
//     "dateTime": "2023-12-10 11_31_07.942700",
//     "description": "hotel",
//     "timeStamp": 1702188067944
//   },
//   "-NlJAdmlBSWKejfQdODC": {
//     "Cost": "90",
//     "category": "General",
//     "dateTime": "2023-12-10 20_13_10.127637",
//     "description": "medical",
//     "timeStamp": 1702219390129
//   },
//   "-NlM3TNDinzFAnBgMmmW": {
//     "Cost": "11400",
//     "category": "Bhishi 2",
//     "dateTime": "2023-12-11 09_40_40.013201",
//     "description": "bhishi 8th bhrna",
//     "timeStamp": 1702267840014
//   },
//   "-NlMM1rwH99j-oRUgMyR": {
//     "Cost": "42",
//     "category": "Food",
//     "dateTime": "2023-12-11 11_01_48.091310",
//     "description": "dahi",
//     "timeStamp": 1702272708092
//   },
//   "-NlMM5klDL2HjK2MTDoV": {
//     "Cost": "15",
//     "category": "General",
//     "dateTime": "2023-12-11 11_02_04.016596",
//     "description": "chikat tape",
//     "timeStamp": 1702272724017
//   },
//   "-NlRYNZnHrLeg3MuK9Xs": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2023-12-12 11_13_48.784984",
//     "description": "petrol",
//     "timeStamp": 1702359828787
//   },
//   "-NlRc7MZ3Zmrn_B4aTC2": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2023-12-12 11_34_33.123569",
//     "description": "vadapav",
//     "timeStamp": 1702361073124
//   },
//   "-NlWNiycpX6XB3qNEt-K": {
//     "Cost": "840.0",
//     "category": "Trekking",
//     "dateTime": "2023-12-13 09_45_23.045949",
//     "description": "petrol sandan valley",
//     "timeStamp": 1702440923048
//   },
//   "-NlbRl_tGh6cDXv51N2N": {
//     "Cost": "500",
//     "category": "Trekking",
//     "dateTime": "2023-12-14 14_00_45.624498",
//     "description": "tent +  nasta sandan valley",
//     "timeStamp": 1702542645625
//   },
//   "-NlbS1sXukEoc4H_wGjO": {
//     "Cost": "17000",
//     "category": "Bhishi",
//     "dateTime": "2023-12-14 14_01_56.449512",
//     "description": "bhishi 21th bhrna",
//     "timeStamp": 1702542716450
//   },
//   "-NlblTqmW2j9I8qknw7J": {
//     "Cost": "1220.0",
//     "category": "Udhar dile",
//     "dateTime": "2023-12-14 15_31_13.905749",
//     "description": "kirana udhar dile",
//     "timeStamp": 1702548073906
//   },
//   "-NldBEK6GnyZwyPQYJjz": {
//     "Cost": "90",
//     "category": "Food",
//     "dateTime": "2023-12-14 22_07_45.415079",
//     "description": "icecream",
//     "timeStamp": 1702571865415
//   },
//   "-Nll5eTVgjL4Nw3z4-A3": {
//     "Cost": "270",
//     "category": "General",
//     "dateTime": "2023-12-16 11_00_21.470741",
//     "description": "bsnl sim",
//     "timeStamp": 1702704621472
//   },
//   "-NllCzFUyNIeMNsO4rWT": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2023-12-16 11_32_21.598915",
//     "description": "pani bottol",
//     "timeStamp": 1702706541599
//   },
//   "-NllVOObnw8XZYSAIjgK": {
//     "Cost": "1000",
//     "category": "General",
//     "dateTime": "2023-12-16 12_52_47.270200",
//     "description": "kurta kapde",
//     "timeStamp": 1702711367271
//   },
//   "-Nlln80Ms1Z8jqlN_4Yz": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2023-12-16 14_14_40.918161",
//     "description": "kes cutting",
//     "timeStamp": 1702716280919
//   },
//   "-NlxU0Pw_oQ0GbCK11UL": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2023-12-18 20_42_13.498393",
//     "description": "jalebi",
//     "timeStamp": 1702912333500
//   },
//   "-NlxULLuZpCp9toWqadR": {
//     "Cost": "48",
//     "category": "Food",
//     "dateTime": "2023-12-18 20_43_39.257685",
//     "description": "vadapav",
//     "timeStamp": 1702912419258
//   },
//   "-NlxUddKeVWzwKbdm_04": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2023-12-18 20_44_58.260309",
//     "description": "dhokla",
//     "timeStamp": 1702912498261
//   },
//   "-Nm0XRr0ysFZG43SjAN7": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2023-12-19 15_35_41.184425",
//     "description": "pani bottol",
//     "timeStamp": 1702980341185
//   },
//   "-Nm1x5csw8jrwE9HM2iW": {
//     "Cost": "80",
//     "category": "General",
//     "dateTime": "2023-12-19 22_11_45.269817",
//     "description": "dadhi",
//     "timeStamp": 1703004105272
//   },
//   "-Nm4UqnAmGCPfRLjFrL1": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2023-12-20 10_02_49.866305",
//     "description": "bus ticket",
//     "timeStamp": 1703046769867
//   },
//   "-Nm6PpnNzn4PtX_unM10": {
//     "Cost": "1000",
//     "category": "General",
//     "dateTime": "2023-12-20 19_00_09.495217",
//     "description": "kapde",
//     "timeStamp": 1703079009496
//   },
//   "-Nm6af3TF6rpZ7VnClAv": {
//     "Cost": "200.0",
//     "category": "West",
//     "dateTime": "2023-12-20 19_51_51.261186",
//     "description": "dress fitting",
//     "timeStamp": 1703082111262
//   },
//   "-Nm9LYqyncZCA8MY8Mh_": {
//     "Cost": "90",
//     "category": "Food",
//     "dateTime": "2023-12-21 08_40_19.069224",
//     "description": "nasta",
//     "timeStamp": 1703128219070
//   },
//   "-Nm9OK2DMjrYDPMcYSpO": {
//     "Cost": "101",
//     "category": "General",
//     "dateTime": "2023-12-21 08_52_24.845855",
//     "description": "petrol",
//     "timeStamp": 1703128944846
//   },
//   "-NmBEUT0DlbyJng-7W03": {
//     "Cost": "24",
//     "category": "Food",
//     "dateTime": "2023-12-21 17_28_40.512596",
//     "description": "chaha",
//     "timeStamp": 1703159920513
//   },
//   "-NmBFlkvXmcB63tJvyJR": {
//     "Cost": "45",
//     "category": "Food",
//     "dateTime": "2023-12-21 17_34_17.595066",
//     "description": "food",
//     "timeStamp": 1703160257595
//   },
//   "-NmGF2207_Lo_jpXMm1p": {
//     "Cost": "65",
//     "category": "Food",
//     "dateTime": "2023-12-22 16_49_12.320043",
//     "description": "biscuit",
//     "timeStamp": 1703243952322
//   },
//   "-NmGKUrucR1qVv7r6d-4": {
//     "Cost": "90",
//     "category": "Food",
//     "dateTime": "2023-12-22 17_13_01.112129",
//     "description": "ladi pav",
//     "timeStamp": 1703245381114
//   },
//   "-NmMEz3VncmynmrrhudC": {
//     "Cost": "170",
//     "category": "Food",
//     "dateTime": "2023-12-23 20_46_39.327145",
//     "description": "upvas food",
//     "timeStamp": 1703344599328
//   },
//   "-NmQ5Ar5EfFYOmCPYAcb": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2023-12-24 14_42_19.140563",
//     "description": "medical",
//     "timeStamp": 1703409139142
//   },
//   "-NmQ5vB2Nq0CvvcK4OP2": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2023-12-24 14_45_32.994663",
//     "description": "ladi pav",
//     "timeStamp": 1703409332995
//   },
//   "-NmWF8pPA9rVUBWFsEXK": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2023-12-25 19_23_35.578334",
//     "description": "topi",
//     "timeStamp": 1703512415578
//   },
//   "-NmaACOTdFezbmd5Og8T": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2023-12-26 18_20_05.533092",
//     "description": "pani bottol",
//     "timeStamp": 1703595005534
//   },
//   "-Nmg3vM-TmQEiQcV78Q1": {
//     "Cost": "500",
//     "category": "General",
//     "dateTime": "2023-12-27 21_50_22.078784",
//     "description": "Omkar",
//     "timeStamp": 1703694022080
//   },
//   "-Nmk1DrYNM80e6Ukksyl": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2023-12-28 16_17_04.419242",
//     "description": "Omkar",
//     "timeStamp": 1703760424420
//   },
//   "-NmkYfEI-Monl_ZM_HLs": {
//     "Cost": "413.0",
//     "category": "General",
//     "dateTime": "2023-12-28 18_43_11.377859",
//     "description": "revolt service",
//     "timeStamp": 1703769191379
//   },
//   "-Nml3S2QTqy12bMisV1e": {
//     "Cost": "60",
//     "category": "General",
//     "dateTime": "2023-12-28 21_06_24.027176",
//     "description": "medical",
//     "timeStamp": 1703777784027
//   },
//   "-NmoCPi2ilm_ntjhHptF": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2023-12-29 11_44_25.409786",
//     "description": "pani bottol",
//     "timeStamp": 1703830465411
//   },
//   "-NmoD3xGuyx52xhKWKnN": {
//     "Cost": "54.0",
//     "category": "Food",
//     "dateTime": "2023-12-29 11_47_18.417346",
//     "description": "pohe",
//     "timeStamp": 1703830638419
//   },
//   "-NmtZEkhKU9KH2Z1bK5K": {
//     "Cost": "600.0",
//     "category": "General",
//     "dateTime": "2023-12-30 12_42_15.916233",
//     "description": "plus valley",
//     "timeStamp": 1703920335917
//   },
//   "-Nn07VqcZu7ObfxVYKB2": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2023-12-31 23_58_03.622721",
//     "description": "ots",
//     "timeStamp": 1704047283625
//   },
//   "-Nn4UiAnEd54o5_m1oGk": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-01-01 20_17_56.401290",
//     "description": "pani bottol",
//     "timeStamp": 1704120476403
//   },
//   "-Nn56aIgnYFStzzmqH6j": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2024-01-01 23_12_09.898475",
//     "description": "icecream",
//     "timeStamp": 1704130929900
//   },
//   "-Nn9f9PtyVyJuluKtY8E": {
//     "Cost": "510",
//     "category": "General",
//     "dateTime": "2024-01-02 20_26_01.720278",
//     "description": "wifi recharge",
//     "timeStamp": 1704207361721
//   },
//   "-Nn9wWgJLJIsM5za6xkN": {
//     "Cost": "960",
//     "category": "Food",
//     "dateTime": "2024-01-02 21_41_53.491613",
//     "description": "hotel jevn",
//     "timeStamp": 1704211913492
//   },
//   "-NnDruOjuhTupCovXCJB": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2024-01-03 16_00_12.845330",
//     "description": "medical",
//     "timeStamp": 1704277812847
//   },
//   "-NnHj_vLyxH1-vWFe30C": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2024-01-04 10_02_20.692987",
//     "description": "aai recharge",
//     "timeStamp": 1704342740694
//   },
//   "-NnHjbd9fXg6C8LRRNfS": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2024-01-04 10_02_27.721780",
//     "description": "my recharge",
//     "timeStamp": 1704342747722
//   },
//   "-NnN8y-nt1hVtv0MMOEB": {
//     "Cost": "230",
//     "category": "Food",
//     "dateTime": "2024-01-05 11_15_41.169612",
//     "description": "nasta",
//     "timeStamp": 1704433541171
//   },
//   "-NnNUeLao5t96nRUOQRj": {
//     "Cost": "3500",
//     "category": "Gold bhishi",
//     "dateTime": "2024-01-05 12_50_27.813670",
//     "description": "gold chain",
//     "timeStamp": 1704439227815
//   },
//   "-NnN_fty_diRC5NA4fhf": {
//     "Cost": "500",
//     "category": "General",
//     "dateTime": "2024-01-05 13_16_47.038181",
//     "description": "tent",
//     "timeStamp": 1704440807038
//   },
//   "-NnZtrlx9jEdehk7JjAi": {
//     "Cost": "25",
//     "category": "General",
//     "dateTime": "2024-01-07 22_40_25.148069",
//     "description": "medical",
//     "timeStamp": 1704647425149
//   },
//   "-NnmBDj_Cxu86Tpgsg_G": {
//     "Cost": "177",
//     "category": "Food",
//     "dateTime": "2024-01-10 12_35_41.605315",
//     "description": "nasta",
//     "timeStamp": 1704870341605
//   },
//   "-Nno7mxKkD-uGekhgNZa": {
//     "Cost": "350",
//     "category": "Food",
//     "dateTime": "2024-01-10 21_39_55.795249",
//     "description": "farsan",
//     "timeStamp": 1704902995797
//   },
//   "-NnqoD5o0vEF7EINRpqh": {
//     "Cost": "10600.0",
//     "category": "Bhishi 2",
//     "dateTime": "2024-01-11 10_08_53.619090",
//     "description": "bhishi 2 9th bhrna",
//     "timeStamp": 1704947933620
//   },
//   "-NnqxVCUN8kkmsz_-vrD": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2024-01-11 10_49_27.070388",
//     "description": "room",
//     "timeStamp": 1704950367071
//   },
//   "-Nny9TtIbonk74vzB8Y4": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-01-12 20_23_30.064678",
//     "description": "pani bottol ",
//     "timeStamp": 1705071210067
//   },
//   "-No2loa_voO9195VvwFL": {
//     "Cost": "250",
//     "category": "Food",
//     "dateTime": "2024-01-13 22_33_28.675695",
//     "description": "rajmachi bread pani",
//     "timeStamp": 1705165408677
//   },
//   "-No5pFWspEqpMolyWv0E": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2024-01-14 12_47_21.142961",
//     "description": "tyre wall",
//     "timeStamp": 1705216641145
//   },
//   "-NoAh9OrBkfSQgWRkepd": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-01-15 11_30_04.981190",
//     "description": "vada pav",
//     "timeStamp": 1705298404983
//   },
//   "-NoBRSVG_NG3P8aQuYlc": {
//     "Cost": "20.0",
//     "category": "General",
//     "dateTime": "2024-01-15 14_56_43.983891",
//     "description": "patang",
//     "timeStamp": 1705310803985
//   },
//   "-NoGonGo0sYMV1VjBzYg": {
//     "Cost": "15",
//     "category": "General",
//     "dateTime": "2024-01-16 16_01_10.706523",
//     "description": "Xerox",
//     "timeStamp": 1705401070708
//   },
//   "-NoI5LtqZusLuj9SN7Pl": {
//     "Cost": "1000.0",
//     "category": "Udhar dile",
//     "dateTime": "2024-01-16 21_57_30.291183",
//     "description": "kirana",
//     "timeStamp": 1705422450295
//   },
//   "-NoM_o7f6DaMh-8eke85": {
//     "Cost": "15",
//     "category": "Food",
//     "dateTime": "2024-01-17 18_53_25.354587",
//     "description": "chaha",
//     "timeStamp": 1705497805355
//   },
//   "-NoN3fFTsoP70GvqDcUA": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2024-01-17 21_08_15.452616",
//     "description": "shev",
//     "timeStamp": 1705505895454
//   },
//   "-NoN7A8vPe8GVwQ-Ejoh": {
//     "Cost": "230",
//     "category": "Food",
//     "dateTime": "2024-01-17 21_23_32.538577",
//     "description": "fal",
//     "timeStamp": 1705506812539
//   },
//   "-NoSFXIaTd6zbixYtT3m": {
//     "Cost": "80",
//     "category": "General",
//     "dateTime": "2024-01-18 21_18_10.597651",
//     "description": "dadhi",
//     "timeStamp": 1705592890612
//   },
//   "-NoUzNP9NrKrUn3Qlq-L": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2024-01-19 10_02_05.257051",
//     "description": "medical ",
//     "timeStamp": 1705638725259
//   },
//   "-NoW6-YWBxThVx7nX9kj": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2024-01-19 15_15_01.919134",
//     "description": "chappal",
//     "timeStamp": 1705657501922
//   },
//   "-NoaiyNYSvOECPdsN5Rg": {
//     "Cost": "65.0",
//     "category": "Haridwar",
//     "dateTime": "2024-01-20 17_27_44.865717",
//     "description": "my recharge haridwar ",
//     "timeStamp": 1705751864868
//   },
//   "-Noeb1SuuEQr0Ui2E45E": {
//     "Cost": "17000",
//     "category": "Bhishi",
//     "dateTime": "2024-01-21 11_31_33.305242",
//     "description": "bhishi 22th bhrna",
//     "timeStamp": 1705816893306
//   },
//   "-Nog4P31TTQOkUMkrCMZ": {
//     "Cost": "10.0",
//     "category": "Haridwar",
//     "dateTime": "2024-01-21 18_23_51.488620",
//     "description": "gift haridwar ",
//     "timeStamp": 1705841631501
//   },
//   "-Noga-6A5OgE-KatutFg": {
//     "Cost": "150.0",
//     "category": "Haridwar",
//     "dateTime": "2024-01-21 20_46_15.944836",
//     "description": "rudraksh haridwar ",
//     "timeStamp": 1705850175949
//   },
//   "-NoqXtS7r7XECPKUGqRO": {
//     "Cost": "100.0",
//     "category": "Haridwar",
//     "dateTime": "2024-01-23 19_08_54.407108",
//     "description": "gloves haridwar me",
//     "timeStamp": 1706017134408
//   },
//   "-Noqov7G-uvFz5E5iURS": {
//     "Cost": "50.0",
//     "category": "Haridwar",
//     "dateTime": "2024-01-23 20_27_39.854986",
//     "description": "Shankar pind haridwar me",
//     "timeStamp": 1706021859858
//   },
//   "-Novfv0y8TGkOYOgUbuV": {
//     "Cost": "20",
//     "category": "West",
//     "dateTime": "2024-01-24 19_06_26.236648",
//     "description": "mask",
//     "timeStamp": 1706103386239
//   },
//   "-Novqo46_xXpuGhso7pG": {
//     "Cost": "510",
//     "category": "Haridwar",
//     "dateTime": "2024-01-24 19_54_01.350499",
//     "description": "ram murti me",
//     "timeStamp": 1706106241352
//   },
//   "-Np3J1n6oQ8IG7F9WfuA": {
//     "Cost": "200.0",
//     "category": "Haridwar",
//     "dateTime": "2024-01-26 11_18_41.540186",
//     "description": "dan kashi",
//     "timeStamp": 1706248121550
//   },
//   "-Np9cGKyzQiZdUqEBHR8": {
//     "Cost": "70",
//     "category": "Haridwar",
//     "dateTime": "2024-01-27 16_44_47.292403",
//     "description": "shivling",
//     "timeStamp": 1706354087295
//   },
//   "-NpEFARWagEw-OGKSswx": {
//     "Cost": "9937.0",
//     "category": "Haridwar",
//     "dateTime": "2024-01-28 14_17_37.760323",
//     "description": "haridwar trip cost",
//     "timeStamp": 1706431657762
//   },
//   "-NpVd2UYI6XeE6lVEJmg": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2024-01-31 23_19_51.457563",
//     "description": "dal khichadi ",
//     "timeStamp": 1706723391460
//   },
//   "-NpW70VrUwnrdszBzcKS": {
//     "Cost": "181",
//     "category": "General",
//     "dateTime": "2024-02-01 01_35_09.813701",
//     "description": "my recharge ",
//     "timeStamp": 1706731509821
//   },
//   "-NpYFsvB4_IC0ZlWSmLe": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2024-02-01 11_33_08.363159",
//     "description": "sandy",
//     "timeStamp": 1706767388366
//   },
//   "-NpYK3Z_yLZJrmOAIDJU": {
//     "Cost": "75.0",
//     "category": "Food",
//     "dateTime": "2024-02-01 11_51_24.643156",
//     "description": "nasta",
//     "timeStamp": 1706768484646
//   },
//   "-Npd6gXGbW4rB3K_nQjZ": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2024-02-02 14_50_41.615674",
//     "description": "nasta",
//     "timeStamp": 1706865641618
//   },
//   "-Npe3T0nhDZDCLyCuPl6": {
//     "Cost": "85.0",
//     "category": "Food",
//     "dateTime": "2024-02-02 19_16_12.978232",
//     "description": "nasta",
//     "timeStamp": 1706881572980
//   },
//   "-Npim4ymp25II4rLhBI6": {
//     "Cost": "12.0",
//     "category": "General",
//     "dateTime": "2024-02-03 17_14_01.970113",
//     "description": "medical mami",
//     "timeStamp": 1706960641970
//   },
//   "-NpmzKJXNlU23UfoCCAL": {
//     "Cost": "1200.0",
//     "category": "General",
//     "dateTime": "2024-02-04 12_50_21.537205",
//     "description": "rent agreement ",
//     "timeStamp": 1707031221538
//   },
//   "-Npnq3xoR3cgiTo6tfwK": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2024-02-04 16_49_32.466689",
//     "description": "cafe",
//     "timeStamp": 1707045572468
//   },
//   "-NpovoVMogSN8RZMllx4": {
//     "Cost": "250",
//     "category": "West",
//     "dateTime": "2024-02-04 21_54_15.126476",
//     "description": "farsan",
//     "timeStamp": 1707063855128
//   },
//   "-NpoyCzXll90NHgNGJke": {
//     "Cost": "1715",
//     "category": "Udhar dile",
//     "dateTime": "2024-02-04 22_04_43.810249",
//     "description": "tel + kharik",
//     "timeStamp": 1707064483810
//   },
//   "-NpyDL9Iomrj3NhLAPK7": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2024-02-06 17_11_46.514108",
//     "description": "chips",
//     "timeStamp": 1707219706515
//   },
//   "-NpzSTob_CUZcRh0W_2a": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2024-02-06 22_57_31.366888",
//     "description": "medical",
//     "timeStamp": 1707240451367
//   },
//   "-Nq3Lo5SkjlgmOHVqLc0": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2024-02-07 21_46_29.593515",
//     "description": "bhaje",
//     "timeStamp": 1707322589597
//   },
//   "-NqD_bpFwwKGgeXAHOsX": {
//     "Cost": "250",
//     "category": "Food",
//     "dateTime": "2024-02-09 21_27_23.662328",
//     "description": "cake",
//     "timeStamp": 1707494243664
//   },
//   "-NqDdyo7-VuQEAlAQg4a": {
//     "Cost": "190",
//     "category": "General",
//     "dateTime": "2024-02-09 21_46_26.376255",
//     "description": "harbhara bharda",
//     "timeStamp": 1707495386376
//   },
//   "-NqIQddRjOXBGMVXqgSB": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2024-02-10 20_01_55.739128",
//     "description": "vadapav",
//     "timeStamp": 1707575515740
//   },
//   "-NqM-iZLXYmVGP7iz95p": {
//     "Cost": "56",
//     "category": "Food",
//     "dateTime": "2024-02-11 12_42_46.867989",
//     "description": "dahi tak",
//     "timeStamp": 1707635566870
//   },
//   "-NqM9IOzaWbP-k6aYlgl": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2024-02-11 13_24_37.055343",
//     "description": "hawa",
//     "timeStamp": 1707638077056
//   },
//   "-NqMYA418nTifEFJrC_w": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2024-02-11 15_13_16.545142",
//     "description": "kes",
//     "timeStamp": 1707644596547
//   },
//   "-NqMlbLHfbtMqsB6bsWP": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-02-11 16_16_22.353830",
//     "description": "khari",
//     "timeStamp": 1707648382355
//   },
//   "-NqO6ik7eSp5K-jpAEvn": {
//     "Cost": "11700",
//     "category": "Bhishi 2",
//     "dateTime": "2024-02-11 22_32_37.062193",
//     "description": "bhishi 10th bhrna",
//     "timeStamp": 1707670957064
//   },
//   "-NqT-PQnXGDDcJYM77vO": {
//     "Cost": "200",
//     "category": "Food",
//     "dateTime": "2024-02-12 21_18_44.914445",
//     "description": "chole bhature ",
//     "timeStamp": 1707752924915
//   },
//   "-NqWSNMkvc5o0ye-vMrm": {
//     "Cost": "40",
//     "category": "Kirana",
//     "dateTime": "2024-02-13 13_24_10.287297",
//     "description": "maida",
//     "timeStamp": 1707810850288
//   },
//   "-NqY4KHwewGLfVn6imgK": {
//     "Cost": "4000.0",
//     "category": "West",
//     "dateTime": "2024-02-13 20_58_20.667415",
//     "description": "class fee hibernate",
//     "timeStamp": 1707838100668
//   },
//   "-Nqa6zliJqxajhOFBHIz": {
//     "Cost": "17170",
//     "category": "Bhishi",
//     "dateTime": "2024-02-14 11_08_50.605304",
//     "description": "bhishi 23rd bhrna",
//     "timeStamp": 1707889130606
//   },
//   "-NqfRemPvJMkfeK_BxYR": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2024-02-15 11_57_15.736784",
//     "description": "hawa",
//     "timeStamp": 1707978435739
//   },
//   "-NqfSG4nglWdpseJwjrg": {
//     "Cost": "60",
//     "category": "General",
//     "dateTime": "2024-02-15 11_59_52.626657",
//     "description": "petrol",
//     "timeStamp": 1707978592627
//   },
//   "-NqhNvXXPQ1PFdB-8_jH": {
//     "Cost": "40.0",
//     "category": "General",
//     "dateTime": "2024-02-15 21_00_10.209996",
//     "description": "medical",
//     "timeStamp": 1708011010210
//   },
//   "-Nqq8gQbZecPn749gAsu": {
//     "Cost": "1733",
//     "category": "General",
//     "dateTime": "2024-02-17 13_50_11.110871",
//     "description": "dmart",
//     "timeStamp": 1708158011111
//   },
//   "-NqqBqjsAvoW3OSYw8of": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2024-02-17 14_03_59.800202",
//     "description": "icecream",
//     "timeStamp": 1708158839800
//   },
//   "-NqqqDcgHusR8VcDtPVz": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-02-17 17_04_45.545716",
//     "description": "khari",
//     "timeStamp": 1708169685549
//   },
//   "-NqrQlfd3v-ibC61wde4": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2024-02-17 19_48_48.423513",
//     "description": "pani",
//     "timeStamp": 1708179528425
//   },
//   "-NqrTrfHXYrVttrF_HMT": {
//     "Cost": "40",
//     "category": "General",
//     "dateTime": "2024-02-17 20_02_19.409917",
//     "description": "revolt remote cell",
//     "timeStamp": 1708180339410
//   },
//   "-NqvL1_X9L0_Z1XXpUW8": {
//     "Cost": "77",
//     "category": "Food",
//     "dateTime": "2024-02-18 14_02_13.665703",
//     "description": "chaha",
//     "timeStamp": 1708245133666
//   },
//   "-Nr9ZuCEVnSZgzEJnnBu": {
//     "Cost": "162",
//     "category": "General",
//     "dateTime": "2024-02-21 13_01_29.742436",
//     "description": "medical aai",
//     "timeStamp": 1708500689743
//   },
//   "-Nr9aVfVDKu-bPUQ7l4x": {
//     "Cost": "260",
//     "category": "General",
//     "dateTime": "2024-02-21 13_08_29.471529",
//     "description": "fal",
//     "timeStamp": 1708501109472
//   },
//   "-NrAAkXQJuW5jWdLrhZr": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2024-02-21 15_51_13.753883",
//     "description": "tak",
//     "timeStamp": 1708510873755
//   },
//   "-NrK0DKdd8TuGIwGXMup": {
//     "Cost": "42",
//     "category": "General",
//     "dateTime": "2024-02-23 13_41_24.392490",
//     "description": "kes colour",
//     "timeStamp": 1708675884393
//   },
//   "-NrOU4nSZ3XKyCpTfJTE": {
//     "Cost": "80",
//     "category": "General",
//     "dateTime": "2024-02-24 10_30_22.619524",
//     "description": "dadhi",
//     "timeStamp": 1708750822621
//   },
//   "-NrOoirr4dlazkxFmVaz": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-02-24 12_04_55.861781",
//     "description": "Cadbury",
//     "timeStamp": 1708756495864
//   },
//   "-NrPOWR83_kBNsyz-rJ5": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2024-02-24 14_45_40.168408",
//     "description": "pakit",
//     "timeStamp": 1708766140169
//   },
//   "-NrTitn3ZC-0HKic2zD_": {
//     "Cost": "90",
//     "category": "Food",
//     "dateTime": "2024-02-25 10_57_33.827307",
//     "description": "paneer",
//     "timeStamp": 1708838853828
//   },
//   "-NrZsM8OYDFu3lv4dnsl": {
//     "Cost": "85",
//     "category": "Food",
//     "dateTime": "2024-02-26 15_36_36.632797",
//     "description": "nasta",
//     "timeStamp": 1708941996633
//   },
//   "-NrciFRXwFHZCX2C6D95": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2024-02-27 09_30_56.609378",
//     "description": "petrol",
//     "timeStamp": 1709006456610
//   },
//   "-NrzrA_QJCBEMTw57qut": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-03-02 21_21_11.961766",
//     "description": "vangi",
//     "timeStamp": 1709394671963
//   },
//   "-Ns-C-28TH3ddBHw3xVm": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2024-03-02 22_56_31.879401",
//     "description": "chapati",
//     "timeStamp": 1709400391881
//   },
//   "-Ns-G1naZpgHZA7vMXOw": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2024-03-02 23_14_11.750371",
//     "description": "pani bottol ",
//     "timeStamp": 1709401451751
//   },
//   "-Ns1hk0NWoXusz2gNV3X": {
//     "Cost": "105",
//     "category": "Food",
//     "dateTime": "2024-03-03 10_38_51.415485",
//     "description": "nasta",
//     "timeStamp": 1709442531416
//   },
//   "-Ns1kmvNLOdsW2F5HHr7": {
//     "Cost": "55",
//     "category": "Food",
//     "dateTime": "2024-03-03 10_52_09.751340",
//     "description": "nasta",
//     "timeStamp": 1709443329752
//   },
//   "-Ns1myKXT3Pl03E2hH56": {
//     "Cost": "140",
//     "category": "Food",
//     "dateTime": "2024-03-03 11_01_40.769813",
//     "description": "pineapple",
//     "timeStamp": 1709443900771
//   },
//   "-Ns3g6N8eSCWqMJtgmiV": {
//     "Cost": "70",
//     "category": "General",
//     "dateTime": "2024-03-03 19_50_57.224607",
//     "description": "revolt wash",
//     "timeStamp": 1709475657226
//   },
//   "-Ns7X8beVcWdQzbQUKKF": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-03-04 13_45_53.832894",
//     "description": "tak",
//     "timeStamp": 1709540153835
//   },
//   "-Ns8LZXdN8Kb9WtXuUtH": {
//     "Cost": "150.0",
//     "category": "Food",
//     "dateTime": "2024-03-04 17_34_55.591226",
//     "description": "jevn",
//     "timeStamp": 1709553895593
//   },
//   "-NsCFhPSQ7JbRtVoIb0R": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2024-03-05 11_47_47.932644",
//     "description": "shrikhand",
//     "timeStamp": 1709619467934
//   },
//   "-NsCILakFhG5tFL4QDLX": {
//     "Cost": "2535",
//     "category": "General",
//     "dateTime": "2024-03-05 11_59_20.944356",
//     "description": "revolt insurance",
//     "timeStamp": 1709620160945
//   },
//   "-NsE0ep9RT2QzR7jiN7p": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2024-03-05 20_01_19.625202",
//     "description": "icecream",
//     "timeStamp": 1709649079626
//   },
//   "-NsU1Deex3-Kgg5ZyMhD": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-03-08 22_37_41.865679",
//     "description": "biscuit",
//     "timeStamp": 1709917661867
//   },
//   "-NsU8_yENrFP1yF_q02E": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2024-03-08 23_09_52.333272",
//     "description": "faluda",
//     "timeStamp": 1709919592335
//   },
//   "-NsWbsAdIUiirsY02YpM": {
//     "Cost": "96",
//     "category": "Food",
//     "dateTime": "2024-03-09 10_41_25.672305",
//     "description": "misal",
//     "timeStamp": 1709961085673
//   },
//   "-Nsb93g8xyXgrL6Xf_R3": {
//     "Cost": "170",
//     "category": "Food",
//     "dateTime": "2024-03-10 12_28_55.880416",
//     "description": "misal",
//     "timeStamp": 1710053935881
//   },
//   "-NsczQ4Mz-WHC260sd7A": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2024-03-10 21_01_38.453608",
//     "description": "naral pani",
//     "timeStamp": 1710084698455
//   },
//   "-NsczTu3sufoWKd5yx4J": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2024-03-10 21_01_54.115128",
//     "description": "goli medical",
//     "timeStamp": 1710084714117
//   },
//   "-Nsfo6--x-2CNwhjoZlu": {
//     "Cost": "11500",
//     "category": "Bhishi 2",
//     "dateTime": "2024-03-11 10_11_04.255250",
//     "description": "bhishi 11th bhrna",
//     "timeStamp": 1710132064256
//   },
//   "-NsiX3HqOqaLB7acSSGm": {
//     "Cost": "4000",
//     "category": "General",
//     "dateTime": "2024-03-11 22_51_06.229379",
//     "description": "fees hibernate",
//     "timeStamp": 1710177666230
//   },
//   "-NsqXka8epzyyBvnuyuK": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2024-03-13 12_11_05.415966",
//     "description": "hawa gadi",
//     "timeStamp": 1710312065417
//   },
//   "-NsqXm__Sg7uVfZL3ITD": {
//     "Cost": "70",
//     "category": "Food",
//     "dateTime": "2024-03-13 12_11_13.573147",
//     "description": "juice",
//     "timeStamp": 1710312073573
//   },
//   "-NsqwKd56u29qRtGAX5t": {
//     "Cost": "170",
//     "category": "General",
//     "dateTime": "2024-03-13 14_02_50.757552",
//     "description": "aai recharge",
//     "timeStamp": 1710318770762
//   },
//   "-NsshZv8E2zqnMgdNYHj": {
//     "Cost": "17000",
//     "category": "Bhishi",
//     "dateTime": "2024-03-13 22_17_35.624198",
//     "description": "bhishi 24th bhrna",
//     "timeStamp": 1710348455626
//   },
//   "-Nt1MqugOTTKzGpNYyfB": {
//     "Cost": "5",
//     "category": "General",
//     "dateTime": "2024-03-15 19_18_54.315232",
//     "description": "hawa",
//     "timeStamp": 1710510534316
//   },
//   "-Nt27B79Ps_r3NxVwuDL": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2024-03-15 22_50_04.102543",
//     "description": "icecream",
//     "timeStamp": 1710523204106
//   },
//   "-NtBw5JC2QzBhhRvIC0z": {
//     "Cost": "6400.0",
//     "category": "General",
//     "dateTime": "2024-03-17 20_33_26.731579",
//     "description": "table + chair",
//     "timeStamp": 1710687806733
//   },
//   "-NtC2cNTzgrLfp2ROWF_": {
//     "Cost": "500",
//     "category": "General",
//     "dateTime": "2024-03-17 21_06_21.276674",
//     "description": "tshirt",
//     "timeStamp": 1710689781278
//   },
//   "-NtC43F44wYti16G4mZm": {
//     "Cost": "250",
//     "category": "General",
//     "dateTime": "2024-03-17 21_12_37.572426",
//     "description": "chappal",
//     "timeStamp": 1710690157573
//   },
//   "-NtGQXZdGr2isdKR1wcj": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-03-18 17_29_17.799689",
//     "description": "khari",
//     "timeStamp": 1710763157801
//   },
//   "-NtGvIPd9E9-R97gm9DU": {
//     "Cost": "1096.0",
//     "category": "General",
//     "dateTime": "2024-03-18 19_48_04.327746",
//     "description": "dmart",
//     "timeStamp": 1710771484329
//   },
//   "-NtMJFY9TzA9mwtSY6fD": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2024-03-19 20_55_12.263545",
//     "description": "pineapple",
//     "timeStamp": 1710861912266
//   },
//   "-NtR05sNhTxGb1bYjuFB": {
//     "Cost": "310",
//     "category": "Food",
//     "dateTime": "2024-03-20 18_49_38.006614",
//     "description": "farsan",
//     "timeStamp": 1710940778008
//   },
//   "-NtTcIe1IiL7vhr8qJLd": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2024-03-21 07_00_08.385037",
//     "description": "toll",
//     "timeStamp": 1710984608386
//   },
//   "-NtTpz8lmQmIdDfq-sUl": {
//     "Cost": "140",
//     "category": "Food",
//     "dateTime": "2024-03-21 07_59_54.416988",
//     "description": "nasta",
//     "timeStamp": 1710988194417
//   },
//   "-NtdUBtshFZPbpSCOeBD": {
//     "Cost": "279",
//     "category": "General",
//     "dateTime": "2024-03-23 09_36_10.806935",
//     "description": "kirana",
//     "timeStamp": 1711166770808
//   },
//   "-Ntkmt2yWzRM5JDu5dg_": {
//     "Cost": "40",
//     "category": "General",
//     "dateTime": "2024-03-24 19_39_32.923730",
//     "description": "medical",
//     "timeStamp": 1711289372926
//   },
//   "-NtonxLO_uhSthu2-j2C": {
//     "Cost": "70",
//     "category": "General",
//     "dateTime": "2024-03-25 14_22_41.496453",
//     "description": "gift paper+ katri",
//     "timeStamp": 1711356761497
//   },
//   "-NtonykUcMfMGoWxpAl1": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2024-03-25 14_22_47.262911",
//     "description": "tak",
//     "timeStamp": 1711356767263
//   },
//   "-NtpSROGj8GPEHnOvLS0": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2024-03-25 17_23_56.559796",
//     "description": "icecream",
//     "timeStamp": 1711367636561
//   },
//   "-NtsoY-vD4HttsqAg5bS": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2024-03-26 09_03_44.634383",
//     "description": "gift packet",
//     "timeStamp": 1711424024635
//   },
//   "-NtsyYFMRW-03KLHIxOS": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2024-03-26 09_47_27.063496",
//     "description": "dadhi",
//     "timeStamp": 1711426647063
//   },
//   "-NtuRahxoo77VDjkg8yV": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2024-03-26 16_38_22.780126",
//     "description": "darksh",
//     "timeStamp": 1711451302782
//   },
//   "-NtuXrx1vDjsGYPHXePF": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2024-03-26 17_05_46.241426",
//     "description": "icecream",
//     "timeStamp": 1711452946242
//   },
//   "-Ntw6e3tIFf6Zy34fVAN": {
//     "Cost": "685.0",
//     "category": "Udhar dile",
//     "dateTime": "2024-03-27 00_26_05.944620",
//     "description": "cng shiddu",
//     "timeStamp": 1711479365945
//   },
//   "-NtwBmr4NBPpL60Rcb4v": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2024-03-27 00_48_32.645016",
//     "description": "chaha",
//     "timeStamp": 1711480712645
//   },
//   "-NtyNOBEPMYeqd1V1vDu": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2024-03-27 10_58_27.662018",
//     "description": "omkar jevan",
//     "timeStamp": 1711517307663
//   },
//   "-Ntza2qjY5UkChGehv40": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-03-27 16_37_47.501722",
//     "description": "juce",
//     "timeStamp": 1711537667504
//   },
//   "-Nu3EpgJ9ngBYSfTRmip": {
//     "Cost": "160",
//     "category": "Food",
//     "dateTime": "2024-03-28 14_18_48.403296",
//     "description": "icecream",
//     "timeStamp": 1711615728404
//   },
//   "-Nu3UgrvgA3G_hRATyjY": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-03-28 15_28_06.586820",
//     "description": "juice",
//     "timeStamp": 1711619886587
//   },
//   "-Nu8GSsxOpmGZERU0Lpp": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2024-03-29 13_44_01.276043",
//     "description": "ananas",
//     "timeStamp": 1711700041277
//   },
//   "-Nu9Owk-Uo2NSUW8P6np": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2024-03-29 19_00_42.046355",
//     "description": "hawa",
//     "timeStamp": 1711719042048
//   },
//   "-Nu9QaBaUDAe3YLV1Ebv": {
//     "Cost": "151",
//     "category": "General",
//     "dateTime": "2024-03-29 19_07_53.957983",
//     "description": "petrol",
//     "timeStamp": 1711719473958
//   },
//   "-NuAC7tlHAs08_uVsXQy": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-03-29 22_44_21.168049",
//     "description": "pani bottol",
//     "timeStamp": 1711732461169
//   },
//   "-NuCvNOTuaOaYf81DoBJ": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2024-03-30 11_25_37.693708",
//     "description": "nasta",
//     "timeStamp": 1711778137694
//   },
//   "-NuD-ia_rnmrPqfYWhOH": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2024-03-30 11_48_59.365433",
//     "description": "hawa",
//     "timeStamp": 1711779539365
//   },
//   "-NuD-jxhA8kkE0do5ejb": {
//     "Cost": "90.0",
//     "category": "General",
//     "dateTime": "2024-03-30 11_49_04.941413",
//     "description": ".medical",
//     "timeStamp": 1711779544941
//   },
//   "-NuD7xoUVzdvtzwJ3LZx": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2024-03-30 12_24_58.846962",
//     "description": "nasta",
//     "timeStamp": 1711781698847
//   },
//   "-NuDCZAHNa3OWqheZMdV": {
//     "Cost": "1344.0",
//     "category": "General",
//     "dateTime": "2024-03-30 12_45_04.529346",
//     "description": ".hotel",
//     "timeStamp": 1711782904530
//   },
//   "-NuET64yrxd_O2HtZ-y2": {
//     "Cost": "500",
//     "category": "General",
//     "dateTime": "2024-03-30 18_36_59.068878",
//     "description": "revolt fine omkar",
//     "timeStamp": 1711804019070
//   },
//   "-NuEkAhx6n35B93r_xH7": {
//     "Cost": "105",
//     "category": "Food",
//     "dateTime": "2024-03-30 19_55_56.604626",
//     "description": "pani puri",
//     "timeStamp": 1711808756605
//   },
//   "-NuI-gnRAsId2xppnzmN": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-03-31 11_06_58.075117",
//     "description": "uss ras",
//     "timeStamp": 1711863418077
//   },
//   "-NuPEm1IYW4AnMjpFqJt": {
//     "Cost": "581",
//     "category": "General",
//     "dateTime": "2024-04-01 20_50_12.176813",
//     "description": "wifi recharge",
//     "timeStamp": 1711984812179
//   },
//   "-NuPuy5vg5elezgsfATE": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2024-04-01 23_58_53.817175",
//     "description": "pani bottol",
//     "timeStamp": 1711996133819
//   },
//   "-NuWsosZ6f-zu59VF4wg": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-04-03 08_26_52.259198",
//     "description": "khari",
//     "timeStamp": 1712113012260
//   },
//   "-NuX4BvGilZFJsO-VP2R": {
//     "Cost": "40",
//     "category": "General",
//     "dateTime": "2024-04-03 09_20_56.464329",
//     "description": "swimming",
//     "timeStamp": 1712116256465
//   },
//   "-Nu_4vZsT32n0pax_cL3": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2024-04-03 23_22_59.191392",
//     "description": "pani bottol",
//     "timeStamp": 1712166779193
//   },
//   "-NudhwQKVhiLxDZacBmW": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-04-04 20_56_17.300100",
//     "description": "tak",
//     "timeStamp": 1712244377301
//   },
//   "-NuguRugNsSCMdIcR3Lb": {
//     "Cost": "200.0",
//     "category": "Food",
//     "dateTime": "2024-04-05 11_49_47.756062",
//     "description": "misal",
//     "timeStamp": 1712297987756
//   },
//   "-NuiogmAlDLn5ztlpH5v": {
//     "Cost": "101",
//     "category": "General",
//     "dateTime": "2024-04-05 20_43_54.312366",
//     "description": "petrol",
//     "timeStamp": 1712330034315
//   },
//   "-NumvtJT6oFW3eNT_x-6": {
//     "Cost": "80",
//     "category": "General",
//     "dateTime": "2024-04-06 15_53_49.532191",
//     "description": "punchier",
//     "timeStamp": 1712399029534
//   },
//   "-Nun3f8_Ic0HlafkHMH2": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2024-04-06 16_32_10.788139",
//     "description": "tak",
//     "timeStamp": 1712401330789
//   },
//   "-Nun_aMeNW5FmGKMWeAe": {
//     "Cost": "301",
//     "category": "General",
//     "dateTime": "2024-04-06 18_56_01.960906",
//     "description": "petrol",
//     "timeStamp": 1712409961962
//   },
//   "-Nuo8F2FutT7JtYLFjgQ": {
//     "Cost": "210",
//     "category": "Food",
//     "dateTime": "2024-04-06 21_31_47.727593",
//     "description": "pani bottol",
//     "timeStamp": 1712419307728
//   },
//   "-NuqgwSJIvcBRbnuckSy": {
//     "Cost": "128",
//     "category": "Food",
//     "dateTime": "2024-04-07 09_26_59.091508",
//     "description": "pohe",
//     "timeStamp": 1712462219092
//   },
//   "-Nusy-3FpzC2ocReEpel": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2024-04-07 20_00_44.750092",
//     "description": "kcchi dabeli",
//     "timeStamp": 1712500244752
//   },
//   "-NuxYjFtqeNEKFEI6Tnt": {
//     "Cost": "2334",
//     "category": "General",
//     "dateTime": "2024-04-08 17_24_06.263882",
//     "description": "bachelor party parth",
//     "timeStamp": 1712577246265
//   },
//   "-Nv1LwmHdShal-aE6DQS": {
//     "Cost": "405",
//     "category": "Food",
//     "dateTime": "2024-04-09 15_46_19.857198",
//     "description": "kayani bekri",
//     "timeStamp": 1712657779858
//   },
//   "-Nv2m7xNeVTt_qm1leLF": {
//     "Cost": "200.0",
//     "category": "General",
//     "dateTime": "2024-04-09 22_24_44.822686",
//     "description": "dan",
//     "timeStamp": 1712681684824
//   },
//   "-Nv2mA2fcytwtjIofZEW": {
//     "Cost": "101",
//     "category": "General",
//     "dateTime": "2024-04-09 22_24_53.417433",
//     "description": "petrol",
//     "timeStamp": 1712681693419
//   },
//   "-Nv6nJdd9RQfGg2b-zQL": {
//     "Cost": "2600",
//     "category": "Trip",
//     "dateTime": "2024-04-10 17_08_23.721155",
//     "description": "room rent ratnagiri",
//     "timeStamp": 1712749103721
//   },
//   "-Nv7sGNdV4nAQyqn1FHJ": {
//     "Cost": "11700",
//     "category": "Bhishi 2",
//     "dateTime": "2024-04-10 22_09_38.280786",
//     "description": "bhishi 12th bhrna",
//     "timeStamp": 1712767178281
//   },
//   "-NvCRHDXaxHtiCvUyKdc": {
//     "Cost": "151",
//     "category": "General",
//     "dateTime": "2024-04-11 19_25_27.776230",
//     "description": "dan",
//     "timeStamp": 1712843727778
//   },
//   "-NvHOdpl-tXC01NrInYo": {
//     "Cost": "2500.0",
//     "category": "Trip",
//     "dateTime": "2024-04-12 18_32_04.144056",
//     "description": "room ganpati pule",
//     "timeStamp": 1712926924146
//   },
//   "-NvIOWsyTbw4t3TJYyk7": {
//     "Cost": "91",
//     "category": "General",
//     "dateTime": "2024-04-12 23_11_08.797179",
//     "description": "bappa recharge",
//     "timeStamp": 1712943668798
//   },
//   "-NvMB7I8qHehMMTYJ8Qi": {
//     "Cost": "1800",
//     "category": "Udhar dile",
//     "dateTime": "2024-04-13 16_51_04.968006",
//     "description": "ambe ravi 1800",
//     "timeStamp": 1713007264969
//   },
//   "-NvPdsLFvz6nZlIk24BJ": {
//     "Cost": "17500",
//     "category": "Bhishi",
//     "dateTime": "2024-04-14 08_59_55.599379",
//     "description": "bhishi 25th bhrna",
//     "timeStamp": 1713065395600
//   },
//   "-NvXJEymGPeqJjoPgJBV": {
//     "Cost": "15",
//     "category": "Food",
//     "dateTime": "2024-04-15 20_42_22.960744",
//     "description": "tak",
//     "timeStamp": 1713193942962
//   },
//   "-NvlRbCkjgzL7J3ys7KZ": {
//     "Cost": "828",
//     "category": "General",
//     "dateTime": "2024-04-18 19_13_13.519198",
//     "description": "revolt service",
//     "timeStamp": 1713447793520
//   },
//   "-NvlnP0W21BN-W1nC6OM": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2024-04-18 20_52_48.800922",
//     "description": "juce",
//     "timeStamp": 1713453768801
//   },
//   "-Nw-PiLDUsrhJNB20AMO": {
//     "Cost": "220",
//     "category": "Food",
//     "dateTime": "2024-04-21 16_59_16.684462",
//     "description": "jevn",
//     "timeStamp": 1713698956686
//   },
//   "-Nw-lVdqLG5z301OkqZJ": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2024-04-21 18_38_49.909131",
//     "description": "tak",
//     "timeStamp": 1713704929911
//   },
//   "-Nw0O1JvwRKINsVrIjdu": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2024-04-21 21_31_31.450148",
//     "description": "chips",
//     "timeStamp": 1713715291451
//   },
//   "-Nw3sZZwpG3P3A7BgC6L": {
//     "Cost": "1000",
//     "category": "General",
//     "dateTime": "2024-04-22 13_48_09.851329",
//     "description": "yatra vargani",
//     "timeStamp": 1713773889852
//   },
//   "-Nw9OCegj_6MGgm-I5nK": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2024-04-23 15_28_52.843309",
//     "description": "aai recharge",
//     "timeStamp": 1713866332844
//   },
//   "-NwABx7uP5seUz0dTcpO": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2024-04-23 19_14_56.632376",
//     "description": "naral mandir",
//     "timeStamp": 1713879896635
//   },
//   "-NwAI1Vba_dY5zkYo2j5": {
//     "Cost": "30.0",
//     "category": "General",
//     "dateTime": "2024-04-23 19_41_31.493762",
//     "description": "tambyachi anghti",
//     "timeStamp": 1713881491495
//   },
//   "-NwKCDQytzS5X_lBU86g": {
//     "Cost": "80",
//     "category": "General",
//     "dateTime": "2024-04-25 17_52_19.644798",
//     "description": "dadhi",
//     "timeStamp": 1714047739646
//   },
//   "-NwUKf5ebwXlTU0lcssf": {
//     "Cost": "180",
//     "category": "General",
//     "dateTime": "2024-04-27 17_05_26.377131",
//     "description": "pani bottol kailasgad",
//     "timeStamp": 1714217726378
//   },
//   "-NwZ-9zyamgWOD3wYiob": {
//     "Cost": "364",
//     "category": "Food",
//     "dateTime": "2024-04-28 14_49_35.932916",
//     "description": "jevn",
//     "timeStamp": 1714295975934
//   },
//   "-NwnA0eT7sZpBYheh1M3": {
//     "Cost": "240",
//     "category": "Food",
//     "dateTime": "2024-05-01 13_31_19.517225",
//     "description": "icecream",
//     "timeStamp": 1714550479518
//   },
//   "-NwtxVKqgqegOmrU9oQw": {
//     "Cost": "306",
//     "category": "Food",
//     "dateTime": "2024-05-02 21_09_35.669403",
//     "description": "jevn",
//     "timeStamp": 1714664375670
//   },
//   "-Nx1SL3lsEUekaS78Z_J": {
//     "Cost": "101",
//     "category": "General",
//     "dateTime": "2024-05-04 12_45_39.950664",
//     "description": "petrol",
//     "timeStamp": 1714806939953
//   },
//   "-Nx6LVcfRLgtcCndtN_O": {
//     "Cost": "100.0",
//     "category": "General",
//     "dateTime": "2024-05-05 11_33_54.281771",
//     "description": "parking jejuri",
//     "timeStamp": 1714889034283
//   },
//   "-Nx8QaoaWybopX5sJGVJ": {
//     "Cost": "390",
//     "category": "Food",
//     "dateTime": "2024-05-05 21_15_24.772332",
//     "description": "farsan",
//     "timeStamp": 1714923924774
//   },
//   "-NxO6UBlURbi4AM6UBwQ": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2024-05-08 22_21_26.129077",
//     "description": "petrol",
//     "timeStamp": 1715187086129
//   },
//   "-NxO9AapSrtcBavf45F3": {
//     "Cost": "500",
//     "category": "Food",
//     "dateTime": "2024-05-08 22_33_12.309415",
//     "description": "ambe",
//     "timeStamp": 1715187792309
//   },
//   "-Nx_gq1dth4tbzLL5geH": {
//     "Cost": "12000",
//     "category": "Bhishi 2",
//     "dateTime": "2024-05-11 09_00_05.608655",
//     "description": "bhishi 13th bhrna",
//     "timeStamp": 1715398205609
//   },
//   "-Nxay9hCUhg8H5LslJvN": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2024-05-11 14_55_23.916527",
//     "description": "petrol",
//     "timeStamp": 1715419523917
//   },
//   "-NxbsPV3uE6XYZ800wK4": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2024-05-11 19_09_52.964317",
//     "description": "vadapav",
//     "timeStamp": 1715434792964
//   },
//   "-Nxfld1lH6vrjc-tDmQ_": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2024-05-12 13_18_46.383243",
//     "description": "petrol",
//     "timeStamp": 1715500126385
//   },
//   "-NxfxMH7S8YOcg7y1kzY": {
//     "Cost": "270",
//     "category": "Food",
//     "dateTime": "2024-05-12 14_09_59.367694",
//     "description": "nasta",
//     "timeStamp": 1715503199368
//   },
//   "-Nxm5WGaVkxO4Bwf9Fg0": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2024-05-13 18_47_42.885165",
//     "description": "kes",
//     "timeStamp": 1715606262886
//   },
//   "-Ny-C5yJTSRI5IbUR5-m": {
//     "Cost": "200000.0",
//     "category": "General",
//     "dateTime": "2024-05-16 12_31_11.187354",
//     "description": "dehu plot ",
//     "timeStamp": 1715842871189
//   },
//   "-Ny-Gsuk4-sXN74qVdmC": {
//     "Cost": "160",
//     "category": "Food",
//     "dateTime": "2024-05-16 12_52_04.335194",
//     "description": "shrikhand",
//     "timeStamp": 1715844124336
//   },
//   "-Ny1IFm0RCcQYz_Ebl78": {
//     "Cost": "525",
//     "category": "Food",
//     "dateTime": "2024-05-16 22_17_18.655411",
//     "description": "jevn hotel",
//     "timeStamp": 1715878038657
//   },
//   "-Ny7MB4LdmJV89pnfuit": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2024-05-18 02_32_11.285247",
//     "description": "nasta",
//     "timeStamp": 1715979731287
//   },
//   "-NyAeTlkPQuILs_GzavG": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2024-05-18 17_55_20.239341",
//     "description": "chips",
//     "timeStamp": 1716035120240
//   },
//   "-NyBO6_tGGnWPTL2-7TW": {
//     "Cost": "405",
//     "category": "Food",
//     "dateTime": "2024-05-18 21_19_06.040744",
//     "description": "pavbhaji",
//     "timeStamp": 1716047346041
//   },
//   "-NyEqgngTt5yV50z6I0c": {
//     "Cost": "176",
//     "category": "Food",
//     "dateTime": "2024-05-19 13_27_12.299123",
//     "description": "jevn",
//     "timeStamp": 1716105432301
//   },
//   "-NyErgzkpBbw1nbzoWV8": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2024-05-19 13_31_35.215677",
//     "description": "roll",
//     "timeStamp": 1716105695216
//   },
//   "-NyGZlTjgHaiWMaDLO4d": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2024-05-19 21_28_07.277871",
//     "description": "chips",
//     "timeStamp": 1716134287280
//   },
//   "-NyRQleoRQ_o6LvrRlpd": {
//     "Cost": "213",
//     "category": "Food",
//     "dateTime": "2024-05-22 00_04_38.130897",
//     "description": "cafe",
//     "timeStamp": 1716316478132
//   },
//   "-NyVtJaXP4u_JBjQzg1v": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2024-05-22 20_52_12.257516",
//     "description": "vadapav",
//     "timeStamp": 1716391332258
//   },
//   "-NyW2FKo88j6ZlHBkBK2": {
//     "Cost": "120",
//     "category": "General",
//     "dateTime": "2024-05-22 21_35_36.244294",
//     "description": "phone cover",
//     "timeStamp": 1716393936244
//   },
//   "-NyjA2cenT-nntlxGuRY": {
//     "Cost": "150.0",
//     "category": "Food",
//     "dateTime": "2024-05-25 15_24_22.377770",
//     "description": "sandwich",
//     "timeStamp": 1716630862378
//   },
//   "-NyoH1D_TIEls5KMLp2i": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-05-26 15_12_57.700016",
//     "description": "pani bottol",
//     "timeStamp": 1716716577701
//   },
//   "-Nyoc5_a_MQxmat12LBJ": {
//     "Cost": "140",
//     "category": "Food",
//     "dateTime": "2024-05-26 16_49_22.725609",
//     "description": "nasta",
//     "timeStamp": 1716722362727
//   },
//   "-NypQxwhz4MO7gov1PZ1": {
//     "Cost": "500",
//     "category": "Udhar dile",
//     "dateTime": "2024-05-26 20_35_58.827755",
//     "description": "bapu mama",
//     "timeStamp": 1716735958829
//   },
//   "-Nyto1c470D_FowpERDe": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2024-05-27 16_59_38.307964",
//     "description": "hawa",
//     "timeStamp": 1716809378310
//   },
//   "-Nytsc8fl67vVyTpsWGH": {
//     "Cost": "650.0",
//     "category": "General",
//     "dateTime": "2024-05-27 17_19_40.587068",
//     "description": "camera Sony",
//     "timeStamp": 1716810580587
//   },
//   "-Nyz4qI2wkkqawNpZEub": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2024-05-28 17_35_32.482916",
//     "description": "aai recharge",
//     "timeStamp": 1716897932483
//   },
//   "-Nz3ixOzbnZ9j7-UKN9s": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2024-05-29 19_53_15.581579",
//     "description": "dhokla chatni",
//     "timeStamp": 1716992595583
//   },
//   "-Nz7M65OuOCia9J34H2X": {
//     "Cost": "12",
//     "category": "General",
//     "dateTime": "2024-05-30 12_47_32.696209",
//     "description": "blead",
//     "timeStamp": 1717053452697
//   },
//   "-NzC_1xrM4PnuM33wO-S": {
//     "Cost": "150",
//     "category": "Food",
//     "dateTime": "2024-05-31 13_06_31.862605",
//     "description": "juice",
//     "timeStamp": 1717140991863
//   },
//   "-NzGqo9GoggIyp0wqSLV": {
//     "Cost": "145",
//     "category": "General",
//     "dateTime": "2024-06-01 09_02_38.672392",
//     "description": "medical",
//     "timeStamp": 1717212758673
//   },
//   "-NzH-C40KFV4E06gbo8j": {
//     "Cost": "210",
//     "category": "General",
//     "dateTime": "2024-06-01 09_43_40.033153",
//     "description": "petrol",
//     "timeStamp": 1717215220033
//   },
//   "-NzIQHiM40uopEnh_yLT": {
//     "Cost": "500.0",
//     "category": "General",
//     "dateTime": "2024-06-01 16_21_38.260315",
//     "description": "hotel",
//     "timeStamp": 1717239098263
//   },
//   "-NzITrzqxPYvosaClbl7": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-06-01 16_37_17.366211",
//     "description": "tak",
//     "timeStamp": 1717240037366
//   },
//   "-NzOJiddn_xDlvsl8zhl": {
//     "Cost": "34",
//     "category": "Food",
//     "dateTime": "2024-06-02 19_50_40.935790",
//     "description": "oats",
//     "timeStamp": 1717338040938
//   },
//   "-NzOJovN-HjzMlY6TU8j": {
//     "Cost": "1440",
//     "category": "Udhar dile",
//     "dateTime": "2024-06-02 19_51_06.646836",
//     "description": "tandul",
//     "timeStamp": 1717338066648
//   },
//   "-NzUH76Fw_YWxYw32IGF": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-06-03 23_37_02.095363",
//     "description": "kulfi",
//     "timeStamp": 1717438022096
//   },
//   "-NzZFh_6gWn20feqTqsA": {
//     "Cost": "25",
//     "category": "Food",
//     "dateTime": "2024-06-04 22_48_57.350032",
//     "description": "kulfi",
//     "timeStamp": 1717521537352
//   },
//   "-NzdMR48m6MnyYd7YmB-": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-06-05 22_36_26.759801",
//     "description": "kulfi",
//     "timeStamp": 1717607186761
//   },
//   "-Nzgfn-u8m5knoZlmYUU": {
//     "Cost": "22",
//     "category": "Food",
//     "dateTime": "2024-06-06 14_04_15.225274",
//     "description": "oats",
//     "timeStamp": 1717662855227
//   },
//   "-Nzn2f0PDcWmYaY_L8Mz": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2024-06-07 19_46_17.240787",
//     "description": "petrol",
//     "timeStamp": 1717769777242
//   },
//   "-NznJcFhV7gUHrQ1vzXS": {
//     "Cost": "350.0",
//     "category": "Food",
//     "dateTime": "2024-06-07 21_00_22.381182",
//     "description": "pavbhaji",
//     "timeStamp": 1717774222381
//   },
//   "-NznW3HiTjMxSCtRIAWn": {
//     "Cost": "230",
//     "category": "Food",
//     "dateTime": "2024-06-07 21_54_42.925844",
//     "description": "mastani",
//     "timeStamp": 1717777482926
//   },
//   "-O--ukUdAmhUKGlBf037": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2024-06-10 12_22_01.384213",
//     "description": "cell",
//     "timeStamp": 1718002321385
//   },
//   "-O-2BPtMccA_k1gA0yHh": {
//     "Cost": "75",
//     "category": "Food",
//     "dateTime": "2024-06-10 22_58_25.941430",
//     "description": "kulfi",
//     "timeStamp": 1718040505943
//   },
//   "-O-4vS0TccJTScJClgso": {
//     "Cost": "12100.0",
//     "category": "Bhishi 2",
//     "dateTime": "2024-06-11 11_43_09.852539",
//     "description": "bhishi 14th bhrna",
//     "timeStamp": 1718086389855
//   },
//   "-O-6paPYXa-W1r3k_gPt": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2024-06-11 20_36_49.890558",
//     "description": "patrika",
//     "timeStamp": 1718118409891
//   },
//   "-O-6qPsFOxyJlrSN4PTC": {
//     "Cost": "160",
//     "category": "Food",
//     "dateTime": "2024-06-11 20_40_24.784015",
//     "description": "sonpapdi",
//     "timeStamp": 1718118624784
//   },
//   "-O-CCZf2ggPXXosmO1gB": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-06-12 21_39_40.290002",
//     "description": "kulfi",
//     "timeStamp": 1718208580291
//   },
//   "-O-Evyo3XbTrViCCQvbF": {
//     "Cost": "91",
//     "category": "General",
//     "dateTime": "2024-06-13 10_21_40.419037",
//     "description": "bappa recharge",
//     "timeStamp": 1718254300420
//   },
//   "-O-FI71VGz4a7f08bAV7": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2024-06-13 12_02_47.519296",
//     "description": "vadapav",
//     "timeStamp": 1718260367520
//   },
//   "-O-KZg3l3uNaID7AJYeL": {
//     "Cost": "283",
//     "category": "General",
//     "dateTime": "2024-06-14 12_37_37.647724",
//     "description": "hospital",
//     "timeStamp": 1718348857649
//   },
//   "-O-MWp-t-ytTVZujQa0G": {
//     "Cost": "24",
//     "category": "General",
//     "dateTime": "2024-06-14 21_44_22.264450",
//     "description": "Minecraft",
//     "timeStamp": 1718381662265
//   },
//   "-O-R8kQIYu77Q-Pg15Zl": {
//     "Cost": "17780",
//     "category": "Bhishi",
//     "dateTime": "2024-06-15 19_17_18.097053",
//     "description": "bhishi 27th bhrna",
//     "timeStamp": 1718459238099
//   },
//   "-O-RUb5-gbjuSLhF_nmf": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2024-06-15 20_52_47.038725",
//     "description": "dan",
//     "timeStamp": 1718464967040
//   },
//   "-O-UbCL5o12RvleViIay": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2024-06-16 11_24_50.374299",
//     "description": "nasta",
//     "timeStamp": 1718517290374
//   },
//   "-O-W3jSOOoMbJgjs2seJ": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2024-06-16 18_13_29.495682",
//     "description": "vadapav",
//     "timeStamp": 1718541809498
//   },
//   "-O-ewmruy_SHHK1EJNV3": {
//     "Cost": "1500",
//     "category": "General",
//     "dateTime": "2024-06-18 16_14_58.489607",
//     "description": "IRT file",
//     "timeStamp": 1718707498490
//   },
//   "-O048tzE16lwKYzHw46-": {
//     "Cost": "1900",
//     "category": "General",
//     "dateTime": "2024-06-23 18_22_23.114546",
//     "description": "jivdhan trip",
//     "timeStamp": 1719147143120
//   },
//   "-O0EhSOLBuGQQRx2JoT9": {
//     "Cost": "350",
//     "category": "Food",
//     "dateTime": "2024-06-25 19_33_55.348608",
//     "description": "chips",
//     "timeStamp": 1719324235361
//   },
//   "-O0Eis6JpzhI_MYDaD6E": {
//     "Cost": "2000",
//     "category": "Udhar dile",
//     "dateTime": "2024-06-25 19_40_06.931598",
//     "description": "kirana",
//     "timeStamp": 1719324606932
//   },
//   "-O0F4jrwvneoZ9NZmvcd": {
//     "Cost": "5",
//     "category": "Food",
//     "dateTime": "2024-06-25 21_20_02.491514",
//     "description": "coffee chocolate",
//     "timeStamp": 1719330602492
//   },
//   "-O0Jup6dhajtJc3rRPr6": {
//     "Cost": "850",
//     "category": "General",
//     "dateTime": "2024-06-26 19_50_26.472310",
//     "description": "pant",
//     "timeStamp": 1719411626473
//   },
//   "-O0Odhj27SrfP4TEzzlY": {
//     "Cost": "179",
//     "category": "General",
//     "dateTime": "2024-06-27 17_53_45.857474",
//     "description": "my recharge",
//     "timeStamp": 1719491025859
//   },
//   "-O0P6fq3QoPR8pFN_-WI": {
//     "Cost": "375",
//     "category": "General",
//     "dateTime": "2024-06-27 20_04_42.434397",
//     "description": "tshirt ",
//     "timeStamp": 1719498882436
//   },
//   "-O0XkzjZ1u7iTMgq7LBg": {
//     "Cost": "35",
//     "category": "Food",
//     "dateTime": "2024-06-29 12_22_09.570215",
//     "description": "nasta",
//     "timeStamp": 1719643929572
//   },
//   "-O0ZM-9T3mr0ICFw8Pbw": {
//     "Cost": "75",
//     "category": "Food",
//     "dateTime": "2024-06-29 19_47_49.980278",
//     "description": "nasta",
//     "timeStamp": 1719670669982
//   },
//   "-O0a13rY5NKvjNs9zAuA": {
//     "Cost": "600",
//     "category": "General",
//     "dateTime": "2024-06-30 03_35_38.658238",
//     "description": "dan",
//     "timeStamp": 1719698738660
//   },
//   "-O0a8e87DZmU9YfCVyAB": {
//     "Cost": "185",
//     "category": "Food",
//     "dateTime": "2024-06-30 04_08_46.342619",
//     "description": "nasta",
//     "timeStamp": 1719700726344
//   },
//   "-O0cMrJYmQmIUmM-jqjc": {
//     "Cost": "181",
//     "category": "General",
//     "dateTime": "2024-06-30 14_30_04.769327",
//     "description": "aai recharge",
//     "timeStamp": 1719738004773
//   },
//   "-O0ggbm9otuAMqmrHCQA": {
//     "Cost": "436",
//     "category": "General",
//     "dateTime": "2024-07-01 10_39_15.016953",
//     "description": "wifi recharge",
//     "timeStamp": 1719810555018
//   },
//   "-O0j1JCmNUTFcQlnhOGH": {
//     "Cost": "250",
//     "category": "Food",
//     "dateTime": "2024-07-01 21_33_16.464762",
//     "description": "cake",
//     "timeStamp": 1719849796466
//   },
//   "-O0nl3AibwCcxdV_Zi3y": {
//     "Cost": "300",
//     "category": "Food",
//     "dateTime": "2024-07-02 19_36_00.428602",
//     "description": "cake",
//     "timeStamp": 1719929160430
//   },
//   "-O0nmKA54oF6oSDXFFpl": {
//     "Cost": "21",
//     "category": "Food",
//     "dateTime": "2024-07-02 19_41_32.166171",
//     "description": "chapati",
//     "timeStamp": 1719929492166
//   },
//   "-O0t1WQGr5Zp4TCZi_ae": {
//     "Cost": "527",
//     "category": "General",
//     "dateTime": "2024-07-03 20_10_22.735319",
//     "description": "revolt",
//     "timeStamp": 1720017622737
//   },
//   "-O0t1cZVDLxnorrTldRK": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2024-07-03 20_10_52.000007",
//     "description": "biryani",
//     "timeStamp": 1720017652000
//   },
//   "-O12ftJ4yjH-i_cV8w0Y": {
//     "Cost": "85",
//     "category": "General",
//     "dateTime": "2024-07-05 21_47_20.643558",
//     "description": "move",
//     "timeStamp": 1720196240645
//   },
//   "-O12fvdZGiU2VHlKb6nC": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2024-07-05 21_47_30.211745",
//     "description": "sprite",
//     "timeStamp": 1720196250212
//   },
//   "-O1AmHhXjSWJXmZO_C9j": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2024-07-07 11_32_15.264520",
//     "description": "kes cutting",
//     "timeStamp": 1720332135266
//   },
//   "-O1BIL_3RpKuyizBn4K1": {
//     "Cost": "750",
//     "category": "General",
//     "dateTime": "2024-07-07 13_56_41.858519",
//     "description": "aai chashma",
//     "timeStamp": 1720340801860
//   },
//   "-O1CvUVJqwb4bbpccC7N": {
//     "Cost": "775",
//     "category": "Food",
//     "dateTime": "2024-07-07 21_31_41.395267",
//     "description": "jevn",
//     "timeStamp": 1720368101397
//   },
//   "-O1GhJrPyhnHDxeHMZ1G": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2024-07-08 15_08_16.666157",
//     "description": "chips",
//     "timeStamp": 1720431496666
//   },
//   "-O1LfSmGyyBR6ZCPLRRL": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2024-07-09 14_18_14.991244",
//     "description": "card reader",
//     "timeStamp": 1720514894993
//   },
//   "-O1LiokDpBIh21vLVJFp": {
//     "Cost": "51",
//     "category": "Food",
//     "dateTime": "2024-07-09 14_32_55.501901",
//     "description": "vadapav",
//     "timeStamp": 1720515775502
//   },
//   "-O1RvMGp5dcPoJ73epdD": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2024-07-10 19_25_25.939084",
//     "description": "petrol",
//     "timeStamp": 1720619725941
//   },
//   "-O1SdhMvbAptxgxqc9cO": {
//     "Cost": "17",
//     "category": "General",
//     "dateTime": "2024-07-10 22_47_55.064913",
//     "description": "medical",
//     "timeStamp": 1720631875067
//   },
//   "-O1Se7Z1pUXyN-nLBzS1": {
//     "Cost": "12650.0",
//     "category": "Bhishi 2",
//     "dateTime": "2024-07-10 22_49_46.433467",
//     "description": "bhishi 15th bharna",
//     "timeStamp": 1720631986434
//   },
//   "-O1XHjlVXjklw61u0lVb": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-07-11 20_25_41.663241",
//     "description": "pani bottol ",
//     "timeStamp": 1720709741664
//   },
//   "-O1XM-Ej4E3LhjN815St": {
//     "Cost": "130",
//     "category": "Food",
//     "dateTime": "2024-07-11 20_44_17.710369",
//     "description": "jevn",
//     "timeStamp": 1720710857711
//   },
//   "-O1XSSndqrY1Lfp72y9R": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-07-11 21_12_31.656549",
//     "description": "medical",
//     "timeStamp": 1720712551657
//   },
//   "-O1bh_ZtNMGO_11aAVm-": {
//     "Cost": "4000.0",
//     "category": "General",
//     "dateTime": "2024-07-12 21_41_03.864741",
//     "description": "kapde raincoat",
//     "timeStamp": 1720800663866
//   },
//   "-O1bhe5ds0Euo-oispWr": {
//     "Cost": "128",
//     "category": "Food",
//     "dateTime": "2024-07-12 21_41_22.408683",
//     "description": "bekary",
//     "timeStamp": 1720800682409
//   },
//   "-O1f62bpsI0DNsIDzVlP": {
//     "Cost": "895",
//     "category": "General",
//     "dateTime": "2024-07-13 13_31_12.179770",
//     "description": "omya kapde pant",
//     "timeStamp": 1720857672184
//   },
//   "-O1g-g4UWcql-mtvqY3L": {
//     "Cost": "500",
//     "category": "General",
//     "dateTime": "2024-07-13 17_43_00.127059",
//     "description": "bai",
//     "timeStamp": 1720872780127
//   },
//   "-O1kB-tUe-OAfm0d4g_h": {
//     "Cost": "70",
//     "category": "General",
//     "dateTime": "2024-07-14 13_10_57.821919",
//     "description": "dadhi",
//     "timeStamp": 1720942857823
//   },
//   "-O1kKokqX1rHa7yCUzD_": {
//     "Cost": "75",
//     "category": "Food",
//     "dateTime": "2024-07-14 13_53_49.557251",
//     "description": "tak",
//     "timeStamp": 1720945429558
//   },
//   "-O1lCTg4sjwczub46YZa": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2024-07-14 17_56_59.204364",
//     "description": "petrol",
//     "timeStamp": 1720960019205
//   },
//   "-O1lIjEX_lvKsOBO-MLy": {
//     "Cost": "180",
//     "category": "Food",
//     "dateTime": "2024-07-14 18_24_19.873941",
//     "description": "pasta",
//     "timeStamp": 1720961659875
//   },
//   "-O1pSLDnLldBVpWWV5z5": {
//     "Cost": "91",
//     "category": "General",
//     "dateTime": "2024-07-15 13_44_47.730037",
//     "description": "bappa recharge",
//     "timeStamp": 1721031287731
//   },
//   "-O1qKGPLNKcvi4ypGW3B": {
//     "Cost": "17900",
//     "category": "Bhishi",
//     "dateTime": "2024-07-15 17_49_08.052383",
//     "description": "bhishi 28th bharna",
//     "timeStamp": 1721045948054
//   },
//   "-O1qO3jH1qRFd-1m-Q1H": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2024-07-15 18_05_44.720447",
//     "description": "bai ajji",
//     "timeStamp": 1721046944722
//   },
//   "-O1rQXzSZEk_ix2jZNuc": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2024-07-15 22_56_10.139836",
//     "description": "kulfi",
//     "timeStamp": 1721064370141
//   },
//   "-O2-vvpHmkquYvU1Vi6L": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2024-07-17 19_14_15.441153",
//     "description": "chaha",
//     "timeStamp": 1721223855443
//   },
//   "-O25JFb-8Un45L5DTE_m": {
//     "Cost": "750",
//     "category": "General",
//     "dateTime": "2024-07-18 20_18_38.078362",
//     "description": "pappa",
//     "timeStamp": 1721314118081
//   },
//   "-O28vB-X1z69qVGt27WX": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2024-07-19 13_07_34.497324",
//     "description": "petrol",
//     "timeStamp": 1721374654498
//   },
//   "-O2EKgap9dL-PIY4MLzU": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2024-07-20 14_21_29.844318",
//     "description": "petrol",
//     "timeStamp": 1721465489845
//   },
//   "-O2IrEg_Cr4ewApDH9ji": {
//     "Cost": "230",
//     "category": "Food",
//     "dateTime": "2024-07-21 11_26_33.189387",
//     "description": "nasta",
//     "timeStamp": 1721541393189
//   },
//   "-O2Obw-bXeRPMqI-5PDy": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2024-07-22 14_17_23.685704",
//     "description": "petrol",
//     "timeStamp": 1721638043687
//   },
//   "-O2OjkRctn4tvoqUL-yF": {
//     "Cost": "345",
//     "category": "Food",
//     "dateTime": "2024-07-22 14_51_33.479225",
//     "description": "pavbhaji",
//     "timeStamp": 1721640093480
//   },
//   "-O2jBYlEYgYslYQqBD4k": {
//     "Cost": "151",
//     "category": "General",
//     "dateTime": "2024-07-26 18_49_25.261394",
//     "description": "petrol",
//     "timeStamp": 1721999965263
//   },
//   "-O2sn_zcG8eYg3brEPJW": {
//     "Cost": "115",
//     "category": "Food",
//     "dateTime": "2024-07-28 15_36_32.934143",
//     "description": "nasta",
//     "timeStamp": 1722161192936
//   },
//   "-O2tZsaPHzh_7-G6PqFJ": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2024-07-28 19_11_54.201639",
//     "description": "petrol",
//     "timeStamp": 1722174114203
//   },
//   "-O2tvrvS8qXCprsa7goN": {
//     "Cost": "230",
//     "category": "Food",
//     "dateTime": "2024-07-28 20_52_20.765259",
//     "description": "jevn",
//     "timeStamp": 1722180140765
//   },
//   "-O2xEhT6H9XEAceM-MZN": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2024-07-29 12_17_52.454707",
//     "description": "my recharge",
//     "timeStamp": 1722235672455
//   },
//   "-O2z3muJR2Vy5Yg9Gkrr": {
//     "Cost": "1000",
//     "category": "General",
//     "dateTime": "2024-07-29 20_49_25.586866",
//     "description": "treking bag",
//     "timeStamp": 1722266365588
//   },
//   "-O3ByxbdUZ7KglL7v5I7": {
//     "Cost": "35",
//     "category": "Food",
//     "dateTime": "2024-08-01 13_38_37.607661",
//     "description": "chips",
//     "timeStamp": 1722499717609
//   },
//   "-O3IbHACaegh0FNRsiNi": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2024-08-02 20_32_30.859746",
//     "description": "petrol",
//     "timeStamp": 1722610950861
//   },
//   "-O3NCc6Nh6cJwrbRa4A6": {
//     "Cost": "22",
//     "category": "Food",
//     "dateTime": "2024-08-03 17_58_31.062290",
//     "description": "chaha",
//     "timeStamp": 1722688111064
//   },
//   "-O3WwmpGvhwaJaE7aC6e": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2024-08-05 15_21_10.671488",
//     "description": "ino",
//     "timeStamp": 1722851470673
//   },
//   "-O3XuPz8rs8xw7FozewN": {
//     "Cost": "170",
//     "category": "Food",
//     "dateTime": "2024-08-05 19_50_25.926973",
//     "description": "farsan",
//     "timeStamp": 1722867625929
//   },
//   "-O3lp4DSb6EcJ0l0EMCI": {
//     "Cost": "17",
//     "category": "Food",
//     "dateTime": "2024-08-08 17_21_24.315545",
//     "description": "oats",
//     "timeStamp": 1723117884317
//   },
//   "-O3ma6SHJvoPwYFJtIQ1": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2024-08-08 20_55_38.512530",
//     "description": "aai recharge",
//     "timeStamp": 1723130738515
//   },
//   "-O3q2PzPojEOxvET9i4K": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2024-08-09 13_02_32.345665",
//     "description": "petrol",
//     "timeStamp": 1723188752347
//   },
//   "-O3qF3L4btfJQaz1JTam": {
//     "Cost": "18",
//     "category": "General",
//     "dateTime": "2024-08-09 13_57_47.460369",
//     "description": "cell",
//     "timeStamp": 1723192067461
//   },
//   "-O3tmW9Sb_0-ghpN5bkp": {
//     "Cost": "170",
//     "category": "Food",
//     "dateTime": "2024-08-10 06_27_10.042319",
//     "description": "nasta",
//     "timeStamp": 1723251430045
//   },
//   "-O3xZ_-7KwRNRqIO7BnN": {
//     "Cost": "120.0",
//     "category": "General",
//     "dateTime": "2024-08-11 00_04_44.614947",
//     "description": "movie",
//     "timeStamp": 1723314884617
//   },
//   "-O4-Sz0SFz74rKWzP-X-": {
//     "Cost": "300",
//     "category": "Food",
//     "dateTime": "2024-08-11 13_34_47.835402",
//     "description": "nasta",
//     "timeStamp": 1723363487837
//   },
//   "-O41JnY1USMtp5WPNz1N": {
//     "Cost": "12750",
//     "category": "Bhishi 2",
//     "dateTime": "2024-08-11 22_13_55.969216",
//     "description": "bhishi 16th bharna",
//     "timeStamp": 1723394635970
//   },
//   "-O4BJMDeZtJT_uY1L8Qy": {
//     "Cost": "400.0",
//     "category": "General",
//     "dateTime": "2024-08-13 20_48_12.136886",
//     "description": "eye hospital",
//     "timeStamp": 1723562292139
//   },
//   "-O4JX7RZBpoXvYaH7Ijd": {
//     "Cost": "18000",
//     "category": "Bhishi",
//     "dateTime": "2024-08-15 11_05_19.331149",
//     "description": "bhishi 29th bhrna",
//     "timeStamp": 1723700119332
//   },
//   "-O4JuJ2zoL8JgwHKyLqA": {
//     "Cost": "25",
//     "category": "General",
//     "dateTime": "2024-08-15 12_50_58.365633",
//     "description": "lighter",
//     "timeStamp": 1723706458367
//   },
//   "-O4KI9L7Xzpw-2-vzlEM": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2024-08-15 14_39_32.167521",
//     "description": "pani bottol",
//     "timeStamp": 1723712972168
//   },
//   "-O4Qga0mi2pYYg2Ap-KN": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2024-08-16 20_28_22.448482",
//     "description": "bus",
//     "timeStamp": 1723820302451
//   },
//   "-O4W34xXWfg8tRJQS1X2": {
//     "Cost": "264",
//     "category": "Food",
//     "dateTime": "2024-08-17 21_29_08.641105",
//     "description": "jevn",
//     "timeStamp": 1723910348642
//   },
//   "-O4ZB5xdFvnMqWM2QoYf": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-08-18 12_03_01.543035",
//     "description": "pani",
//     "timeStamp": 1723962781545
//   },
//   "-O4_YDKwT59TrfGjGHvO": {
//     "Cost": "130",
//     "category": "Food",
//     "dateTime": "2024-08-18 18_23_38.297685",
//     "description": "burger",
//     "timeStamp": 1723985618300
//   },
//   "-O4eItnHEvtHvDULJVVV": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-08-19 16_34_48.082020",
//     "description": "pani",
//     "timeStamp": 1724065488082
//   },
//   "-O4eKBz0USwhGBNjD6aG": {
//     "Cost": "500",
//     "category": "Food",
//     "dateTime": "2024-08-19 16_40_28.800893",
//     "description": "jevn",
//     "timeStamp": 1724065828801
//   },
//   "-O4itnqJjaFoRS5z0zlZ": {
//     "Cost": "58.0",
//     "category": "West",
//     "dateTime": "2024-08-20 13_58_54.034365",
//     "description": "revolt Xerox",
//     "timeStamp": 1724142534036
//   },
//   "-O4kD4DQYKAHqp7AlK3H": {
//     "Cost": "540",
//     "category": "General",
//     "dateTime": "2024-08-20 20_07_05.306757",
//     "description": "ashya gadi",
//     "timeStamp": 1724164625307
//   },
//   "-O4kOwQhZ-D7HT86r9lG": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2024-08-20 20_58_55.020402",
//     "description": "petrol",
//     "timeStamp": 1724167735021
//   },
//   "-O4p59S8fNsxyqe5syTJ": {
//     "Cost": "101",
//     "category": "General",
//     "dateTime": "2024-08-21 18_50_35.655861",
//     "description": "petrol",
//     "timeStamp": 1724246435657
//   },
//   "-O4tICU54d30ZtoR_UoH": {
//     "Cost": "3000",
//     "category": "General",
//     "dateTime": "2024-08-22 14_26_04.804363",
//     "description": "pappa kapde",
//     "timeStamp": 1724316964806
//   },
//   "-O4tKyc31ekPoimKZIER": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2024-08-22 14_38_10.371226",
//     "description": "my recharge",
//     "timeStamp": 1724317690372
//   },
//   "-O4zJFnIgFuOHPgS6i8a": {
//     "Cost": "10000",
//     "category": "Gold bhishi",
//     "dateTime": "2024-08-23 18_28_23.825609",
//     "description": "gold bhishi 1st hapta",
//     "timeStamp": 1724417903828
//   },
//   "-O519Z2Fflcc2l2STI8I": {
//     "Cost": "530",
//     "category": "General",
//     "dateTime": "2024-08-24 07_44_52.879089",
//     "description": "petrol",
//     "timeStamp": 1724465692880
//   },
//   "-O51_-lKKSx3cG9FvXCZ": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-08-24 09_40_26.259576",
//     "description": "pani",
//     "timeStamp": 1724472626262
//   },
//   "-O57nDc9XDU3OGzZu1tc": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2024-08-25 14_40_16.329420",
//     "description": "petrol",
//     "timeStamp": 1724577016330
//   },
//   "-O59HN1i4BpPt_OUhza1": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2024-08-25 21_35_58.571978",
//     "description": "viks",
//     "timeStamp": 1724601958574
//   },
//   "-O5I_RDJVfot2iPHsTai": {
//     "Cost": "1220",
//     "category": "General",
//     "dateTime": "2024-08-27 16_55_51.379460",
//     "description": "silver",
//     "timeStamp": 1724757951380
//   },
//   "-O5N4SG7xyXwqTXUkrj0": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2024-08-28 13_54_13.123838",
//     "description": "petrol",
//     "timeStamp": 1724833453128
//   },
//   "-O5aYK3f39gTIbLdVTE4": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2024-08-31 09_19_24.906014",
//     "description": "medu vada",
//     "timeStamp": 1725076164907
//   },
//   "-O5avC95PuS5bcoN3Oja": {
//     "Cost": "310",
//     "category": "General",
//     "dateTime": "2024-08-31 11_03_43.941328",
//     "description": "petrol",
//     "timeStamp": 1725082423943
//   },
//   "-O5dSznCnOlWQRQiKxDk": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2024-08-31 22_54_58.699636",
//     "description": "medical",
//     "timeStamp": 1725125098701
//   },
//   "-O5gFkg58jBXGLPP1Sx9": {
//     "Cost": "25",
//     "category": "Food",
//     "dateTime": "2024-09-01 11_56_00.581471",
//     "description": "biscuit",
//     "timeStamp": 1725171960582
//   },
//   "-O5hn_co9ugoila7rRSi": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2024-09-01 19_07_47.570693",
//     "description": "Petrol",
//     "timeStamp": 1725197867572
//   },
//   "-O5iNXn7C_ciOB1TpMAx": {
//     "Cost": "5",
//     "category": "General",
//     "dateTime": "2024-09-01 21_49_15.270864",
//     "description": "wash",
//     "timeStamp": 1725207555272
//   },
//   "-O5ng6wLDk3s76RuQGDf": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2024-09-02 22_32_54.228096",
//     "description": "dan",
//     "timeStamp": 1725296574230
//   },
//   "-O5sJLkvba3y2ZHe-9oQ": {
//     "Cost": "10000",
//     "category": "Gold bhishi",
//     "dateTime": "2024-09-03 20_07_09.562304",
//     "description": "gold bhisi 2nd hapta",
//     "timeStamp": 1725374229564
//   },
//   "-O5sRbXo6_vTOb0ZnKed": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2024-09-03 20_43_15.443574",
//     "description": "farsan",
//     "timeStamp": 1725376395444
//   },
//   "-O5xY3h97563Lu8TqRrO": {
//     "Cost": "48",
//     "category": "Food",
//     "dateTime": "2024-09-04 20_29_33.833154",
//     "description": "ladi pav",
//     "timeStamp": 1725461973834
//   },
//   "-O6A6W2DaDt0NBiSbjbA": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2024-09-07 11_43_50.925756",
//     "description": "petrol",
//     "timeStamp": 1725689630927
//   },
//   "-O6BTnpK9TyBtTQnjf3_": {
//     "Cost": "1800",
//     "category": "General",
//     "dateTime": "2024-09-07 18_05_14.387405",
//     "description": "ganpati",
//     "timeStamp": 1725712514389
//   },
//   "-O6C3enDu6MAdRx58fet": {
//     "Cost": "270",
//     "category": "General",
//     "dateTime": "2024-09-07 20_50_38.860528",
//     "description": "bail",
//     "timeStamp": 1725722438863
//   },
//   "-O6MAuHgJzEHTVNoZvfF": {
//     "Cost": "142",
//     "category": "Food",
//     "dateTime": "2024-09-09 19_58_29.482495",
//     "description": "nasta",
//     "timeStamp": 1725892109484
//   },
//   "-O6MdqcTYNocF5wgcK2O": {
//     "Cost": "70",
//     "category": "General",
//     "dateTime": "2024-09-09 22_09_18.813680",
//     "description": "medical",
//     "timeStamp": 1725899958814
//   },
//   "-O6X0CT-WllezSY0phVt": {
//     "Cost": "13000",
//     "category": "Bhishi 2",
//     "dateTime": "2024-09-11 22_27_33.822585",
//     "description": "bhishi 17th bhrna",
//     "timeStamp": 1726073853824
//   },
//   "-O6aOUGiS66UQh2mrjVd": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2024-09-12 18_52_07.086218",
//     "description": "aai recharge",
//     "timeStamp": 1726147327086
//   },
//   "-O6bAuQS36RJC35GEOmB": {
//     "Cost": "188",
//     "category": "Food",
//     "dateTime": "2024-09-12 22_32_25.499851",
//     "description": "jevn",
//     "timeStamp": 1726160545501
//   },
//   "-O6bAwVwqp65Mx-mI6DL": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2024-09-12 22_32_34.043759",
//     "description": "petrol",
//     "timeStamp": 1726160554044
//   },
//   "-O6baRtszyNKYcynDFCO": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-09-13 00_28_22.455222",
//     "description": "pani",
//     "timeStamp": 1726167502456
//   },
//   "-O6dkyVNZKVTjL6AoSna": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2024-09-13 10_33_35.959231",
//     "description": "kandil",
//     "timeStamp": 1726203815960
//   },
//   "-O6gFrxLxEMgTK7kmyiI": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2024-09-13 22_12_12.181600",
//     "description": "oats",
//     "timeStamp": 1726245732182
//   },
//   "-O6jzouUAtpr1n-yPhLz": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2024-09-14 15_36_12.125468",
//     "description": "kes cutting",
//     "timeStamp": 1726308372127
//   },
//   "-O6k1yzzqetC36nWXGI4": {
//     "Cost": "94.0",
//     "category": "General",
//     "dateTime": "2024-09-14 15_49_59.871139",
//     "description": "fuga fevicol lamp",
//     "timeStamp": 1726309199871
//   },
//   "-O6lJogXxRk6KYbwdMOp": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2024-09-14 21_47_33.473091",
//     "description": "hawa",
//     "timeStamp": 1726330653474
//   },
//   "-O6oXmTD7YKDTd6zveJ_": {
//     "Cost": "91",
//     "category": "General",
//     "dateTime": "2024-09-15 12_47_26.028852",
//     "description": "bappa recharge",
//     "timeStamp": 1726384646030
//   },
//   "-O6pPcZjVMqmbF-n_hyb": {
//     "Cost": "230.0",
//     "category": "General",
//     "dateTime": "2024-09-15 16_51_25.549643",
//     "description": "bulb lamp",
//     "timeStamp": 1726399285552
//   },
//   "-O6pokPWnNZV9pS3JYiD": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2024-09-15 18_45_33.407961",
//     "description": "ajji injection",
//     "timeStamp": 1726406133409
//   },
//   "-O6q6ADOPLaTbhk1vl1T": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2024-09-15 20_06_01.815305",
//     "description": "tester",
//     "timeStamp": 1726410961817
//   },
//   "-O6qH1V5T7evfn5K7fgJ": {
//     "Cost": "18000",
//     "category": "Bhishi",
//     "dateTime": "2024-09-15 20_53_29.669134",
//     "description": "bhishi 30th bhrna",
//     "timeStamp": 1726413809670
//   },
//   "-O6vD_jBTNvQECeacXDE": {
//     "Cost": "230",
//     "category": "Pop",
//     "dateTime": "2024-09-16 19_56_31.498365",
//     "description": "pop light",
//     "timeStamp": 1726496791500
//   },
//   "-O74sgSWGq1uB-bbX67e": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2024-09-18 21_36_41.248818",
//     "description": "chips",
//     "timeStamp": 1726675601249
//   },
//   "-O77eDDVtqWP0aU8O1AX": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2024-09-19 10_32_19.039416",
//     "description": "my recharge",
//     "timeStamp": 1726722139040
//   },
//   "-O79tn5Q4bKNLr0v6qm6": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2024-09-19 20_59_36.665540",
//     "description": "dhup vati",
//     "timeStamp": 1726759776667
//   },
//   "-O7IZ00MZ0ILhc04GavO": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2024-09-21 13_21_01.462642",
//     "description": "pani",
//     "timeStamp": 1726905061463
//   },
//   "-O7J5XUO3quGDUVgu_kw": {
//     "Cost": "15",
//     "category": "General",
//     "dateTime": "2024-09-21 15_51_51.448169",
//     "description": "lighter",
//     "timeStamp": 1726914111449
//   },
//   "-O7Jg0J-_MnkDObFL79H": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2024-09-21 18_35_37.024309",
//     "description": "medical",
//     "timeStamp": 1726923937025
//   },
//   "-O7PL1fb2IxDHzewqamg": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2024-09-22 20_57_18.758840",
//     "description": "ajji injection",
//     "timeStamp": 1727018838759
//   },
//   "-O7SeaG9aohG9n-Lyznx": {
//     "Cost": "1953.0",
//     "category": "Trekking",
//     "dateTime": "2024-09-23 12_25_59.049460",
//     "description": "ekole vally trip me + omkya",
//     "timeStamp": 1727074559050
//   },
//   "-O7TaRnpcibj1SF2_MYs": {
//     "Cost": "250.0",
//     "category": "General",
//     "dateTime": "2024-09-23 16_47_28.947318",
//     "description": "revolt gps kit",
//     "timeStamp": 1727090248949
//   },
//   "-O7Tahmmnq9B71FObtSn": {
//     "Cost": "1396",
//     "category": "General",
//     "dateTime": "2024-09-23 16_48_38.514154",
//     "description": "revolt insurance",
//     "timeStamp": 1727090318514
//   },
//   "-O7iXBX74DMvXJu05voa": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2024-09-26 19_02_49.159683",
//     "description": "revolt keychain",
//     "timeStamp": 1727357569160
//   },
//   "-O7iog2600inmJnF0LyY": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2024-09-26 20_23_36.837855",
//     "description": "rashan",
//     "timeStamp": 1727362416839
//   },
//   "-O7jf_xWBlhi4KzyjKXY": {
//     "Cost": "1142",
//     "category": "General",
//     "dateTime": "2024-09-27 00_23_29.823262",
//     "description": "shoes",
//     "timeStamp": 1727376809825
//   },
//   "-O7s0ukPGWQ6H_-SruuR": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2024-09-28 15_17_59.896964",
//     "description": "elpro parking",
//     "timeStamp": 1727516879898
//   },
//   "-O7xUTqIdazWr_aMm4vc": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2024-09-29 16_45_15.986348",
//     "description": "petrol",
//     "timeStamp": 1727608515987
//   },
//   "-O7yxV8iuFxXuFYiMErI": {
//     "Cost": "203",
//     "category": "Food",
//     "dateTime": "2024-09-29 23_36_02.860086",
//     "description": "cafe",
//     "timeStamp": 1727633162863
//   },
//   "-O80dFkYrmRBxI_N3NvQ": {
//     "Cost": "870.0",
//     "category": "General",
//     "dateTime": "2024-09-30 12_06_28.578037",
//     "description": "wifi recharge udhar ghetle aai",
//     "timeStamp": 1727678188579
//   },
//   "-O8C57lzEVvrhyMOduGa": {
//     "Cost": "2500",
//     "category": "General",
//     "dateTime": "2024-10-02 17_28_27.454044",
//     "description": "revolt charger repair",
//     "timeStamp": 1727870307455
//   },
//   "-O8C7-DHHooNvrAdygak": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2024-10-02 17_36_36.690076",
//     "description": "petrol",
//     "timeStamp": 1727870796690
//   },
//   "-O8GODK8FvsvPIK319lq": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2024-10-03 13_30_19.784749",
//     "description": "hawa",
//     "timeStamp": 1727942419785
//   },
//   "-O8R3s3A6Fm4Hs7F5llu": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2024-10-05 15_17_15.082454",
//     "description": "hawa",
//     "timeStamp": 1728121635083
//   },
//   "-O8R6W6UIkdjVB0xGUr6": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2024-10-05 15_28_47.519020",
//     "description": "petrol",
//     "timeStamp": 1728122327519
//   },
//   "-O8bZcs_dMBvhEsqjvUp": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2024-10-07 20_51_50.882954",
//     "description": "istri",
//     "timeStamp": 1728314510885
//   },
//   "-O8byTGos2xLUdK6k4X4": {
//     "Cost": "140",
//     "category": "General",
//     "dateTime": "2024-10-07 22_44_43.188356",
//     "description": "panti",
//     "timeStamp": 1728321283188
//   },
//   "-O8eKu01801RB_y7X_ac": {
//     "Cost": "502",
//     "category": "General",
//     "dateTime": "2024-10-08 09_46_20.542176",
//     "description": "petrol",
//     "timeStamp": 1728360980546
//   },
//   "-O8eTYyLoWIzFClFddax": {
//     "Cost": "90",
//     "category": "General",
//     "dateTime": "2024-10-08 10_24_09.557501",
//     "description": "chikat tape",
//     "timeStamp": 1728363249558
//   },
//   "-O8fK-M-m5nKmETFG49Z": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2024-10-08 14_22_01.600143",
//     "description": "ras",
//     "timeStamp": 1728377521600
//   },
//   "-O8fNXDey0DvfrkWeZO8": {
//     "Cost": "72",
//     "category": "Food",
//     "dateTime": "2024-10-08 14_37_26.762423",
//     "description": "dudh",
//     "timeStamp": 1728378446762
//   },
//   "-O8gT0oXsNwXl2EwINE4": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2024-10-08 19_41_04.097556",
//     "description": "fruit plate",
//     "timeStamp": 1728396664098
//   },
//   "-O8r-b9mNNIW9wocdOyz": {
//     "Cost": "105",
//     "category": "Food",
//     "dateTime": "2024-10-10 20_48_22.129323",
//     "description": "pani puri",
//     "timeStamp": 1728573502130
//   },
//   "-O8r0wvw-7_FoocBIJC0": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2024-10-10 20_54_13.435757",
//     "description": "bappa jio battery",
//     "timeStamp": 1728573853436
//   },
//   "-O8uvcvGWH8mgveLL3T_": {
//     "Cost": "10000",
//     "category": "Gold bhishi",
//     "dateTime": "2024-10-11 15_05_07.472008",
//     "description": "gold bhishi 3rd hapta",
//     "timeStamp": 1728639307474
//   },
//   "-O8uwSxbQw2CruSFuq6C": {
//     "Cost": "13250",
//     "category": "Bhishi 2",
//     "dateTime": "2024-10-11 15_08_44.710923",
//     "description": "bhishi 18th bhrna",
//     "timeStamp": 1728639524711
//   },
//   "-O9-XNSjf0m0EQ9b0Kyx": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2024-10-12 17_12_29.743189",
//     "description": "pedhe",
//     "timeStamp": 1728733349743
//   },
//   "-O90vx0dgPJAjGiAqBKj": {
//     "Cost": "135",
//     "category": "General",
//     "dateTime": "2024-10-12 23_43_50.312519",
//     "description": "charging cable",
//     "timeStamp": 1728756830313
//   },
//   "-O93KO_SFzWufgbHpbES": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2024-10-13 10_54_15.324092",
//     "description": "chips",
//     "timeStamp": 1728797055325
//   },
//   "-O93KQNiIyhKOWv1EK43": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-10-13 10_54_22.701366",
//     "description": "juce",
//     "timeStamp": 1728797062702
//   },
//   "-O94rsrKQ33ZI0tKg_ZY": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2024-10-13 18_04_33.556181",
//     "description": "medical",
//     "timeStamp": 1728822873557
//   },
//   "-O94ruZV0AhBqt4j4sBp": {
//     "Cost": "600",
//     "category": "General",
//     "dateTime": "2024-10-13 18_04_40.543895",
//     "description": "hotel",
//     "timeStamp": 1728822880544
//   },
//   "-O94rwyYm5EUt7diIFTk": {
//     "Cost": "70",
//     "category": "General",
//     "dateTime": "2024-10-13 18_04_50.402636",
//     "description": "petrol",
//     "timeStamp": 1728822890403
//   },
//   "-O94wg7hYB0uA5N9MPAT": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-10-13 18_25_32.139880",
//     "description": "khari",
//     "timeStamp": 1728824132141
//   },
//   "-O96-SB45Otbxq6fsB4c": {
//     "Cost": "300.0",
//     "category": "General",
//     "dateTime": "2024-10-13 23_21_36.708774",
//     "description": "Amazon prime",
//     "timeStamp": 1728841896710
//   },
//   "-O98bL9R3M-tNC-opge0": {
//     "Cost": "70",
//     "category": "Food",
//     "dateTime": "2024-10-14 11_30_45.979519",
//     "description": "juce",
//     "timeStamp": 1728885645980
//   },
//   "-O9FNctZAe7NlwWeweDj": {
//     "Cost": "160",
//     "category": "Food",
//     "dateTime": "2024-10-15 19_03_51.074981",
//     "description": "bhaji",
//     "timeStamp": 1728999231076
//   },
//   "-O9FNeWr0a04j-w3DDBe": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2024-10-15 19_03_57.751526",
//     "description": "vadapav",
//     "timeStamp": 1728999237752
//   },
//   "-O9FOuXg1OG52QpCVBbr": {
//     "Cost": "176",
//     "category": "General",
//     "dateTime": "2024-10-15 19_09_25.483877",
//     "description": "medical",
//     "timeStamp": 1728999565485
//   },
//   "-O9FkbbBk1vPwVRe6lcc": {
//     "Cost": "15750.0",
//     "category": "Bhishi",
//     "dateTime": "2024-10-15 20_48_37.260269",
//     "description": "bhishi 1st bhrna",
//     "timeStamp": 1729005517260
//   },
//   "-O9O6NtGUoJGgpUZI6tk": {
//     "Cost": "109",
//     "category": "General",
//     "dateTime": "2024-10-17 11_45_04.016801",
//     "description": "my recharge",
//     "timeStamp": 1729145704018
//   },
//   "-O9PsGZaPUG9ygRlXkHc": {
//     "Cost": "36",
//     "category": "General",
//     "dateTime": "2024-10-17 19_58_16.294401",
//     "description": "cell",
//     "timeStamp": 1729175296295
//   },
//   "-O9XaNPMKnTk_fHh4L1G": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2024-10-19 07_57_03.446666",
//     "description": "parking",
//     "timeStamp": 1729304823448
//   },
//   "-O9XnFklFWYuCRiPQ2TX": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2024-10-19 08_53_19.984785",
//     "description": "aai recharge",
//     "timeStamp": 1729308199985
//   },
//   "-O9YfPNv-_1XD9pWs8dK": {
//     "Cost": "70",
//     "category": "General",
//     "dateTime": "2024-10-19 12_58_39.482791",
//     "description": "socks",
//     "timeStamp": 1729322919483
//   },
//   "-O9cpvJHiMZ1hphNrICG": {
//     "Cost": "427",
//     "category": "General",
//     "dateTime": "2024-10-20 13_02_41.872994",
//     "description": "sudhagad",
//     "timeStamp": 1729409561874
//   },
//   "-O9o_ewEV9DlbaB4x-TY": {
//     "Cost": "34",
//     "category": "General",
//     "dateTime": "2024-10-22 19_47_07.085552",
//     "description": "chaha",
//     "timeStamp": 1729606627087
//   },
//   "-O9rlP9oKP12L4DlFy7x": {
//     "Cost": "90",
//     "category": "Food",
//     "dateTime": "2024-10-23 10_37_15.763550",
//     "description": "paneer",
//     "timeStamp": 1729660035764
//   },
//   "-O9tgiBhxOwW4fEXg30_": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2024-10-23 19_36_01.515806",
//     "description": "kothimbir",
//     "timeStamp": 1729692361518
//   },
//   "-O9x-vjd72Xs6f5NJZBC": {
//     "Cost": "2000",
//     "category": "General",
//     "dateTime": "2024-10-24 11_03_11.527596",
//     "description": "bai bappa diwali",
//     "timeStamp": 1729747991529
//   },
//   "-OA2tr5YLaw9he_f_Tiw": {
//     "Cost": "270",
//     "category": "Food",
//     "dateTime": "2024-10-25 19_09_38.018317",
//     "description": "Manchurian",
//     "timeStamp": 1729863578019
//   },
//   "-OA3ExKdQdf_aMeuO0yx": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2024-10-25 20_46_10.728506",
//     "description": "petrol",
//     "timeStamp": 1729869370729
//   },
//   "-OADyW1zss18_oq8rY-V": {
//     "Cost": "1712",
//     "category": "General",
//     "dateTime": "2024-10-27 22_45_47.773880",
//     "description": "nagao trip",
//     "timeStamp": 1730049347775
//   },
//   "-OAMuBGLnxHGkQazv4LO": {
//     "Cost": "5385.0",
//     "category": "General",
//     "dateTime": "2024-10-29 16_23_29.044612",
//     "description": "Diwali kapde",
//     "timeStamp": 1730199209046
//   },
//   "-OAMuQeC50FXEOkZHlVT": {
//     "Cost": "588",
//     "category": "Udhar dile",
//     "dateTime": "2024-10-29 16_24_32.076691",
//     "description": "baglya nagao trip",
//     "timeStamp": 1730199272078
//   },
//   "-OAaKrp8UcwbaGnolWzb": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2024-11-01 11_39_06.376441",
//     "description": "kes cutting",
//     "timeStamp": 1730441346377
//   },
//   "-OAaMXckeULPmeu53E85": {
//     "Cost": "500",
//     "category": "General",
//     "dateTime": "2024-11-01 11_46_23.855666",
//     "description": "ajji blanket",
//     "timeStamp": 1730441783856
//   },
//   "-OAaT6eoQz9qojRNNV9m": {
//     "Cost": "1000",
//     "category": "General",
//     "dateTime": "2024-11-01 12_15_08.403712",
//     "description": "fatake",
//     "timeStamp": 1730443508405
//   },
//   "-OAas_bDubPX79DHOcIZ": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2024-11-01 14_10_46.797173",
//     "description": "tak",
//     "timeStamp": 1730450446799
//   },
//   "-OAupPsJCylAtuprCPoH": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2024-11-05 11_09_20.721785",
//     "description": "petrol",
//     "timeStamp": 1730785160724
//   },
//   "-OB3lawUQ7aCBpEfYcmI": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2024-11-07 09_28_53.725869",
//     "description": "petrol",
//     "timeStamp": 1730951933727
//   },
//   "-OB3lc13D0jdt1IWPG1h": {
//     "Cost": "300",
//     "category": "General",
//     "dateTime": "2024-11-07 09_28_58.180412",
//     "description": "dan",
//     "timeStamp": 1730951938181
//   },
//   "-OB98dhjqpL5hah7aKR3": {
//     "Cost": "100.0",
//     "category": "Food",
//     "dateTime": "2024-11-08 10_32_02.605395",
//     "description": "pohe",
//     "timeStamp": 1731042122607
//   },
//   "-OB98gAgOo74I0Sj6CDq": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2024-11-08 10_32_12.715728",
//     "description": "dan",
//     "timeStamp": 1731042132716
//   },
//   "-OBBzXyx1ADLafYSFdsP": {
//     "Cost": "140",
//     "category": "Food",
//     "dateTime": "2024-11-08 23_46_45.243866",
//     "description": "nasta",
//     "timeStamp": 1731089805246
//   },
//   "-OBGKgfwUtOVAZR44nC4": {
//     "Cost": "10000",
//     "category": "Gold bhishi",
//     "dateTime": "2024-11-09 20_02_01.018939",
//     "description": "gold bhishi 4th bhrna",
//     "timeStamp": 1731162721020
//   },
//   "-OBGKlA0pbbGMk0ROKm6": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-11-09 20_02_19.393073",
//     "description": "pani bottol",
//     "timeStamp": 1731162739393
//   },
//   "-OBGODDQu9H6G3I6JIbn": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2024-11-09 20_17_24.826509",
//     "description": "petrol",
//     "timeStamp": 1731163644827
//   },
//   "-OBUh68YneG2hC2FrGYY": {
//     "Cost": "13400",
//     "category": "Bhishi 2",
//     "dateTime": "2024-11-12 14_58_59.746536",
//     "description": "bhishi 19th bhrna",
//     "timeStamp": 1731403739747
//   },
//   "-OBVNbcgilGuFWkgRhT5": {
//     "Cost": "34",
//     "category": "General",
//     "dateTime": "2024-11-12 18_09_05.003764",
//     "description": "Xerox revolt",
//     "timeStamp": 1731415145004
//   },
//   "-OBW1ouDXJE5YekDBSH4": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2024-11-12 21_13_29.421081",
//     "description": "my recharge",
//     "timeStamp": 1731426209422
//   },
//   "-OB_SjCcHJiceZrnAFV3": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2024-11-13 17_49_32.840206",
//     "description": "Cadbury",
//     "timeStamp": 1731500372840
//   },
//   "-OBexZF-WGywUtHv5NBo": {
//     "Cost": "31",
//     "category": "Food",
//     "dateTime": "2024-11-14 19_26_42.623188",
//     "description": "chaha",
//     "timeStamp": 1731592602624
//   },
//   "-OBiIz2blbii_agA7ytJ": {
//     "Cost": "135",
//     "category": "Food",
//     "dateTime": "2024-11-15 11_03_31.238068",
//     "description": "nasta",
//     "timeStamp": 1731648811239
//   },
//   "-OBkspR0K9wk2zKzSS6U": {
//     "Cost": "14.0",
//     "category": "General",
//     "dateTime": "2024-11-15 23_03_45.600424",
//     "description": "Gillette",
//     "timeStamp": 1731692025601
//   },
//   "-OBp2ex8K94tv2eoAB--": {
//     "Cost": "70",
//     "category": "Food",
//     "dateTime": "2024-11-16 18_29_35.111140",
//     "description": "juice",
//     "timeStamp": 1731761975113
//   },
//   "-OBp2nSoRTkZ6-dSGsxC": {
//     "Cost": "30000",
//     "category": "Bhishi",
//     "dateTime": "2024-11-16 18_30_09.972119",
//     "description": "bhishi 2nd bhrna",
//     "timeStamp": 1731762009972
//   },
//   "-OBsUFfHtCLHR8AbltU8": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2024-11-17 10_28_59.154259",
//     "description": "petrol",
//     "timeStamp": 1731819539154
//   },
//   "-OBshGP6X7mi9sDH8sUs": {
//     "Cost": "29",
//     "category": "General",
//     "dateTime": "2024-11-17 11_30_12.165760",
//     "description": "medical",
//     "timeStamp": 1731823212167
//   },
//   "-OBtnTtxuDlcDgIGs5hE": {
//     "Cost": "800",
//     "category": "General",
//     "dateTime": "2024-11-17 16_36_57.532113",
//     "description": "hotel",
//     "timeStamp": 1731841617533
//   },
//   "-OBts7LVUiertLDTF34e": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2024-11-17 16_57_15.871844",
//     "description": "pani",
//     "timeStamp": 1731842835872
//   },
//   "-OBuXc4cWwL8JVZb6kUb": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-11-17 20_02_55.910304",
//     "description": "chips",
//     "timeStamp": 1731853975912
//   },
//   "-OBuYZG1GUEcMhTt0n2f": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-11-17 20_07_02.401819",
//     "description": "pani",
//     "timeStamp": 1731854222402
//   },
//   "-OBvHAuPmExaSZtHsUJ4": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2024-11-17 23_30_43.416629",
//     "description": "petrol",
//     "timeStamp": 1731866443418
//   },
//   "-OC-KllI4Mw_lpCONfpt": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2024-11-18 23_04_30.994565",
//     "description": "faluda",
//     "timeStamp": 1731951270995
//   },
//   "-OC4twLQY00ZFUB14cOb": {
//     "Cost": "1457",
//     "category": "Food",
//     "dateTime": "2024-11-20 01_00_37.593686",
//     "description": "jevn hotel",
//     "timeStamp": 1732044637595
//   },
//   "-OC8XbKKbrHeSXHyiVKu": {
//     "Cost": "15",
//     "category": "Food",
//     "dateTime": "2024-11-20 17_57_11.051008",
//     "description": "biskit",
//     "timeStamp": 1732105631061
//   },
//   "-OCDj1M5kqGDssOQQJPn": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2024-11-21 18_09_33.572999",
//     "description": "roti",
//     "timeStamp": 1732192773574
//   },
//   "-OCDj6KWNQHjlv8pdI0M": {
//     "Cost": "2005",
//     "category": "General",
//     "dateTime": "2024-11-21 18_09_53.953378",
//     "description": "revolt alloy wheel",
//     "timeStamp": 1732192793953
//   },
//   "-OCEYInKbbRZQr-cm8Mc": {
//     "Cost": "57",
//     "category": "General",
//     "dateTime": "2024-11-21 21_57_56.500938",
//     "description": "medical",
//     "timeStamp": 1732206476501
//   },
//   "-OCHZgpI9EqlA-CFEEyq": {
//     "Cost": "18",
//     "category": "Food",
//     "dateTime": "2024-11-22 12_02_52.818962",
//     "description": "chaha",
//     "timeStamp": 1732257172819
//   },
//   "-OCJPAgBXRMR--7ziFzg": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2024-11-22 20_36_10.059729",
//     "description": "vadapav",
//     "timeStamp": 1732287970061
//   },
//   "-OCN3ovcWK6WRmsYmEL8": {
//     "Cost": "750",
//     "category": "General",
//     "dateTime": "2024-11-23 13_41_20.679639",
//     "description": "kapde",
//     "timeStamp": 1732349480681
//   },
//   "-OCNFlHvFjHdN1kzzUaG": {
//     "Cost": "55",
//     "category": "Food",
//     "dateTime": "2024-11-23 14_33_31.515677",
//     "description": "cake",
//     "timeStamp": 1732352611515
//   },
//   "-OCOReLSANwOHPe50UQX": {
//     "Cost": "36",
//     "category": "Food",
//     "dateTime": "2024-11-23 20_05_06.011874",
//     "description": "dudh",
//     "timeStamp": 1732372506013
//   },
//   "-OCOcUueX2mDQbhdDOnd": {
//     "Cost": "609",
//     "category": "General",
//     "dateTime": "2024-11-23 20_56_49.000812",
//     "description": "medical aai",
//     "timeStamp": 1732375609002
//   },
//   "-OCP1l2I5fpvnL3TTrj1": {
//     "Cost": "15",
//     "category": "General",
//     "dateTime": "2024-11-23 22_51_34.931148",
//     "description": "medical",
//     "timeStamp": 1732382494931
//   },
//   "-OCP28QOq8WjLZnbHSX4": {
//     "Cost": "5",
//     "category": "Food",
//     "dateTime": "2024-11-23 22_53_14.777303",
//     "description": "limbu",
//     "timeStamp": 1732382594777
//   },
//   "-OCRtPa3h488FrVdbR-t": {
//     "Cost": "49",
//     "category": "Food",
//     "dateTime": "2024-11-24 12_09_35.298720",
//     "description": "chaha",
//     "timeStamp": 1732430375300
//   },
//   "-OCTFUr51PvVfa-d599-": {
//     "Cost": "493",
//     "category": "Food",
//     "dateTime": "2024-11-24 18_30_03.396026",
//     "description": "jevn",
//     "timeStamp": 1732453203398
//   },
//   "-OCTNhcP7atHYnn4kZ5d": {
//     "Cost": "1620",
//     "category": "Nepal",
//     "dateTime": "2024-11-24 19_05_56.953606",
//     "description": "Nepal train tickets",
//     "timeStamp": 1732455356955
//   },
//   "-OCTnX3oDJ46iv9oRyIc": {
//     "Cost": "160",
//     "category": "Food",
//     "dateTime": "2024-11-24 21_03_07.508221",
//     "description": "dryfruits",
//     "timeStamp": 1732462387508
//   },
//   "-OCYy_iQhia3F175smls": {
//     "Cost": "90",
//     "category": "Food",
//     "dateTime": "2024-11-25 21_09_32.122841",
//     "description": "vadapav",
//     "timeStamp": 1732549172123
//   },
//   "-OCcjMA2ypVfqBt2sk8y": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2024-11-26 19_21_06.433793",
//     "description": "voting card",
//     "timeStamp": 1732629066436
//   },
//   "-OCd5VpVRZdVKI2_ffc9": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2024-11-26 21_02_15.326902",
//     "description": "chain",
//     "timeStamp": 1732635135328
//   },
//   "-OCs_87j26CZ15JOC9HG": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2024-11-29 21_10_22.958227",
//     "description": "medical",
//     "timeStamp": 1732894822959
//   },
//   "-OCxWqscoueTBjhOZd9V": {
//     "Cost": "75",
//     "category": "Food",
//     "dateTime": "2024-11-30 20_14_07.847533",
//     "description": "chaha",
//     "timeStamp": 1732977847848
//   },
//   "-OCxs0rArNCCO1VTqDkT": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2024-11-30 21_50_59.978410",
//     "description": "mask",
//     "timeStamp": 1732983659979
//   },
//   "-OCxxoTFK8UVSp-CPxTf": {
//     "Cost": "150",
//     "category": "Food",
//     "dateTime": "2024-11-30 22_16_18.000386",
//     "description": "pavbhaji",
//     "timeStamp": 1732985178000
//   },
//   "-OD-hGBuDTrcKdtvewaE": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-12-01 11_02_50.870561",
//     "description": "khari",
//     "timeStamp": 1733031170874
//   },
//   "-OD08wEjl26VpvqS8Py2": {
//     "Cost": "10000",
//     "category": "Gold bhishi",
//     "dateTime": "2024-12-01 13_08_07.212728",
//     "description": "gold bhishi 5th bhrna",
//     "timeStamp": 1733038687215
//   },
//   "-OD0YV4-f3Ge43U3wM89": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2024-12-01 14_59_47.583209",
//     "description": "Maggie",
//     "timeStamp": 1733045387584
//   },
//   "-OD21AQw_2nt2Pq8CSC4": {
//     "Cost": "555",
//     "category": "Food",
//     "dateTime": "2024-12-01 21_53_26.716184",
//     "description": "jevn hotel",
//     "timeStamp": 1733070206716
//   },
//   "-OD5Kdg8BWdJ83re88jO": {
//     "Cost": "35",
//     "category": "Food",
//     "dateTime": "2024-12-02 13_17_23.017263",
//     "description": "dahi",
//     "timeStamp": 1733125643019
//   },
//   "-OD7BwbDn45vD-3-LvuV": {
//     "Cost": "52",
//     "category": "General",
//     "dateTime": "2024-12-02 21_58_35.660866",
//     "description": "medical",
//     "timeStamp": 1733156915662
//   },
//   "-ODCRMAvUAOOf4KsHReq": {
//     "Cost": "164",
//     "category": "Food",
//     "dateTime": "2024-12-03 22_24_02.747177",
//     "description": "icecream",
//     "timeStamp": 1733244842747
//   },
//   "-ODGcwZ_AiUXLunG7GXd": {
//     "Cost": "130.0",
//     "category": "General",
//     "dateTime": "2024-12-04 17_57_30.468134",
//     "description": "kes cutting",
//     "timeStamp": 1733315250469
//   },
//   "-ODGz2G_aOWI9A-Uacbo": {
//     "Cost": "600",
//     "category": "General",
//     "dateTime": "2024-12-04 19_34_05.090969",
//     "description": "aai medicines",
//     "timeStamp": 1733321045094
//   },
//   "-ODHHuzW-WT2QMCgaFuz": {
//     "Cost": "170.0",
//     "category": "Nepal",
//     "dateTime": "2024-12-04 21_00_54.049198",
//     "description": "carry bag plates ",
//     "timeStamp": 1733326254049
//   },
//   "-ODMqxLvXkMbPrq5ag3T": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2024-12-05 22_56_27.001816",
//     "description": "chips",
//     "timeStamp": 1733419587004
//   },
//   "-ODMr16daVRhiaDZsPXQ": {
//     "Cost": "25",
//     "category": "General",
//     "dateTime": "2024-12-05 22_56_46.502275",
//     "description": "dove saban",
//     "timeStamp": 1733419606505
//   },
//   "-ODVc6pypkRiz1YKOOgp": {
//     "Cost": "80",
//     "category": "General",
//     "dateTime": "2024-12-07 15_48_12.733172",
//     "description": "dadhi",
//     "timeStamp": 1733566692735
//   },
//   "-ODVc9c0sDw36Y1sxrQf": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2024-12-07 15_48_24.128573",
//     "description": "dahi",
//     "timeStamp": 1733566704129
//   },
//   "-OEDdhDv-60sCaQlzy53": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2024-12-16 14_17_39.962582",
//     "description": "my recharge",
//     "timeStamp": 1734338859963
//   },
//   "-OEOSOgTNVPbSmYXb3yS": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2024-12-18 16_39_43.581124",
//     "description": "aai recharge",
//     "timeStamp": 1734520183582
//   },
//   "-OETCqHkpAlBkMy6b98A": {
//     "Cost": "34",
//     "category": "Food",
//     "dateTime": "2024-12-19 14_49_52.494605",
//     "description": "oats",
//     "timeStamp": 1734599992496
//   },
//   "-OEUgoc9T6ZV3gMAfoL0": {
//     "Cost": "24281",
//     "category": "General",
//     "dateTime": "2024-12-19 21_44_49.353828",
//     "description":
//         "nepal IND : https://billzer.com/my/8d0d8d7485ce4fe7de0a27510be33aa6/#  nepal : https://billzer.com/my/e6cb7f07e6f6d34c8d0b5b3683bf41ba/#",
//     "timeStamp": 1734624889354
//   },
//   "-OEUhJ0zbim4VDy8IQIY": {
//     "Cost": "17500",
//     "category": "Bhishi",
//     "dateTime": "2024-12-19 21_46_57.982123",
//     "description": "bhishi 3rd bhrna",
//     "timeStamp": 1734625017983
//   },
//   "-OEZLXMFbaQ2MWdS8oR0": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2024-12-20 19_25_33.455418",
//     "description": "Omkar angti",
//     "timeStamp": 1734702933456
//   },
//   "-OEZRefX7qUfnEPea3ih": {
//     "Cost": "270",
//     "category": "General",
//     "dateTime": "2024-12-20 19_52_20.385619",
//     "description": "sata cable",
//     "timeStamp": 1734704540386
//   },
//   "-OEZUFrZpSEts77bHSkp": {
//     "Cost": "500",
//     "category": "General",
//     "dateTime": "2024-12-20 20_03_41.091451",
//     "description": "omkar",
//     "timeStamp": 1734705221092
//   },
//   "-OEZo5ZWJln0W0c3chjb": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-12-20 21_34_43.936444",
//     "description": "pani",
//     "timeStamp": 1734710683937
//   },
//   "-OEbbYVtRTREJ7KYLJpG": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2024-12-21 10_38_46.263976",
//     "description": "pani",
//     "timeStamp": 1734757726265
//   },
//   "-OEbtAFlMRhj3RAuUfqS": {
//     "Cost": "80",
//     "category": "Food",
//     "dateTime": "2024-12-21 11_55_45.519534",
//     "description": "peru",
//     "timeStamp": 1734762345521
//   },
//   "-OEnsYXWPsdon5oIN8mo": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2024-12-23 19_48_29.408448",
//     "description": "cake",
//     "timeStamp": 1734963509409
//   },
//   "-OErHwhchMImsxSxUQiV": {
//     "Cost": "290",
//     "category": "Food",
//     "dateTime": "2024-12-24 11_42_39.912006",
//     "description": "hotel shivraj",
//     "timeStamp": 1735020759912
//   },
//   "-OErf47ALTWCsB9gbxmN": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2024-12-24 13_28_05.834788",
//     "description": "pf work transfer",
//     "timeStamp": 1735027085835
//   },
//   "-OEx21pATw91sLqu_epz": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2024-12-25 14_30_53.962794",
//     "description": "OTG",
//     "timeStamp": 1735117253963
//   },
//   "-OEx2VC7VmPm3WYaul9J": {
//     "Cost": "80",
//     "category": "General",
//     "dateTime": "2024-12-25 14_32_54.279648",
//     "description": "screen guard",
//     "timeStamp": 1735117374280
//   },
//   "-OEx8S6SYYUOCwwRalXi": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2024-12-25 14_58_54.492567",
//     "description": "Cadbury",
//     "timeStamp": 1735118934497
//   },
//   "-OEyThtSIrJ5-WaWisfm": {
//     "Cost": "50",
//     "category": "Food",
//     "dateTime": "2024-12-25 21_11_25.468503",
//     "description": "chapati",
//     "timeStamp": 1735141285469
//   },
//   "-OEyVuQLFP4OBZPO82bu": {
//     "Cost": "95",
//     "category": "General",
//     "dateTime": "2024-12-25 21_21_01.076315",
//     "description": "toothpaste",
//     "timeStamp": 1735141861078
//   },
//   "-OFBl9oi4tYL2fbGCnkV": {
//     "Cost": "1500",
//     "category": "General",
//     "dateTime": "2024-12-28 15_46_43.564601",
//     "description": "bai bappa tai",
//     "timeStamp": 1735381003566
//   },
//   "-OFCi303pG6T-zrUnmet": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2024-12-28 20_12_46.468329",
//     "description": "keli",
//     "timeStamp": 1735396966468
//   },
//   "-OFH-8F10pYAST0776j-": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2024-12-29 16_10_15.361605",
//     "description": "pani",
//     "timeStamp": 1735468815362
//   },
//   "-OFHl1oDykELh6T2FQa4": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2024-12-29 19_43_54.061502",
//     "description": "Cadbury",
//     "timeStamp": 1735481634062
//   },
//   "-OFI7ND28fIRPghO-U-X": {
//     "Cost": "48",
//     "category": "Food",
//     "dateTime": "2024-12-29 21_25_51.042758",
//     "description": "pizza",
//     "timeStamp": 1735487751043
//   },
//   "-OFLWJoH6IdNen_775QN": {
//     "Cost": "290",
//     "category": "General",
//     "dateTime": "2024-12-30 13_13_42.353049",
//     "description": "wifi recharge",
//     "timeStamp": 1735544622355
//   },
//   "-OFmTHpR2-niz_zeyV-h": {
//     "Cost": "90",
//     "category": "General",
//     "dateTime": "2025-01-04 23_29_49.851435",
//     "description": "parking",
//     "timeStamp": 1736013589852
//   },
//   "-OFq5iqrymUYtoLU4rkA": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2025-01-05 16_25_22.038204",
//     "description": "pineapple",
//     "timeStamp": 1736074522039
//   },
//   "-OFqo9InzGrGwTCOnPn-": {
//     "Cost": "1200",
//     "category": "General",
//     "dateTime": "2025-01-05 19_43_50.962442",
//     "description": "rent agreement",
//     "timeStamp": 1736086430963
//   },
//   "-OFwbZsFAhae5xh6yNp5": {
//     "Cost": "220",
//     "category": "Food",
//     "dateTime": "2025-01-06 22_46_35.215486",
//     "description": "icecream",
//     "timeStamp": 1736183795216
//   },
//   "-OGKP4-mCadyb9LIRYKp": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2025-01-11 18_18_07.217650",
//     "description": "dahi",
//     "timeStamp": 1736599687218
//   },
//   "-OGKP5f_NMOsc8muHQER": {
//     "Cost": "183",
//     "category": "Food",
//     "dateTime": "2025-01-11 18_18_14.053095",
//     "description": "jevn",
//     "timeStamp": 1736599694053
//   },
//   "-OGKcCYdrWBRAzwWLTHp": {
//     "Cost": "180",
//     "category": "Food",
//     "dateTime": "2025-01-11 19_19_52.233518",
//     "description": "ananas",
//     "timeStamp": 1736603392233
//   },
//   "-OGRK0bxG-1oxu5yM8-a": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2025-01-13 02_33_23.132727",
//     "description": "my recharge ",
//     "timeStamp": 1736715803133
//   },
//   "-OGRK4ia6fKYMCz_Gbl5": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2025-01-13 02_33_39.941892",
//     "description": "chaha",
//     "timeStamp": 1736715819942
//   },
//   "-OGStkCjlTNRCCjMWmDR": {
//     "Cost": "40",
//     "category": "General",
//     "dateTime": "2025-01-13 09_53_28.366198",
//     "description": "tel",
//     "timeStamp": 1736742208367
//   },
//   "-OGVGS9XNUS5roOLgTo6": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2025-01-13 20_56_16.224970",
//     "description": "medical",
//     "timeStamp": 1736781976226
//   },
//   "-OGVGUnoZnEeHMR3VTnA": {
//     "Cost": "300",
//     "category": "General",
//     "dateTime": "2025-01-13 20_56_27.060293",
//     "description": "hotel",
//     "timeStamp": 1736781987061
//   },
//   "-OGVGWZy80tQrITzjO74": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2025-01-13 20_56_34.301575",
//     "description": "petrol",
//     "timeStamp": 1736781994302
//   },
//   "-OGVIBJXPZ3SRFuizsV7": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2025-01-13 21_03_51.521957",
//     "description": "medical",
//     "timeStamp": 1736782431522
//   },
//   "-OGZjlCOmUe4Lm5qfAOS": {
//     "Cost": "5",
//     "category": "Food",
//     "dateTime": "2025-01-14 17_47_11.513254",
//     "description": "biskit",
//     "timeStamp": 1736857031513
//   },
//   "-OGhOvk8fhGpvJ3SOQuT": {
//     "Cost": "19950",
//     "category": "Bhishi",
//     "dateTime": "2025-01-16 10_08_22.472051",
//     "description": "bhishi 4th bhrna",
//     "timeStamp": 1737002302473
//   },
//   "-OGo9N1nJMHp5wEHFxpL": {
//     "Cost": "10000",
//     "category": "Gold bhishi",
//     "dateTime": "2025-01-17 17_37_44.562710",
//     "description": "gold bhishi 6th bhrna",
//     "timeStamp": 1737115664563
//   },
//   "-OGsEWmrH1mFDBJ4eyQ7": {
//     "Cost": "47",
//     "category": "Food",
//     "dateTime": "2025-01-18 12_38_44.086576",
//     "description": "chaha",
//     "timeStamp": 1737184124087
//   },
//   "-OGsUlofjGYrTKEgHzy2": {
//     "Cost": "15000",
//     "category": "Stock and mutual fund",
//     "dateTime": "2025-01-18 13_49_44.042803",
//     "description": "grow investment",
//     "timeStamp": 1737188384043
//   },
//   "-OGsueD6N69HavAuRze9": {
//     "Cost": "200",
//     "category": "Food",
//     "dateTime": "2025-01-18 15_47_10.789649",
//     "description": "icecream",
//     "timeStamp": 1737195430792
//   },
//   "-OGt0fq0j3PurjNRoM3x": {
//     "Cost": "144",
//     "category": "Food",
//     "dateTime": "2025-01-18 16_17_52.448473",
//     "description": "motichoor ladu prasad",
//     "timeStamp": 1737197272449
//   },
//   "-OGt2_nOxw_6NUFbK6dU": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2025-01-18 16_26_11.992983",
//     "description": "icecream",
//     "timeStamp": 1737197771993
//   },
//   "-OGt50fnVBGu0G6sOY9E": {
//     "Cost": "1000",
//     "category": "Food",
//     "dateTime": "2025-01-18 16_36_50.481540",
//     "description": "dryfruits",
//     "timeStamp": 1737198410483
//   },
//   "-OGuHnEDsgSpjj7hsp7b": {
//     "Cost": "465",
//     "category": "Food",
//     "dateTime": "2025-01-18 22_12_16.398180",
//     "description": "jevn",
//     "timeStamp": 1737218536399
//   },
//   "-OH14OWqFGcOrxuYNHi_": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2025-01-20 10_30_40.949486",
//     "description": "Vaseline",
//     "timeStamp": 1737349240950
//   },
//   "-OH1QI4AlWoMYe5lvjwn": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2025-01-20 12_06_21.707297",
//     "description": "aai recharge",
//     "timeStamp": 1737354981707
//   },
//   "-OHDbmN6RZTcR2dKVPSo": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2025-01-22 20_56_22.215124",
//     "description": "pizza",
//     "timeStamp": 1737559582215
//   },
//   "-OHM4oGj0JUehR4CxBPQ": {
//     "Cost": "10",
//     "category": "Food",
//     "dateTime": "2025-01-24 12_24_32.045555",
//     "description": "chips",
//     "timeStamp": 1737701672047
//   },
//   "-OHNteE-wP-ZRKCqisd0": {
//     "Cost": "43",
//     "category": "Food",
//     "dateTime": "2025-01-24 20_50_39.615748",
//     "description": "oats",
//     "timeStamp": 1737732039616
//   },
//   "-OHOVHdXCBoEF7MnQQPC": {
//     "Cost": "150",
//     "category": "Food",
//     "dateTime": "2025-01-24 23_39_26.625740",
//     "description": "icecream",
//     "timeStamp": 1737742166626
//   },
//   "-OHQgsMJ3n6eBsOI1XZo": {
//     "Cost": "18",
//     "category": "General",
//     "dateTime": "2025-01-25 09_53_41.268449",
//     "description": "Xerox",
//     "timeStamp": 1737779021268
//   },
//   "-OHSKld9GbopLfWrVmmx": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2025-01-25 17_31_58.856458",
//     "description": "bhel",
//     "timeStamp": 1737806518858
//   },
//   "-OHSTlHwXAl_zyrlOHoB": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2025-01-25 18_11_16.730257",
//     "description": "rajgira ladu",
//     "timeStamp": 1737808876732
//   },
//   "-OHWUGX--a0A_gizyfAB": {
//     "Cost": "70",
//     "category": "Food",
//     "dateTime": "2025-01-26 12_51_57.631364",
//     "description": "lassi",
//     "timeStamp": 1737876117632
//   },
//   "-OHXrjR-g4hT2XkHyYvr": {
//     "Cost": "400",
//     "category": "General",
//     "dateTime": "2025-01-26 19_18_28.799220",
//     "description": "phone repair",
//     "timeStamp": 1737899308800
//   },
//   "-OHaY_hCmwrXCy7IIhiL": {
//     "Cost": "500",
//     "category": "Stock and mutual fund",
//     "dateTime": "2025-01-27 12_28_54.922224",
//     "description": "shiba crypto",
//     "timeStamp": 1737961134925
//   },
//   "-OHaxQ2Sihy2k9uydZIh": {
//     "Cost": "40",
//     "category": "General",
//     "dateTime": "2025-01-27 14_21_47.035638",
//     "description": "medical",
//     "timeStamp": 1737967907037
//   },
//   "-OHcg6BcqiGGs2YQRhMa": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2025-01-27 22_25_23.687635",
//     "description": "Cadbury",
//     "timeStamp": 1737996923688
//   },
//   "-OHfWwHguoGC5TtDgJJ4": {
//     "Cost": "235",
//     "category": "Food",
//     "dateTime": "2025-01-28 11_39_49.226083",
//     "description": "icecream",
//     "timeStamp": 1738044589228
//   },
//   "-OHfiME0vsY-mxVrpx-1": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2025-01-28 12_34_05.312871",
//     "description": "petrol",
//     "timeStamp": 1738047845313
//   },
//   "-OHgzyh_YesMwDHOiah_": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2025-01-28 18_30_40.677333",
//     "description": "pani",
//     "timeStamp": 1738069240677
//   },
//   "-OHkbCe8X34oMlyEbKrd": {
//     "Cost": "75",
//     "category": "Food",
//     "dateTime": "2025-01-29 11_20_57.161030",
//     "description": "nasta",
//     "timeStamp": 1738129857161
//   },
//   "-OHrWl4OUN5oJwNjZ8cw": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2025-01-30 19_34_29.911705",
//     "description": "petrol",
//     "timeStamp": 1738245869913
//   },
//   "-OHx5FPVxsTQqlRK8JC8": {
//     "Cost": "110",
//     "category": "Food",
//     "dateTime": "2025-01-31 21_32_01.504275",
//     "description": "jevn",
//     "timeStamp": 1738339321504
//   },
//   "-OI05KhqE4vDKmWkziyr": {
//     "Cost": "150",
//     "category": "Food",
//     "dateTime": "2025-02-01 16_10_52.086137",
//     "description": "anjeer",
//     "timeStamp": 1738406452086
//   },
//   "-OI0IJRAlRTjk5tj8oGj": {
//     "Cost": "130",
//     "category": "Food",
//     "dateTime": "2025-02-01 17_07_34.731490",
//     "description": "pineapple",
//     "timeStamp": 1738409854731
//   },
//   "-OI1frLN3xNotAbGCJiV": {
//     "Cost": "310",
//     "category": "Food",
//     "dateTime": "2025-02-01 23_34_26.391620",
//     "description": "jevn",
//     "timeStamp": 1738433066392
//   },
//   "-OI6diPIZtkcVrAiIhUA": {
//     "Cost": "2100",
//     "category": "General",
//     "dateTime": "2025-02-02 22_43_11.571258",
//     "description": "my watch",
//     "timeStamp": 1738516391571
//   },
//   "-OI6dmMnnL4kgGzX_Q8A": {
//     "Cost": "2300",
//     "category": "General",
//     "dateTime": "2025-02-02 22_43_27.795362",
//     "description": "omya watch",
//     "timeStamp": 1738516407795
//   },
//   "-OI6kafSUZhfbcsjZSMC": {
//     "Cost": "500",
//     "category": "General",
//     "dateTime": "2025-02-02 23_13_14.908562",
//     "description": "omkar",
//     "timeStamp": 1738518194909
//   },
//   "-OIAdbu8ldKWVC3L1Pqz": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2025-02-03 17_21_13.800177",
//     "description": "nasta",
//     "timeStamp": 1738583473801
//   },
//   "-OIBNCK4mVEEEe3T5OCM": {
//     "Cost": "300",
//     "category": "Food",
//     "dateTime": "2025-02-03 20_44_45.700801",
//     "description": "jevn",
//     "timeStamp": 1738595685701
//   },
//   "-OIETaOJBIJkDEj4M8ot": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2025-02-04 11_11_32.884418",
//     "description": "pani",
//     "timeStamp": 1738647692885
//   },
//   "-OIEUWtTabHPxUjpAygf": {
//     "Cost": "16",
//     "category": "Food",
//     "dateTime": "2025-02-04 11_15_36.606043",
//     "description": "chaha",
//     "timeStamp": 1738647936606
//   },
//   "-OIKDn3Qz0wWx_LDgn7R": {
//     "Cost": "240.0",
//     "category": "Food",
//     "dateTime": "2025-02-05 14_00_13.786344",
//     "description": "juice",
//     "timeStamp": 1738744213787
//   },
//   "-OIM0tKmgGr1_RCXArtx": {
//     "Cost": "257",
//     "category": "Food",
//     "dateTime": "2025-02-05 22_23_06.034195",
//     "description": "icecream",
//     "timeStamp": 1738774386034
//   },
//   "-OIPybVgqZjGYpK4ibNO": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2025-02-06 16_47_15.435990",
//     "description": "petrol",
//     "timeStamp": 1738840635436
//   },
//   "-OIQMOitGBZWWlZ41I8A": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2025-02-06 18_35_32.599854",
//     "description": "watch kadi",
//     "timeStamp": 1738847132601
//   },
//   "-OIQN6NYB7cz1o09_sgh": {
//     "Cost": "140",
//     "category": "Food",
//     "dateTime": "2025-02-06 18_38_39.587053",
//     "description": "chat",
//     "timeStamp": 1738847319587
//   },
//   "-OIQc-Td_wWJCjJDZS-R": {
//     "Cost": "10000",
//     "category": "Gold bhishi",
//     "dateTime": "2025-02-06 19_48_05.607377",
//     "description": "gold bhishi 7th bhrna",
//     "timeStamp": 1738851485609
//   },
//   "-OIR3oZbgHRpHBcM7Bq8": {
//     "Cost": "90",
//     "category": "General",
//     "dateTime": "2025-02-06 21_53_59.014254",
//     "description": "metro",
//     "timeStamp": 1738859039015
//   },
//   "-OI_PzYfqj1MWMjdV34V": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2025-02-08 17_27_26.123172",
//     "description": "orange",
//     "timeStamp": 1739015846123
//   },
//   "-OI_UIhKhEQ_j9XFQVsJ": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2025-02-08 17_46_17.237196",
//     "description": "dahi",
//     "timeStamp": 1739016977237
//   },
//   "-OIebTpSTtfiX_Q_5buZ": {
//     "Cost": "90",
//     "category": "Food",
//     "dateTime": "2025-02-09 17_40_06.044456",
//     "description": "juice",
//     "timeStamp": 1739103006045
//   },
//   "-OIfkgrcOFqmK50MTFEf": {
//     "Cost": "180",
//     "category": "Food",
//     "dateTime": "2025-02-09 23_00_00.039587",
//     "description": "icecream",
//     "timeStamp": 1739122200040
//   },
//   "-OIi_JMphmKCM-uRJBu7": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2025-02-10 12_09_07.763637",
//     "description": "my recharge",
//     "timeStamp": 1739169547765
//   },
//   "-OIj0K5QwY8jW_6kc1o6": {
//     "Cost": "280",
//     "category": "Food",
//     "dateTime": "2025-02-10 14_11_30.778098",
//     "description": "icecream",
//     "timeStamp": 1739176890780
//   },
//   "-OIjsb_YQckeuYuldeIz": {
//     "Cost": "967",
//     "category": "General",
//     "dateTime": "2025-02-10 18_13_04.418768",
//     "description": "dmart shirt",
//     "timeStamp": 1739191384419
//   },
//   "-OJ1t8iCQz4-Q-c38dct": {
//     "Cost": "21650.0",
//     "category": "Bhishi",
//     "dateTime": "2025-02-14 10_48_11.339192",
//     "description": "bhishi 5th bhrna",
//     "timeStamp": 1739510291341
//   },
//   "-OJ8lag1uhciHIAx0hEk": {
//     "Cost": "25",
//     "category": "Food",
//     "dateTime": "2025-02-15 18_52_33.343607",
//     "description": "chaha",
//     "timeStamp": 1739625753346
//   },
//   "-OJ9EIuM3nti3MnSm8-o": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2025-02-15 21_02_20.757490",
//     "description": "hawa",
//     "timeStamp": 1739633540759
//   },
//   "-OJ9EK0W7aoRrjErvtpC": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2025-02-15 21_02_25.311509",
//     "description": "keli",
//     "timeStamp": 1739633545313
//   },
//   "-OJYvVWulEAb6itm-PkS": {
//     "Cost": "90",
//     "category": "Food",
//     "dateTime": "2025-02-20 20_45_57.177309",
//     "description": "vadapav chips",
//     "timeStamp": 1740064557178
//   },
//   "-OJb6ztnWii8_4GcOXma": {
//     "Cost": "279",
//     "category": "Food",
//     "dateTime": "2025-02-21 11_39_23.058214",
//     "description": "icecream",
//     "timeStamp": 1740118163059
//   },
//   "-OJc3TdVIwRcG7X62W3o": {
//     "Cost": "38020.0",
//     "category": "General",
//     "dateTime": "2025-02-21 16_03_37.629393",
//     "description": "pappa lic (jaga 50k valun ghetle)",
//     "timeStamp": 1740134017632
//   },
//   "-OJg4wEdL8xbl1PNIB6x": {
//     "Cost": "35",
//     "category": "Food",
//     "dateTime": "2025-02-22 10_48_29.864851",
//     "description": "rajgira",
//     "timeStamp": 1740201509865
//   },
//   "-OJgBx-aMdO_v2oFP90F": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2025-02-22 11_19_08.003606",
//     "description": "dadhi",
//     "timeStamp": 1740203348006
//   },
//   "-OJgD4XMIX9ZRXkm8rXm": {
//     "Cost": "70",
//     "category": "General",
//     "dateTime": "2025-02-22 11_24_05.079231",
//     "description": "perfume",
//     "timeStamp": 1740203645079
//   },
//   "-OJkc_Pq_kVAzumDtaiA": {
//     "Cost": "10",
//     "category": "General",
//     "dateTime": "2025-02-23 07_58_20.276638",
//     "description": "Colgate",
//     "timeStamp": 1740277700278
//   },
//   "-OJmJ0BwM0FmGqTfSNBK": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2025-02-23 15_47_43.482880",
//     "description": "pani",
//     "timeStamp": 1740305863485
//   },
//   "-OJrB9mrkAFHf7YaujxM": {
//     "Cost": "110",
//     "category": "Food",
//     "dateTime": "2025-02-24 14_31_31.701928",
//     "description": "icecream",
//     "timeStamp": 1740387691703
//   },
//   "-OJs82ZAGXcECf5j6-zE": {
//     "Cost": "1135",
//     "category": "General",
//     "dateTime": "2025-02-24 18_57_32.874877",
//     "description": "omya engagement",
//     "timeStamp": 1740403652875
//   },
//   "-OK1vyL0HMTJb6vUWMjK": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2025-02-26 21_16_12.992091",
//     "description": "omkya",
//     "timeStamp": 1740584772993
//   },
//   "-OK7V8qvH66n8AnMpGuo": {
//     "Cost": "130",
//     "category": "Food",
//     "dateTime": "2025-02-27 23_12_23.418538",
//     "description": "icecream",
//     "timeStamp": 1740678143419
//   },
//   "-OK7XAiQQSpmydCSBQFj": {
//     "Cost": "105",
//     "category": "Food",
//     "dateTime": "2025-02-27 23_21_15.354760",
//     "description": "icecream",
//     "timeStamp": 1740678675355
//   },
//   "-OKFJZEe_Bl_X2D32i5E": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2025-03-01 11_38_43.498031",
//     "description": "khari",
//     "timeStamp": 1740809323498
//   },
//   "-OKGu3zgnO7hZ4x8vgT8": {
//     "Cost": "160",
//     "category": "Food",
//     "dateTime": "2025-03-01 19_02_14.187417",
//     "description": "chiku",
//     "timeStamp": 1740835934189
//   },
//   "-OKGzItfGHJkKDGPyH25": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2025-03-01 19_25_05.962952",
//     "description": "patrika",
//     "timeStamp": 1740837305963
//   },
//   "-OKHCiRAaj8U6F0k9g4q": {
//     "Cost": "284",
//     "category": "General",
//     "dateTime": "2025-03-01 20_28_04.681536",
//     "description": "dmart",
//     "timeStamp": 1740841084683
//   },
//   "-OKKanzIMlg80TGcPzc1": {
//     "Cost": "40",
//     "category": "General",
//     "dateTime": "2025-03-02 12_16_32.657766",
//     "description": "sprite",
//     "timeStamp": 1740897992659
//   },
//   "-OKKb-xD_aWtejDFzjHm": {
//     "Cost": "300",
//     "category": "General",
//     "dateTime": "2025-03-02 12_17_25.773472",
//     "description": "dan",
//     "timeStamp": 1740898045774
//   },
//   "-OKLyjXEXZo1n5-c_t4I": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2025-03-02 18_40_43.085779",
//     "description": "pappa",
//     "timeStamp": 1740921043087
//   },
//   "-OKQFTf_Ff0nhRiYy3QS": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2025-03-03 14_36_41.509179",
//     "description": "ras",
//     "timeStamp": 1740992801509
//   },
//   "-OKQO1iDVaBoflV_wb3H": {
//     "Cost": "10000.0",
//     "category": "General",
//     "dateTime": "2025-03-03 15_14_06.285988",
//     "description": "pappa Maharaj kapde ( 50k valun ghetle)",
//     "timeStamp": 1740995046286
//   },
//   "-OKWO9dqBiEvUNkD8NLz": {
//     "Cost": "70",
//     "category": "Food",
//     "dateTime": "2025-03-04 19_12_22.069026",
//     "description": "nasta",
//     "timeStamp": 1741095742071
//   },
//   "-OKWgaRj6IVHNHglON7u": {
//     "Cost": "400",
//     "category": "General",
//     "dateTime": "2025-03-04 20_37_16.653984",
//     "description": "petrol",
//     "timeStamp": 1741100836655
//   },
//   "-OKWk3s9cz0TylOpGafI": {
//     "Cost": "70",
//     "category": "General",
//     "dateTime": "2025-03-04 20_52_27.722116",
//     "description": "capacitor",
//     "timeStamp": 1741101747722
//   },
//   "-OKbD_DZOWWeFTtNbV_M": {
//     "Cost": "1385",
//     "category": "Food",
//     "dateTime": "2025-03-05 22_23_50.626774",
//     "description": "hotel jevn",
//     "timeStamp": 1741193630629
//   },
//   "-OKec5yFKVwobUVxp6yT": {
//     "Cost": "80",
//     "category": "General",
//     "dateTime": "2025-03-06 14_14_14.095261",
//     "description": "mal",
//     "timeStamp": 1741250654096
//   },
//   "-OKedgtXSgBACwRPNk4u": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2025-03-06 14_21_11.586245",
//     "description": "tak",
//     "timeStamp": 1741251071586
//   },
//   "-OKgR0I9sz95mmXNa4_O": {
//     "Cost": "160",
//     "category": "Food",
//     "dateTime": "2025-03-06 22_40_39.561073",
//     "description": "icecream",
//     "timeStamp": 1741281039562
//   },
//   "-OKkGXoZwz3sxlCnHWBd": {
//     "Cost": "1450",
//     "category": "General",
//     "dateTime": "2025-03-07 16_33_22.147065",
//     "description": "door lock latch",
//     "timeStamp": 1741345402148
//   },
//   "-OKkLsVDcFIkJnOkop6s": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2025-03-07 16_56_41.677421",
//     "description": "car battery",
//     "timeStamp": 1741346801678
//   },
//   "-OKkT3YUuq7LdF7aZUTx": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2025-03-07 17_28_06.047200",
//     "description": "lock chavi",
//     "timeStamp": 1741348686048
//   },
//   "-OKkdpucQsmtr0PK8kg0": {
//     "Cost": "10000",
//     "category": "Gold bhishi",
//     "dateTime": "2025-03-07 18_19_31.814694",
//     "description": "gold bhishi 8th bhrna",
//     "timeStamp": 1741351771816
//   },
//   "-OKl3RcrROVxhPJNW_P1": {
//     "Cost": "400",
//     "category": "Food",
//     "dateTime": "2025-03-07 20_15_46.167027",
//     "description": "omkar cafe",
//     "timeStamp": 1741358746167
//   },
//   "-OKlEzKoPwfJ8HgJM8-w": {
//     "Cost": "280",
//     "category": "Food",
//     "dateTime": "2025-03-07 21_06_11.892139",
//     "description": "jevn",
//     "timeStamp": 1741361771892
//   },
//   "-OKqBWH4Tl-2gYfnr5P-": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2025-03-08 20_09_08.420543",
//     "description": "chips",
//     "timeStamp": 1741444748421
//   },
//   "-OKqBZwVUx1lDJEYyM1Q": {
//     "Cost": "160",
//     "category": "Food",
//     "dateTime": "2025-03-08 20_09_23.423674",
//     "description": "motichoor",
//     "timeStamp": 1741444763424
//   },
//   "-OKvYP-jWIps2mdYui4D": {
//     "Cost": "300",
//     "category": "Food",
//     "dateTime": "2025-03-09 21_07_14.029564",
//     "description": "jevn",
//     "timeStamp": 1741534634032
//   },
//   "-OL-wSPn_qQrvZxBonUf": {
//     "Cost": "170",
//     "category": "Food",
//     "dateTime": "2025-03-10 22_14_47.666833",
//     "description": "oats",
//     "timeStamp": 1741625087667
//   },
//   "-OL0Il41YwQ9q5raigo6": {
//     "Cost": "880",
//     "category": "General",
//     "dateTime": "2025-03-10 23_56_37.506336",
//     "description": "car number plate",
//     "timeStamp": 1741631197507
//   },
//   "-OL7ex7K0chv2b9T7AdS": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2025-03-12 10_15_16.691764",
//     "description": "my recharge",
//     "timeStamp": 1741754716693
//   },
//   "-OLDsVmyJjQ7XvWUrJgN": {
//     "Cost": "1113",
//     "category": "General",
//     "dateTime": "2025-03-13 15_12_13.948671",
//     "description": "swing chair zoka",
//     "timeStamp": 1741858933951
//   },
//   "-OLIjdC7e4I3U91Izl4h": {
//     "Cost": "21000",
//     "category": "Bhishi",
//     "dateTime": "2025-03-14 13_51_35.174020",
//     "description": "bhishi 6th bhrna",
//     "timeStamp": 1741940495176
//   },
//   "-OLT3Ada2H6t0P5ILZG7": {
//     "Cost": "450",
//     "category": "General",
//     "dateTime": "2025-03-16 13_57_31.299850",
//     "description": "ukal jata",
//     "timeStamp": 1742113651302
//   },
//   "-OLXqg_1Fw29AtTs4i46": {
//     "Cost": "2847",
//     "category": "General",
//     "dateTime": "2025-03-17 12_16_42.240178",
//     "description": "nagao trip",
//     "timeStamp": 1742194002242
//   },
//   "-OLXuoQnzQdiUfeNpsb9": {
//     "Cost": "600",
//     "category": "General",
//     "dateTime": "2025-03-17 12_34_42.993763",
//     "description": "under eye cream",
//     "timeStamp": 1742195082995
//   },
//   "-OLrsirQAXtNeHm7tQ1Y": {
//     "Cost": "175",
//     "category": "Food",
//     "dateTime": "2025-03-21 14_17_37.434274",
//     "description": "icecream",
//     "timeStamp": 1742546857435
//   },
//   "-OLy2aEVAOLZjWQGnl83": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2025-03-22 19_02_48.990428",
//     "description": "chaha",
//     "timeStamp": 1742650368993
//   },
//   "-OM1hY-PDiehBs7HNqZt": {
//     "Cost": "29",
//     "category": "General",
//     "dateTime": "2025-03-23 16_44_34.649828",
//     "description": "wire",
//     "timeStamp": 1742728474650
//   },
//   "-OM1iYohz9ONmfrMrq-o": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2025-03-23 16_49_00.140879",
//     "description": "juice",
//     "timeStamp": 1742728740141
//   },
//   "-OM6T7cedyjp-32CCEiL": {
//     "Cost": "10000",
//     "category": "Stock and mutual fund",
//     "dateTime": "2025-03-24 14_55_20.553065",
//     "description": "sip",
//     "timeStamp": 1742808320554
//   },
//   "-OMCkbUXDQthI90Xziqs": {
//     "Cost": "800",
//     "category": "General",
//     "dateTime": "2025-03-25 20_13_48.832243",
//     "description": "baglya lagn train tickets",
//     "timeStamp": 1742913828834
//   },
//   "-OMLL8J2DWdgVsvh5Y1i": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2025-03-27 12_14_44.418140",
//     "description": "petrol",
//     "timeStamp": 1743057884420
//   },
//   "-OMNDubQA6YUAD4ttuT2": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2025-03-27 21_02_23.641643",
//     "description": "aai recharge",
//     "timeStamp": 1743089543643
//   },
//   "-OMNZpus9STSh5BDP_S6": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2025-03-27 22_38_11.574359",
//     "description": "kes cutting",
//     "timeStamp": 1743095291576
//   },
//   "-OMT1z4u76nbGS4GTxGa": {
//     "Cost": "150",
//     "category": "General",
//     "dateTime": "2025-03-29 00_07_59.544789",
//     "description": "dan",
//     "timeStamp": 1743187079546
//   },
//   "-OMVm8seUFDGXRGoRQ-t": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2025-03-29 12_53_18.953609",
//     "description": "riksha",
//     "timeStamp": 1743232998954
//   },
//   "-OMXL32PS7wQ2kNVnBuR": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2025-03-29 20_09_49.465611",
//     "description": "pani",
//     "timeStamp": 1743259189466
//   },
//   "-OM_DgjkW5mA9SQiYhCn": {
//     "Cost": "110",
//     "category": "General",
//     "dateTime": "2025-03-30 09_36_30.638621",
//     "description": "petrol",
//     "timeStamp": 1743307590641
//   },
//   "-OM_XnV1oA4YjC7pnznE": {
//     "Cost": "35",
//     "category": "Food",
//     "dateTime": "2025-03-30 11_04_21.186216",
//     "description": "kirana",
//     "timeStamp": 1743312861186
//   },
//   "-OMa_RYydrgxhmT4bXP1": {
//     "Cost": "20",
//     "category": "General",
//     "dateTime": "2025-03-30 15_55_30.874649",
//     "description": "pani",
//     "timeStamp": 1743330330878
//   },
//   "-OMb2wkgxqWa0BVz-NHL": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2025-03-30 18_08_47.083091",
//     "description": "petrol",
//     "timeStamp": 1743338327084
//   },
//   "-OMbfE8sPK5GutcCHlh4": {
//     "Cost": "390",
//     "category": "Food",
//     "dateTime": "2025-03-30 21_00_26.039261",
//     "description": "misal",
//     "timeStamp": 1743348626040
//   },
//   "-OMeosHODr-7IglKSXqK": {
//     "Cost": "180",
//     "category": "Food",
//     "dateTime": "2025-03-31 11_41_25.464375",
//     "description": "pani",
//     "timeStamp": 1743401485465
//   },
//   "-OMeoziBApr_7shyENSq": {
//     "Cost": "581.0",
//     "category": "General",
//     "dateTime": "2025-03-31 11_41_55.916148",
//     "description": "wifi recharge",
//     "timeStamp": 1743401515916
//   },
//   "-OMgR4Dgw2BOktxE3VKJ": {
//     "Cost": "20",
//     "category": "Food",
//     "dateTime": "2025-03-31 19_12_19.306943",
//     "description": "shevga",
//     "timeStamp": 1743428539308
//   },
//   "-OMh2woSjuip_NYpLWon": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2025-03-31 22_06_30.620445",
//     "description": "petrol",
//     "timeStamp": 1743438990621
//   },
//   "-OMj_Akr68aJ0H82mrXI": {
//     "Cost": "90",
//     "category": "Food",
//     "dateTime": "2025-04-01 09_50_57.014161",
//     "description": "khava",
//     "timeStamp": 1743481257015
//   },
//   "-ON6-JpVFesYC9OxF5Y8": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2025-04-05 23_00_48.030820",
//     "description": "pani",
//     "timeStamp": 1743874248032
//   },
//   "-ONAspiu758WBL40-fZ_": {
//     "Cost": "10000",
//     "category": "Gold bhishi",
//     "dateTime": "2025-04-06 21_46_11.705319",
//     "description": "gold bhishi 9th bhrna",
//     "timeStamp": 1743956171706
//   },
//   "-ONVEnWcbyYZri6BxXoz": {
//     "Cost": "1001",
//     "category": "General",
//     "dateTime": "2025-04-10 20_38_56.294740",
//     "description": "yatra vargani",
//     "timeStamp": 1744297736296
//   },
//   "-ONXzAyKefuCqO-wuxYJ": {
//     "Cost": "199",
//     "category": "General",
//     "dateTime": "2025-04-11 09_25_11.636398",
//     "description": "my recharge",
//     "timeStamp": 1744343711637
//   },
//   "-ONY28jb6EK4QkksvxuA": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2025-04-11 09_42_31.078500",
//     "description": "chips",
//     "timeStamp": 1744344751079
//   },
//   "-ON_piBbKqhEy9oGg1Hn": {
//     "Cost": "1000",
//     "category": "General",
//     "dateTime": "2025-04-11 22_42_42.021677",
//     "description": "hotel",
//     "timeStamp": 1744391562023
//   },
//   "-ONdAXejgyNmDGH4JQNm": {
//     "Cost": "60",
//     "category": "General",
//     "dateTime": "2025-04-12 14_16_53.613741",
//     "description": "cutter",
//     "timeStamp": 1744447613615
//   },
//   "-ONe3pS-qFyAcp7bA4tm": {
//     "Cost": "160.0",
//     "category": "Food",
//     "dateTime": "2025-04-12 18_27_12.767159",
//     "description": "juice",
//     "timeStamp": 1744462632768
//   },
//   "-ONeYCDom8qTSCfPQuG7": {
//     "Cost": "115",
//     "category": "Food",
//     "dateTime": "2025-04-12 20_39_54.483155",
//     "description": "paratha",
//     "timeStamp": 1744470594484
//   },
//   "-ONg1YoyfViv9DATGDzk": {
//     "Cost": "200",
//     "category": "General",
//     "dateTime": "2025-04-13 03_36_30.716886",
//     "description": "movie",
//     "timeStamp": 1744495590718
//   },
//   "-ONjaCFB1G4ATdfkIvVR": {
//     "Cost": "70",
//     "category": "Food",
//     "dateTime": "2025-04-13 20_11_07.084322",
//     "description": "dalcha",
//     "timeStamp": 1744555267084
//   },
//   "-ONnb327no6Dor-0eL1-": {
//     "Cost": "21500.0",
//     "category": "Gold bhishi",
//     "dateTime": "2025-04-14 14_53_20.386725",
//     "description": "bhishi 7th bhrna",
//     "timeStamp": 1744622600392
//   },
//   "-ONzfe7-UTO07FO-5tH4": {
//     "Cost": "30",
//     "category": "General",
//     "dateTime": "2025-04-16 23_08_51.519919",
//     "description": " soham jumping",
//     "timeStamp": 1744825131521
//   },
//   "-OO26zHLPcapX75Vb2sd": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2025-04-17 15_11_29.876857",
//     "description": "maza",
//     "timeStamp": 1744882889878
//   },
//   "-OO3LrQLDvIBCnhte2OY": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2025-04-17 20_56_07.060360",
//     "description": "petrol",
//     "timeStamp": 1744903567062
//   },
//   "-OOB62O-V3_VNnpZODr2": {
//     "Cost": "430",
//     "category": "Food",
//     "dateTime": "2025-04-19 09_03_59.487450",
//     "description": "nasta",
//     "timeStamp": 1745033639488
//   },
//   "-OOCLebMzJ4W7UHqnw_v": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2025-04-19 14_51_49.526168",
//     "description": "maza",
//     "timeStamp": 1745054509527
//   },
//   "-OOOX5mnYKOf-FKHdor7": {
//     "Cost": "230",
//     "category": "Food",
//     "dateTime": "2025-04-21 23_37_15.121722",
//     "description": "icecream",
//     "timeStamp": 1745258835123
//   },
//   "-OOXJEQV88wEOXvq1wic": {
//     "Cost": "156",
//     "category": "Food",
//     "dateTime": "2025-04-23 16_33_15.422279",
//     "description": "icecream",
//     "timeStamp": 1745406195424
//   },
//   "-OOgF1ZoVDKO6BhxZh0G": {
//     "Cost": "6000",
//     "category": "Udhar dile",
//     "dateTime": "2025-04-25 14_51_06.354188",
//     "description": "pappa car battery",
//     "timeStamp": 1745572866356
//   },
//   "-OOgQRJljGO_K0lWi4RS": {
//     "Cost": "160",
//     "category": "Food",
//     "dateTime": "2025-04-25 15_40_55.408780",
//     "description": "icecream",
//     "timeStamp": 1745575855409
//   },
//   "-OOgum9aJQanWYtP2nu9": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2025-04-25 17_57_51.332989",
//     "description": "khari ",
//     "timeStamp": 1745584071334
//   },
//   "-OOkgGHyEOwKZxJRfJ4X": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2025-04-26 11_32_55.549201",
//     "description": "naral",
//     "timeStamp": 1745647375550
//   },
//   "-OOqXL7fq6hrjAl5Ei13": {
//     "Cost": "500",
//     "category": "Udhar dile",
//     "dateTime": "2025-04-27 14_47_17.225698",
//     "description": "himya disel",
//     "timeStamp": 1745745437230
//   },
//   "-OOw9VUHuxPK027QywEt": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2025-04-28 17_00_51.472806",
//     "description": "petrol",
//     "timeStamp": 1745839851474
//   },
//   "-OOwJpVMD0teOr50xHgg": {
//     "Cost": "650",
//     "category": "General",
//     "dateTime": "2025-04-28 17_45_58.997411",
//     "description": "kapde",
//     "timeStamp": 1745842558999
//   },
//   "-OOwfhiJPub2Fx6UqYVf": {
//     "Cost": "294",
//     "category": "General",
//     "dateTime": "2025-04-28 19_25_56.435506",
//     "description": "hand sleeve",
//     "timeStamp": 1745848556436
//   },
//   "-OOwj-Ebi-r0UfqKk109": {
//     "Cost": "26",
//     "category": "General",
//     "dateTime": "2025-04-28 19_40_18.727390",
//     "description": "goli",
//     "timeStamp": 1745849418727
//   },
//   "-OOx393klrRXgAKRFlTB": {
//     "Cost": "300",
//     "category": "Food",
//     "dateTime": "2025-04-28 21_12_44.014667",
//     "description": "chana chuna",
//     "timeStamp": 1745854964016
//   },
//   "-OP1UNcv9Z1Mh_qJxKjj": {
//     "Cost": "140",
//     "category": "Food",
//     "dateTime": "2025-04-29 22_29_47.641287",
//     "description": "nasta",
//     "timeStamp": 1745945987643
//   },
//   "-OP43XObivmHEARafDXN": {
//     "Cost": "500",
//     "category": "General",
//     "dateTime": "2025-04-30 10_31_21.382264",
//     "description": "bagal lagn aher",
//     "timeStamp": 1745989281383
//   },
//   "-OP6ym0I2_eIAK7QMkuN": {
//     "Cost": "70",
//     "category": "Food",
//     "dateTime": "2025-05-01 00_05_04.145519",
//     "description": "chaha",
//     "timeStamp": 1746038104147
//   },
//   "-OP6ypoCgh0JRqt8fxo_": {
//     "Cost": "120",
//     "category": "Food",
//     "dateTime": "2025-05-01 00_05_19.693198",
//     "description": "pani kachori",
//     "timeStamp": 1746038119693
//   },
//   "-OP757jYIjswMZwIrxyx": {
//     "Cost": "40",
//     "category": "Food",
//     "dateTime": "2025-05-01 00_37_12.226536",
//     "description": "pani",
//     "timeStamp": 1746040032227
//   },
//   "-OP7nbN3QOKO-vxSnWLX": {
//     "Cost": "60",
//     "category": "Food",
//     "dateTime": "2025-05-01 03_55_54.179513",
//     "description": "pani",
//     "timeStamp": 1746051954180
//   },
//   "-OPA12uB03-jZssAKT8r": {
//     "Cost": "360.0",
//     "category": "Food",
//     "dateTime": "2025-05-01 14_18_15.499634",
//     "description": "lassi",
//     "timeStamp": 1746089295500
//   },
//   "-OPAuxXjUIgBlpczG5A6": {
//     "Cost": "31",
//     "category": "General",
//     "dateTime": "2025-05-01 18_26_51.630044",
//     "description": "metro pune to kasarwadi",
//     "timeStamp": 1746104211632
//   },
//   "-OPBBeA02wyA2-qrBElm": {
//     "Cost": "50",
//     "category": "General",
//     "dateTime": "2025-05-01 19_44_10.880741",
//     "description": "riksha",
//     "timeStamp": 1746108850881
//   },
//   "-OPEzKMp1hsK5St4hyW3": {
//     "Cost": "10000",
//     "category": "Gold bhishi",
//     "dateTime": "2025-05-02 13_24_26.676824",
//     "description": "gold bhishi 10th bhrna",
//     "timeStamp": 1746172466677
//   },
//   "-OPLw_Dv-7_-e3urAS6F": {
//     "Cost": "2352.0",
//     "category": "Udhar dile",
//     "dateTime": "2025-05-03 21_49_45.722064",
//     "description": "dmart",
//     "timeStamp": 1746289185723
//   },
//   "-OPMFMk0fkfvPWVanl42": {
//     "Cost": "1000",
//     "category": "Food",
//     "dateTime": "2025-05-03 23_16_13.375531",
//     "description": "dry fruits",
//     "timeStamp": 1746294373377
//   },
//   "-OPQm9RWhzYr7lD2Lx4o": {
//     "Cost": "100",
//     "category": "Food",
//     "dateTime": "2025-05-04 20_22_20.640006",
//     "description": "chips",
//     "timeStamp": 1746370340642
//   },
//   "-OPW6ar3vyyoBYUy8g_Q": {
//     "Cost": "105",
//     "category": "General",
//     "dateTime": "2025-05-05 21_14_08.129365",
//     "description": "petrol",
//     "timeStamp": 1746459848132
//   },
//   "-OPZg4xJH8LLUOoiYCWD": {
//     "Cost": "130",
//     "category": "Food",
//     "dateTime": "2025-05-06 13_52_24.339529",
//     "description": "pulav",
//     "timeStamp": 1746519744340
//   },
//   "-OPaPwWhVqhDX_YZuNfS": {
//     "Cost": "11",
//     "category": "Food",
//     "dateTime": "2025-05-06 21_56_43.692058",
//     "description": "eno",
//     "timeStamp": 1746548803694
//   },
//   "-OPecnkLFv2z0AQ1K2tP": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2025-05-07 17_35_46.644663",
//     "description": "khari",
//     "timeStamp": 1746619546646
//   },
//   "-OPo1BVmsPKTuBYtNxGB": {
//     "Cost": "399",
//     "category": "General",
//     "dateTime": "2025-05-09 13_23_16.592995",
//     "description": "jio sim",
//     "timeStamp": 1746777196594
//   },
//   "-OPo1D_Lb8DjlpBUF89r": {
//     "Cost": "420",
//     "category": "General",
//     "dateTime": "2025-05-09 13_23_25.077349",
//     "description": "ashu oil",
//     "timeStamp": 1746777205079
//   },
//   "-OPpi6ygN3O-GgSeWNZG": {
//     "Cost": "696",
//     "category": "Udhar dile",
//     "dateTime": "2025-05-09 21_14_49.579513",
//     "description": "kirana",
//     "timeStamp": 1746805489581
//   },
//   "-OPuDRO87gRybY_ki7yI": {
//     "Cost": "983",
//     "category": "Udhar dile",
//     "dateTime": "2025-05-10 18_14_30.664476",
//     "description": "omya dmart",
//     "timeStamp": 1746881070665
//   },
//   "-OPuDU6ueHDSdfQbGuaS": {
//     "Cost": "69",
//     "category": "Food",
//     "dateTime": "2025-05-10 18_14_41.849977",
//     "description": "icecream",
//     "timeStamp": 1746881081850
//   },
//   "-OPuDVrLmvDQnEEK85k5": {
//     "Cost": "30",
//     "category": "Food",
//     "dateTime": "2025-05-10 18_14_48.977928",
//     "description": "khari",
//     "timeStamp": 1746881088982
//   },
//   "-OPuDYLAxzvU-iDmDdjs": {
//     "Cost": "170",
//     "category": "Food",
//     "dateTime": "2025-05-10 18_14_59.147371",
//     "description": "srikhand",
//     "timeStamp": 1746881099147
//   },
//   "-OPyXede1AtnKZAUu90o": {
//     "Cost": "130",
//     "category": "General",
//     "dateTime": "2025-05-11 14_21_20.807968",
//     "description": "cutting",
//     "timeStamp": 1746953480810
//   },
//   "-OPyXlVG7tmbf25UD4sr": {
//     "Cost": "10000",
//     "category": "Gold bhishi",
//     "dateTime": "2025-05-11 14_21_48.880958",
//     "description": "gold bhishi 1st bhrna",
//     "timeStamp": 1746953508881
//   },
//   "-OPybTyUef0Xmak8FRrG": {
//     "Cost": "100",
//     "category": "General",
//     "dateTime": "2025-05-11 14_42_23.709945",
//     "description": "Omkar",
//     "timeStamp": 1746954743711
//   }
// };
