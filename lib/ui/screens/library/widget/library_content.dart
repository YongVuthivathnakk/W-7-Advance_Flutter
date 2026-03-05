import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week7/model/songs/song.dart';
import 'package:week7/ui/screens/library/view_model/library_view_model.dart';
import 'package:week7/ui/theme/theme.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    LibraryViewModel libraryViewModel = context.watch<LibraryViewModel>();

    // Show loading
    if (libraryViewModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      color: libraryViewModel.appSettingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Your recent songs',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: libraryViewModel.songs.length,
              itemBuilder: (context, index) => SongTile(
                song: libraryViewModel.songs[index],
                isPlaying:
                    libraryViewModel.playerState.currentSong ==
                    libraryViewModel.songs[index],

                onTap: () {
                  libraryViewModel.playSong(libraryViewModel.songs[index]);
                },
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'You might also like',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: libraryViewModel.userHistoryRepository.songs.length,
              itemBuilder: (context, index) => SongTile(
                song: libraryViewModel.userHistoryRepository.songs[index],
                isPlaying:
                    libraryViewModel.playerState.currentSong ==
                    libraryViewModel.userHistoryRepository.songs[index],

                onTap: () {
                  libraryViewModel.playSong(libraryViewModel.songs[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: Text(
        isPlaying ? "Playing" : "",
        style: TextStyle(color: Colors.amber),
      ),
    );
  }
}
