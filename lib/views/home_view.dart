
// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }


// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   List<PostModel> postdata = [];

//   Future<List<PostModel>> getPostApi() async {
//     var url = Uri.parse("https://jsonplaceholder.typicode.com/posts/");
//     var response = await http.get(url);
//     var responsebody = jsonDecode(response.body);
//     for (var eachMap in responsebody) {
//       postdata.add(PostModel.fromJson(eachMap));
//     }
//     return postdata;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: getPostApi(),
//         builder: (context, Snapshot) {
//           if (Snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else {
//             return ListView.builder(
//               itemCount: Snapshot.data?.length ?? 0,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(Snapshot.data?[index].id.toString() ?? "No ID"),
//                   subtitle: Text(
//                       Snapshot.data?[index].title.toString() ?? "No Title"),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tmdb_movie_app/models/movie_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<MovieModel> getPostApi() async {
    var url = Uri.parse("https://api.themoviedb.org/3/movie/popular?language=en-US&page=1");
    var response = await http.get(url, headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MjdhZGQ2ODlkYzUxZjkzMTA0ZWJkMmFhNThiMzlkMCIsIm5iZiI6MTcyODgxOTE3MC4xNTUxMDgsInN1YiI6IjY3MGI5OWI4NDExMWJlNGYwMjc0OTUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nxZD9Rl6q30X_sFO6lHR92stual1K4DosPFD5GNrylU',
      'accept': 'application/json'
    });
    var responsebody = jsonDecode(response.body);
    return MovieModel.fromJson(responsebody);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPostApi(),
        builder: (context, AsyncSnapshot<MovieModel> Snapshot) {
          if (Snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: ListView.builder(
                  itemCount: Snapshot.data?.results?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          Snapshot.data?.results?[index].originalTitle ??
                              "No Title"),
                      subtitle: Text(
                          Snapshot.data?.results?[index].overview ?? "No ID"),
                    );
                  }),
            );
          }
        },
      ),
    );
  }
}
