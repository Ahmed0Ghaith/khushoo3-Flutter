abstract class BaseStates{

}

class InitialState extends BaseStates{}

//DataBaseState
class CreateDataBaseState extends BaseStates{}
class SuccessCreateDataBaseState extends BaseStates{}
class ErrorCreateDataBaseState extends BaseStates
{
   final String error;

  ErrorCreateDataBaseState(this.error);
}

//GetGeoLocatorPermission
class GetGeoLocatorPermission extends BaseStates{}
class DeniedGeoLocatorPermission extends BaseStates{
   final String error;

  DeniedGeoLocatorPermission(this.error);
}
class DeniedForeverGeoLocatorPermission extends BaseStates{
   final String error;

  DeniedForeverGeoLocatorPermission(this.error);
}
class SucessLocatorPermission extends BaseStates{}

//GetTodayData
class LodingTodayDataState extends BaseStates{}
class SuccessTodayLoadingDataState extends BaseStates{}
class ErrorTodayLoadingDataState extends BaseStates
{
   final String error;

  ErrorTodayLoadingDataState(this.error);
}

//RestAPIGetData
class LodingAPIDataState extends BaseStates{}
class SuccessAPILoadingDataState extends BaseStates{}
class ErrorAPILoadingDataState extends BaseStates
{
   final String error;

  ErrorAPILoadingDataState(this.error);
}


//UpdateData
class UpdateDataState extends BaseStates{}
class SuccessUpdateDataState extends BaseStates{}
class ErrorUpdateDataState extends BaseStates
{
   final String error;

  ErrorUpdateDataState(this.error);
}






