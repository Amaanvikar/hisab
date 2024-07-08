import 'package:objectbox/objectbox.dart';

@Entity()
class Site {
  int id = 0;

  String name;
  String location;
  String description;

  Site({
    required this.name,
    required this.location,
    required this.description,
  });
}
