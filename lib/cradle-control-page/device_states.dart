abstract class DeviceStates{}
class DeviceInitialState extends DeviceStates{}

class ChangeBottomBarState extends DeviceStates{}
///**********************
class ActiveSpotSuccessState extends DeviceStates{}
class ActiveSpotPressedState extends DeviceStates{}

class ActiveFanSuccessState extends DeviceStates{}
class ActiveCradleSuccessState extends DeviceStates{}
class ActiveToysSuccessState extends DeviceStates{}
///***********************


class ListeningChangesDataLoadingState extends DeviceStates{}
class ListeningChangesDataSuccessState extends DeviceStates{}
class ListeningChangesDataErrorState extends DeviceStates{}



///************************

class JsonGettingState extends DeviceStates{}
class JsonGotSuccessState extends DeviceStates{}
class JsonGotErrorState extends DeviceStates{}

class GettingChangesDataSuccessState extends DeviceStates{}
///********************sound**************************
class GetSoundStatusSuccessState extends DeviceStates{}

