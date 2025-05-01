part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class GetAllNotificationInitial extends NotificationState {}
class GetAllNotificationSuccess extends NotificationState {}
class GetAllNotificationError extends NotificationState {}

class GetOneNotificationInitial extends NotificationState {}
class GetOneNotificationSuccess extends NotificationState {
  final NotificationModel notification;

  GetOneNotificationSuccess(this.notification);
}
class GetOneNotificationError extends NotificationState {}

class MarkAllReadInitial extends NotificationState {}
class MarkAllReadSuccess extends NotificationState {}
class MarkAllReadError extends NotificationState {}

class MarkAsReadInitial extends NotificationState {}
class MarkAsReadSuccess extends NotificationState {}
class MarkAsReadError extends NotificationState {}

class UpdateFCMInitial extends NotificationState {}
class UpdateFCMSuccess extends NotificationState {}
class UpdateFCMError extends NotificationState {}
