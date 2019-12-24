class Todo {
  final String id;
  final String title;
  final String description;

  Todo({this.id, this.title, this.description});
}

// class ListItems {
//   List<Todos> todos;

//   ListItems({this.todos});

//   ListItems.fromJson(Map<String, dynamic> json) {
//     if (json['todos'] != null) {
//       todos = new List<Todos>();
//       json['todos'].forEach((v) {
//         todos.add(new Todos.fromJson(v));
//       });
//     }
//   }
// }

// class Todos {
//   String title;
//   String description;

//   Todos({this.title, this.description});
// }

//  List<Todos> _todos = List<Todos>();

//   Future<List<Todos>> fetchItems() async {
//     var url = 'http://localhost:81/API/retrieveitems.php';
//     var response = await http.get(url);
//     var items = List<Todos>();
//     if (response.statusCode == 200) {
//       var itemsJson = json.decode(response.body);
//       for (var itemsJson in itemsJson) {
//         items.add(Todos.fromJson(itemsJson));
//       }
//     }
//     return items;
//   }
