import 'package:flutter/material.dart';

@immutable
sealed class UserStates {}

final class UserInitialState extends UserStates {}

final class LoadingGetUserDataState extends UserStates {}

final class SuccessGetUserDataState extends UserStates {}

final class ErrorGetUserDataState extends UserStates {}

final class LoadingGetCurrencyState extends UserStates {}

final class SuccessGetCurrencyState extends UserStates {}

final class ErrorGetCurrencyState extends UserStates {}

final class LoadingChangePasswordState extends UserStates {}

final class SuccessChangePasswordState extends UserStates {}

final class ErrorChangePasswordState extends UserStates {}

final class LoadingUpdateProfileState extends UserStates {}

final class SuccessUpdateProfileState extends UserStates {}

final class ErrorUpdateProfileState extends UserStates {}

final class ChangeCurrencyState extends UserStates {}

final class LoadingUpdateAddressState extends UserStates {}

final class SuccessUpdateAddressState extends UserStates {}

final class ErrorUpdateAddressState extends UserStates {}

final class ChangeSelectedImageState extends UserStates {}

final class LoadingInfluencerRegisterState extends UserStates {}

final class SuccessInfluencerRegisterState extends UserStates {}

final class ErrorInfluencerRegisterState extends UserStates {}

final class LoadingInfluencerDetailsState extends UserStates {}

final class SuccessInfluencerDetailsState extends UserStates {}

final class ErrorInfluencerDetailsState extends UserStates {}