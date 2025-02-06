class LatLong2 {
  final double latitude;
  final double longitude;

  LatLong2(this.latitude, this.longitude);
}

class Delivery {
  String sendingCompanyName;
  String receivingCompanyName;
  LatLong2 senderGeocode;
  LatLong2 receiverGeocode;
  String productName;
  String productImage;
  ProductDetails productDetails;
  DeliveryStatus status;

  Delivery({
    required this.sendingCompanyName,
    required this.receivingCompanyName,
    required this.senderGeocode,
    required this.receiverGeocode,
    required this.productName,
    required this.productImage,
    required this.productDetails,
    required this.status,
  });
}

class ProductDetails {
  num weight;
  num height;
  num width;
  num length;

  ProductDetails({
    required this.weight,
    required this.height,
    required this.width,
    required this.length,
  });
}

enum DeliveryStatus {
  pending,
  assigned,
  onCourse,
  failed,
  completed,
}

List<Delivery> getNextToUserDeliveries() {
  return [
    Delivery(
      sendingCompanyName: "SENAI Araxá",
      receivingCompanyName: "Supermercado ABC",
      senderGeocode: LatLong2(-19.590003, -46.931219),
      receiverGeocode: LatLong2(-19.605740, -46.940700),
      productName: "Caixa de chocolates",
      productImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOa0jV5EN-7JtN1sGZpy7vlvJ5YwcXqhq90w&s",
      productDetails: ProductDetails(
        weight: 0,
        height: 3,
        width: 8.2,
        length: 8.2,
      ),
      status: DeliveryStatus.pending,
    ),
    Delivery(
      sendingCompanyName: "Bueno Strike",
      receivingCompanyName: "Recanto do Idoso",
      senderGeocode: LatLong2(-19.599745, -46.948295),
      receiverGeocode: LatLong2(-19.600148, -46.934587),
      productName: "Livro de Receitas União Doces Segredos e Carinhos",
      productImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBNQDqeTwkXofrC4XGRpzVYdikhlLnE054Fw&s",
      productDetails: ProductDetails(
        weight: 0,
        height: 29.7,
        width: 21,
        length: 8,
      ),
      status: DeliveryStatus.pending,
    ),
  ];
}