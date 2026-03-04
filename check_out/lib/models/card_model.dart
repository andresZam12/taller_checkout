class CardModel {
  final int? id;
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cvv;

  CardModel({
    this.id,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cvv,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'cardHolder': cardHolder,
      'expiryDate': expiryDate,
      'cvv': cvv,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'],
      cardNumber: map['cardNumber'],
      cardHolder: map['cardHolder'],
      expiryDate: map['expiryDate'],
      cvv: map['cvv'],
    );
  }
}