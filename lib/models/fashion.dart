class Fashion {
  String imageUrl;
  String categories;
  String size;
  int number;
  int money;
  int count;
  String name;
  bool favorite;
  String description;
  List screenshots = [];
  String id;

  Fashion(
      {this.imageUrl,
      this.categories,
      this.description,
      this.id,
      this.money,
      this.name,
      this.favorite,
      this.number,
      this.screenshots,
      this.count,
      this.size});

  Fashion.fromMap(Map<String, dynamic> data, String id)
      : imageUrl = data['imageUrl'],
        id = id,
        categories = data['categories'],
        description = data['description'],
        money = data['money'],
        name = data['name'],
        number = data['number'],
        screenshots = data['screenshots'],
        favorite=data['favorite'],
        count=data['count'],
        size = data['size'];

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'categories': categories,
      'description': description,
      'money': money,
      'name': name,
      'number': number,
      'screenshots': screenshots,
      'size': size,
      'favorite': favorite,
      'count': count,
    };
  }
}

final List<String> labels = [
  'Áo Khoác',
  'Áo thun',
  'Sơ mi',
  'Balo',
  'Giày nam',
  'Quần shot'
];


final List<Fashion> movies = [
  Fashion(
    imageUrl: 'assets/images/banner.jpg',
    name: 'Spider-Man: Far From Home',
  ),
  Fashion(
    imageUrl: 'assets/images/banner2.jpg',
    name: 'The Nutcracker And The Four Realms',
  ),
  Fashion(
    imageUrl: 'assets/images/banner1.jpg',
    name: 'Toy Story 4',
  ),
];
