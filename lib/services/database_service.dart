import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_story/models/fashion.dart';
import 'package:fashion_story/models/theNew.dart';
import 'package:fashion_story/models/video.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();
  Firestore _db = Firestore.instance;
  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<List<Fashion>> getSoMi() {
    return _db.collection('somi').snapshots().map((snapshot) => snapshot
        .documents
        .map((doc) => Fashion.fromMap(doc.data, doc.documentID))
        .toList());
  }

  Stream<List<Fashion>> getThun() {
    return _db.collection('aothun').snapshots().map((snapshot) => snapshot
        .documents
        .map((doc) => Fashion.fromMap(doc.data, doc.documentID))
        .toList());
  }

  Stream<List<Fashion>> getAoKhoac() {
    return _db.collection('aokhoac').snapshots().map((snapshot) => snapshot
        .documents
        .map((doc) => Fashion.fromMap(doc.data, doc.documentID))
        .toList());
  }

  Stream<List<Fashion>> getCart() {
    return _db.collection('cards').snapshots().map((snapshot) => snapshot
        .documents
        .map((doc) => Fashion.fromMap(doc.data, doc.documentID))
        .toList());
  }

  //getFavorite
  Stream<List<Fashion>> getFavorite() {
    return _db.collection('favorities').snapshots().map((snapshot) => snapshot
        .documents
        .map((doc) => Fashion.fromMap(doc.data, doc.documentID))
        .toList());
  }

  //getFavorite
  Future<void> addFavorite(Fashion fashion) {
    return _db.collection('favorities').add(fashion.toMap());
  }

  // Add cart
  Future<void> addCart(Fashion fashion) {
    return _db.collection('cards').add(fashion.toMap());
  }

  //add fashion
  Future<void> addSomi(Fashion fashion) {
    return _db.collection('somi').add(fashion.toMap());
  }

  Future<void> addAoThun(Fashion fashion) {
    return _db.collection('aothun').add(fashion.toMap());
  }

  Future<void> addaoKhoac(Fashion fashion) {
    return _db.collection('aokhoac').add(fashion.toMap());
  }

  Future<void> addGiayNam(Fashion fashion) {
    return _db.collection('giaynam').add(fashion.toMap());
  }

  Future<void> addBalo(Fashion fashion) {
    return _db.collection('balo').add(fashion.toMap());
  }

  Future<void> addQuanshot(Fashion fashion) {
    return _db.collection('quanshot').add(fashion.toMap());
  }

  Future<void> addDonHang(Fashion fashion) {
    return _db.collection('donhang').add(fashion.toMap());
  }

  Future<void> deleteFavorite(String id) {
    return _db.collection('favorities').document(id).delete();
  }

  // Delete Fashion
  Future<void> deleteFashion(String id) {
    return _db.collection('cards').document(id).delete();
  }

  // Edit fashion
  Future<void> editFashion(Fashion fashion) {
    return _db
        .collection('cards')
        .document(fashion.id)
        .updateData(fashion.toMap());
  }

  // The new services
  //getTheNer
  Stream<List<TheNew>> getTuVanMacDep() {
    return _db.collection('tintuc_tuvanmacdep').snapshots().map((snapshot) =>
        snapshot.documents
            .map((doc) => TheNew.fromMap(doc.data, doc.documentID))
            .toList());
  }

  Stream<List<TheNew>> getThoiTrangSao() {
    return _db.collection('tintuc_thoitrangsao').snapshots().map((snapshot) =>
        snapshot.documents
            .map((doc) => TheNew.fromMap(doc.data, doc.documentID))
            .toList());
  }

  Stream<List<TheNew>> getHangHieu() {
    return _db.collection('tintuc_hanghieu').snapshots().map((snapshot) =>
        snapshot.documents
            .map((doc) => TheNew.fromMap(doc.data, doc.documentID))
            .toList());
  }

  // count Sơ mi
  Future<int> numberSoMi() async {
    QuerySnapshot snapshot = await _db.collection('somi').getDocuments();
    return snapshot.documents.length;
  }

  // count Áo thun
  Future<int> numberAoThun() async {
    QuerySnapshot snapshot = await _db.collection('aothun').getDocuments();
    return snapshot.documents.length;
  }

  //count áo khoác
  Future<int> numberAoKhoac() async {
    QuerySnapshot snapshot = await _db.collection('aokhoac').getDocuments();
    return snapshot.documents.length;
  }

  Future<int> numberBalo() async {
    QuerySnapshot snapshot = await _db.collection('balo').getDocuments();
    return snapshot.documents.length;
  }

  Future<int> numberQuanShot() async {
    QuerySnapshot snapshot = await _db.collection('quanshot').getDocuments();
    return snapshot.documents.length;
  }

  Future<int> numberGiayNam() async {
    QuerySnapshot snapshot = await _db.collection('giaynam').getDocuments();
    return snapshot.documents.length;
  }

  Future<int> numberHangHieu() async {
    QuerySnapshot snapshot =
        await _db.collection('tintuc_hanghieu').getDocuments();
    return snapshot.documents.length;
  }

  Future<int> numberTuVanLamDep() async {
    QuerySnapshot snapshot =
        await _db.collection('tintuc_thoitrangsao').getDocuments();
    return snapshot.documents.length;
  }

  Future<int> numberSao() async {
    QuerySnapshot snapshot =
        await _db.collection('tintuc_tuvanmacdep').getDocuments();
    return snapshot.documents.length;
  }

  //Video player
  Stream<List<Video>> getVideo() {
    return _db.collection('videos').snapshots().map((snapshot) => snapshot
        .documents
        .map((doc) => Video.fromMap(doc.data, doc.documentID))
        .toList());
  }

  Future<void> addVideo(Video video) {
    return _db.collection('videos').add(video.toMap());
  }
}
