class FirebaseCustomerExceptions implements Exception {
  FirebaseCustomerExceptions(this.description);
  final String description;

  @override
  String toString() {
    return '$this $description';
  }
}

class ItemCreateExceptions implements Exception {
  ItemCreateExceptions(this.description);
  final String description;

  @override
  String toString() {
    return '$this $description';
  }
}
