import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/supabase_constants.dart';
import '../network/network_info.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_usecase.dart';

// Core providers
final networkInfoProvider = Provider<NetworkInfo>((ref) => NetworkInfoImpl());

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// Data source providers
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    supabaseClient: ref.read(supabaseClientProvider),
  );
});

// Repository providers
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});

// Use case providers
final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return SignInUseCase(ref.read(authRepositoryProvider));
});

// Initialize Supabase
final supabaseInitProvider = FutureProvider<void>((ref) async {
  await Supabase.initialize(
    url: SupabaseConstants.supabaseUrl,
    anonKey: SupabaseConstants.supabaseAnonKey,
  );
});
