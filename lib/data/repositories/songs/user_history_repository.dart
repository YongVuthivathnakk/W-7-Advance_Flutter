import 'package:week7/model/songs/song.dart';

class UserHistoryRepository {
  List<Song> songs = [];

  void addRecentSong(Song song) {
    if (!songs.contains(song)) {
      songs.add(song);
    }
  }

  Future<List<Song>> getRecentSong() async {
    return songs;
  }
}
