import 'package:flutter/material.dart';

@immutable
sealed class AuthStates {}

final class AuthInitialState extends AuthStates {}

final class LoginLoadingState extends AuthStates {}

final class LoginSuccessState extends AuthStates {}

final class LoginErrorState extends AuthStates {}

final class RegisterLoadingState extends AuthStates {}

final class RegisterSuccessState extends AuthStates {}

final class RegisterErrorState extends AuthStates {}

final class LogoutLoadingState extends AuthStates {}

final class LogoutSuccessState extends AuthStates {}

final class LogoutErrorState extends AuthStates {}