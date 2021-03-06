import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/models/room.dart';

abstract class BaseMutation extends WillsMutation<Store<AppState>> {}

class AddUsersMutation extends BaseMutation {

  List<User> users;

  AddUsersMutation(this.users);

  @override
  exec() {
    users.forEach((user) {
      $store.state.users[user.uid] = user;
    });
  }

}

class AddTopicsMutation extends BaseMutation {

  List<Topic> topics;

  AddTopicsMutation(this.topics);

  @override
  exec() {
    topics.forEach((topic) {
      $store.state.topics[topic.tid] = topic;
    });
  }

}

class SetActiveUserMutation extends BaseMutation {

  User user;

  SetActiveUserMutation(this.user);

  @override
  exec() {
    $store.state.activeUser = user;
    $store.commit(new SetUnreadInfoMutation(new UnreadInfo()));
    $store.commit(new ClearRoomsMutation());
  }

}

class AddRoomsMutation extends BaseMutation {

  List<Room> rooms;

  AddRoomsMutation(this.rooms);

  @override
  exec() {
    rooms.forEach((room) {
      $store.state.rooms[room.roomId] = room;
    });
  }

}

class SetUnreadInfoMutation extends BaseMutation {

  UnreadInfo info;

  SetUnreadInfoMutation(this.info);

  @override
  exec() {
    $store.state.unreadInfo = info;
  }

}

class AddMessagesToRoomMutation extends BaseMutation {

  List<Message> messages;

  int roomId;

  AddMessagesToRoomMutation(this.roomId, this.messages);

  @override
  exec() {
    $store.state.rooms[roomId].messages.addAll(messages);
  }


}

class ClearMessagesFromRoomMutation extends BaseMutation {

  int roomId;

  ClearMessagesFromRoomMutation(this.roomId);

  @override
  exec() {
    $store.state.rooms[roomId]?.messages?.clear();
  }

}

class ClearRoomsMutation extends BaseMutation {

  ClearRoomsMutation();

  @override
  exec() {
    $store.state.rooms.clear();
  }

}

class UpdateUnreadChatCountMutation extends BaseMutation {

  int unreadChatCount = 0;

  UpdateUnreadChatCountMutation(this.unreadChatCount);

  @override
  exec() {
    $store.state.unreadInfo.unreadChatCount = unreadChatCount;
  }

}

class UpdateRoomUnreadStatusMutation extends BaseMutation {

  bool unread;

  int roomId;

  UpdateRoomUnreadStatusMutation(this.roomId, this.unread);

  @override
  exec() {
    $store.state.rooms[this.roomId].unread = unread;
  }

}

class UpdateRoomTeaserContentMutation extends BaseMutation {

  int roomId;

  String content;

  UpdateRoomTeaserContentMutation(this.roomId, this.content);

  @override
  exec() {
    Room room = $store.state.rooms[this.roomId];
    if(room != null) {
      room.teaser?.content = content;
    }
  }

}



class ClearTopicsMutation extends BaseMutation {

  @override
  exec() {
    $store.state.topics.clear();
  }

}

class DeleteRoomMutation extends BaseMutation {
  int roomId;

  DeleteRoomMutation(this.roomId);

  @override
  exec() {
    if($store.state.rooms.containsKey(this.roomId)) {
      $store.state.rooms.remove(this.roomId);
    }
  }

}

class UpdateNotificationMutation extends BaseMutation {

  bool newReply;

  bool newChat;

  bool newFollow;

  bool groupInvite;

  bool newTopic;

  UpdateNotificationMutation({this.newReply, this.newChat, this.newFollow, this.groupInvite, this.newTopic});

  @override
  exec() {
    if(newReply != null) {
      $store.state.notification.newReply = newReply;
    }
    if(newChat != null) {
      $store.state.notification.newChat = newChat;
    }
    if(newFollow != null) {
      $store.state.notification.newFollow = newFollow;
    }
    if(groupInvite != null) {
      $store.state.notification.groupInvite = groupInvite;
    }
    if(newTopic != null) {
      $store.state.notification.newTopic = newTopic;
    }
  }

}

class AddRecentViewTopic extends BaseMutation {

  int tid;

  AddRecentViewTopic(this.tid);

  @override
  exec() {
    if($store.state.recentViews.length >= 8) {
      if($store.state.recentViews.contains(this.tid)) {
        $store.state.recentViews.remove(this.tid);
      } else {
        $store.state.recentViews.removeAt(0);
      }
      $store.state.recentViews.add(this.tid);
    } else {
      $store.state.recentViews.add(this.tid);
    }
  }

}

//class AddNewPostToTopicMutation extends BaseMutation {
//  Post post;
//
//  AddNewPostToTopicMutation({this.post});
//
//  @override
//  exec() {
//    $store.state.topics[this.post.tid].
//  }
//}