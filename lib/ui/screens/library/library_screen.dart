import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week7/data/repositories/songs/user_history_repository.dart';
import 'package:week7/ui/screens/library/view_model/library_view_model.dart';
import 'package:week7/ui/screens/library/widget/library_content.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';
import '../../states/settings_state.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    SongRepository songRepository = context.read<SongRepository>();

    // 2- Read the globbal settings state
    AppSettingsState settingsState = context.read<AppSettingsState>();

    // 3 - Watch the globbal player state
    PlayerState playerState = context.watch<PlayerState>();

    // 4 - Read the global user history repo\
    UserHistoryRepository userHistoryRepository = context
        .read<UserHistoryRepository>();

    return ChangeNotifierProvider(
      create: (_) => LibraryViewModel(
        songRepository: songRepository,
        playerState: playerState,
        appSettingsState: settingsState,
        userHistoryRepository: userHistoryRepository,
      ),
      child: const LibraryContent(),
    );
  }
}
