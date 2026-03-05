import 'package:flutter/material.dart';
import 'package:week7/data/repositories/songs/song_repository.dart';
import 'package:week7/data/repositories/songs/user_history_repository.dart';
import 'package:week7/model/songs/song.dart';
import 'package:week7/ui/states/player_state.dart';
import 'package:week7/ui/states/settings_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  final AppSettingsState appSettingsState;
  final UserHistoryRepository userHistoryRepository;

  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
    required this.appSettingsState,
    required this.userHistoryRepository,
  }) {
    playerState.addListener(_onPlayerChange);
    init();
  }

  List<Song> _songs = [];
  bool _isLoading = false;

  List<Song> get songs => _songs;
  bool get isLoading => _isLoading;

  Song? get currentSong => playerState.currentSong;

  Future<void> init() async {
    await loadSongs();
  }

  void _onPlayerChange() {
    notifyListeners();
  }

  Future<void> loadSongs() async {
    _isLoading = true;
    notifyListeners();

    _songs = songRepository.fetchSongs();
    _isLoading = false;
    notifyListeners();
  }

  void playSong(Song song) {
    if (playerState.currentSong == song) {
      playerState.stop();
      return;
    }
    playerState.start(song);
    userHistoryRepository.addRecentSong(song);
  }

  @override
  void dispose() {
    playerState.removeListener(_onPlayerChange);
    super.dispose();
  }
}
