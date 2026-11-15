import 'package:get_it/get_it.dart';

import '../../features/chat/data/data_sources/gemini_chat_remote_data_source.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/chat/domain/usecases/send_message_use_case.dart';
import '../../features/chat/presentation/cubit/chat_cubit.dart';
import '../constants/gemini_config.dart';
import '../services/api_client.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(
      baseUrl: GeminiChatRemoteDataSource.baseUrl,
      headers: {'x-goog-api-key': GeminiConfig.apiKey},
    ),
  );

  getIt.registerLazySingleton<GeminiChatRemoteDataSource>(
    () => GeminiChatRemoteDataSource(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      getIt<GeminiChatRemoteDataSource>(),
      model: GeminiConfig.model,
    ),
  );
  getIt.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(getIt<ChatRepository>()),
  );
  getIt.registerFactory<ChatCubit>(
    () => ChatCubit(getIt<SendMessageUseCase>()),
  );
}
