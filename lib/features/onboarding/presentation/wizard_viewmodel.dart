import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:residence_lamandier_b/features/onboarding/presentation/wizard_state.dart';
import 'package:residence_lamandier_b/features/onboarding/presentation/wizard_intent.dart';

part 'wizard_viewmodel.g.dart';

@riverpod
class WizardViewModel extends _$WizardViewModel {
  @override
  WizardState build() {
    return const WizardState();
  }

  void processIntent(WizardIntent intent) {
    intent.when(
      nextStep: () {
        if (state.currentStep < 2) {
          state = state.copyWith(currentStep: state.currentStep + 1);
        }
      },
      previousStep: () {
        if (state.currentStep > 0) {
          state = state.copyWith(currentStep: state.currentStep - 1);
        }
      },
      updateSyndicName: (name) {
        state = state.copyWith(syndicName: name);
      },
      updateAdjointName: (name) {
        state = state.copyWith(adjointName: name);
      },
      updateConciergeName: (name) {
        state = state.copyWith(conciergeName: name);
      },
      submit: () async {
        state = state.copyWith(isLoading: true, error: null);
        try {
          // Placeholder for submission logic
          // await ref.read(syncManagerProvider).enqueueMutation(...)
          await Future.delayed(const Duration(seconds: 1));
          state = state.copyWith(isLoading: false);
          // Navigate to next screen or show success
        } catch (e) {
          state = state.copyWith(isLoading: false, error: e.toString());
        }
      },
    );
  }
}
