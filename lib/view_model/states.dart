abstract class BaseStates {
  const BaseStates();

  BaseStates copyWith({String? error}) => this;
}

class InitialState extends BaseStates {
  const InitialState();

  @override
  InitialState copyWith({String? error}) => const InitialState();
}

//DataBaseState
class CreateDataBaseState extends BaseStates {
  const CreateDataBaseState();

  @override
  CreateDataBaseState copyWith({String? error}) => const CreateDataBaseState();
}

class SuccessCreateDataBaseState extends BaseStates {
  const SuccessCreateDataBaseState();

  @override
  SuccessCreateDataBaseState copyWith({String? error}) =>
      const SuccessCreateDataBaseState();
}

class ErrorCreateDataBaseState extends BaseStates {
  final String error;

  const ErrorCreateDataBaseState(this.error);

  @override
  ErrorCreateDataBaseState copyWith({String? error}) =>
      ErrorCreateDataBaseState(error ?? this.error);
}

//GetGeoLocatorPermission
class GetGeoLocatorPermission extends BaseStates {
  const GetGeoLocatorPermission();

  @override
  GetGeoLocatorPermission copyWith({String? error}) =>
      const GetGeoLocatorPermission();
}

class DeniedGeoLocatorPermission extends BaseStates {
  final String error;

  const DeniedGeoLocatorPermission(this.error);

  @override
  DeniedGeoLocatorPermission copyWith({String? error}) =>
      DeniedGeoLocatorPermission(error ?? this.error);
}

class DeniedForeverGeoLocatorPermission extends BaseStates {
  final String error;

  const DeniedForeverGeoLocatorPermission(this.error);

  @override
  DeniedForeverGeoLocatorPermission copyWith({String? error}) =>
      DeniedForeverGeoLocatorPermission(error ?? this.error);
}

class SucessLocatorPermission extends BaseStates {
  const SucessLocatorPermission();

  @override
  SucessLocatorPermission copyWith({String? error}) =>
      const SucessLocatorPermission();
}

//GetTodayData
class LodingTodayDataState extends BaseStates {
  const LodingTodayDataState();

  @override
  LodingTodayDataState copyWith({String? error}) => const LodingTodayDataState();
}

class SuccessTodayLoadingDataState extends BaseStates {
  const SuccessTodayLoadingDataState();

  @override
  SuccessTodayLoadingDataState copyWith({String? error}) =>
      const SuccessTodayLoadingDataState();
}

class ErrorTodayLoadingDataState extends BaseStates {
  final String error;

  const ErrorTodayLoadingDataState(this.error);

  @override
  ErrorTodayLoadingDataState copyWith({String? error}) =>
      ErrorTodayLoadingDataState(error ?? this.error);
}

//RestAPIGetData
class LodingAPIDataState extends BaseStates {
  const LodingAPIDataState();

  @override
  LodingAPIDataState copyWith({String? error}) => const LodingAPIDataState();
}

class SuccessAPILoadingDataState extends BaseStates {
  const SuccessAPILoadingDataState();

  @override
  SuccessAPILoadingDataState copyWith({String? error}) =>
      const SuccessAPILoadingDataState();
}

class ErrorAPILoadingDataState extends BaseStates {
  final String error;

  const ErrorAPILoadingDataState(this.error);

  @override
  ErrorAPILoadingDataState copyWith({String? error}) =>
      ErrorAPILoadingDataState(error ?? this.error);
}

//UpdateData
class UpdateDataState extends BaseStates {
  const UpdateDataState();

  @override
  UpdateDataState copyWith({String? error}) => const UpdateDataState();
}

class SuccessUpdateDataState extends BaseStates {
  const SuccessUpdateDataState();

  @override
  SuccessUpdateDataState copyWith({String? error}) =>
      const SuccessUpdateDataState();
}

class ErrorUpdateDataState extends BaseStates {
  final String error;

  const ErrorUpdateDataState(this.error);

  @override
  ErrorUpdateDataState copyWith({String? error}) =>
      ErrorUpdateDataState(error ?? this.error);
}

//Loding azkar data
class LodingAzkarDataState extends BaseStates {
  const LodingAzkarDataState();

  @override
  LodingAzkarDataState copyWith({String? error}) =>
      const LodingAzkarDataState();
}

class SuccessAzkarLoadingDataState extends BaseStates {
  const SuccessAzkarLoadingDataState();

  @override
  SuccessAzkarLoadingDataState copyWith({String? error}) =>
      const SuccessAzkarLoadingDataState();
}

class ErrorAzkarLoadingDataState extends BaseStates {
  final String error;

  const ErrorAzkarLoadingDataState(this.error);

  @override
  ErrorAzkarLoadingDataState copyWith({String? error}) =>
      ErrorAzkarLoadingDataState(error ?? this.error);
}

//Scrolling azkar
class ScrollAzkar extends BaseStates {
  const ScrollAzkar();

  @override
  ScrollAzkar copyWith({String? error}) => const ScrollAzkar();
}

class OnAppearAzkar extends BaseStates {
  const OnAppearAzkar();

  @override
  OnAppearAzkar copyWith({String? error}) => const OnAppearAzkar();
}

//Change State OF Search
class StateChanged extends BaseStates {
  const StateChanged();

  @override
  StateChanged copyWith({String? error}) => const StateChanged();
}

//misbahaClicked
class misbahaClicked extends BaseStates {
  const misbahaClicked();

  @override
  misbahaClicked copyWith({String? error}) => const misbahaClicked();
}

// Language State
class ChangeLanguageState extends BaseStates {
  const ChangeLanguageState();

  @override
  ChangeLanguageState copyWith({String? error}) => const ChangeLanguageState();
}


