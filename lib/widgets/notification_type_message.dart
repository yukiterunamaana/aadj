import 'package:mastodon_api/mastodon_api.dart';

String notificationTextBuilder(NotificationType n) {
  switch (n) {
    case NotificationType.follow:
      return 'You have a new follower!';

    case NotificationType.favourite:
      return 'Someone favourited your post!';

    case NotificationType.mention:
      return 'You were mentioned in a post!';

    case NotificationType.reblog:
      return 'Someone reblogged your post!';

    case NotificationType.poll:
      return 'A poll you voted in or created has ended!';

    case NotificationType.status:
      return 'Someone posted a new status!';

    case NotificationType.favourite:
      return 'Someone liked your post!';

    default:
      return 'Unknown notification type';
  }
}
