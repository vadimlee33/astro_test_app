import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/color_schemes.dart';
import '../../../../core/routing/app_route.dart';
import '../bloc/main_bloc.dart';
import '../bloc/main_event.dart';
import '../bloc/main_state.dart';
import '../widgets/main_content.dart';
import '../widgets/error_widget.dart';
import '../services/notification_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    context.read<MainBloc>().add(const LoadMainData());
  }

  void _onPurchasePressed() {
    PurchaseRoute.go(context);
  }

  void _onNotificationPressed() {
    NotificationService.handleNotificationRequest(context);
  }

  void _onRetryPressed() {
    context.read<MainBloc>().add(const LoadMainData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorSchemes.lightColorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Главная',
          style: AppTextStyles.titleLarge,
        ),
        backgroundColor: AppColorSchemes.lightColorScheme.primary,
        foregroundColor: AppColorSchemes.lightColorScheme.onPrimary,
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is MainLoaded) {
            return MainContent(
              user: state.user,
              onPurchasePressed: _onPurchasePressed,
              onNotificationPressed: _onNotificationPressed,
            );
          }

          if (state is MainError) {
            return MainErrorWidget(
              message: state.message,
              onRetry: _onRetryPressed,
            );
          }

          return const Center(
            child: Text('Загрузка...'),
          );
        },
      ),
    );
  }
}
