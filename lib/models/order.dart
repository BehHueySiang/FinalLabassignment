class Order {
  String? orderId;
String? userId;
  String? barterId;
  String? shipmethod;
  String? orderDate;


  Order(
      {this.orderId,
      this.userId,
      this.barterId,
      this.shipmethod,
      this.orderDate,
});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userId = json['userid'];
    barterId = json['barter_id'];
    shipmethod=json['shipmethod'];
    orderDate = json['order_date'];
    
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['barter_id'] = barterId;
    data['barter_id'] = barterId;
    data['order_date'] = orderDate;
  
    return data;
  }
}