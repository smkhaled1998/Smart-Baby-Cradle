
abstract class HomeStates{}

class HomeInitialState extends HomeStates{}

class GettingDataLoadingState extends HomeStates{}

class GettingDataSuccessState extends HomeStates{}
class GettingDataErrorState extends HomeStates{}

class ListeningDataSuccessState extends HomeStates{}
class ListeningDataErrorState extends HomeStates{}

class LedPressed extends HomeStates{}
class LedChanged extends HomeStates{}

class CradlePressed extends HomeStates{}
class CradleChanged extends HomeStates{}

class FanPressed extends HomeStates{}
class FanChanged extends HomeStates{}

class ToysPressed extends HomeStates{}
class ToysChanged extends HomeStates{}
