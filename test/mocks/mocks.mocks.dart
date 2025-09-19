import 'package:idez_test/src/modules/shared/domain/gateways/notification_gateway.dart';
import 'package:idez_test/src/modules/shared/domain/services/reminder_policy.dart';
import 'package:mockito/annotations.dart';

import 'package:idez_test/src/modules/shared/domain/repository/shared_repository.dart';
import 'package:idez_test/src/modules/shared/data/data_source/task_local_data_source.dart';

@GenerateMocks([SharedRepository, TasksLocalDataSource, NotificationGateway, ReminderPolicy])
void main() {}
