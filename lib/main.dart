import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/dependency_injection.dart';
import 'features/chat/presentation/cubit/chat_cubit.dart';
import 'features/chat/presentation/screens/chat_screen.dart';

void main() {
  initGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<ChatCubit>(
        create: (_) => getIt<ChatCubit>(),
        child: const ChatScreen(),
      ),
    );
  }
}
