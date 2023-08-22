import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/characters_controller.dart';

class CharacterError extends ConsumerWidget {
  final String message;

  const CharacterError({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: const TextStyle(fontSize: 20.0)),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => ref
                .read(charactersControllerProvider.notifier)
                .retrieveCharacters(isRefreshing: true),
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}