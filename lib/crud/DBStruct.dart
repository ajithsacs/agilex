
const ids = 'id';
const emails = "email";
const text = "notes";
const cloud = "sync_cloud";
const db = "notes_db";
const notestabel = "notes";
const usertable = "usertable";

class Notes {
  final int id;
  final String email;
  final String text;
  final bool sync;
  const Notes({
    required this.id,
    required this.email,
    required this.text,
    required this.sync,
  });
  Notes.from(
    Map<String, Object?> map,
  )   : id = map[ids] as int,
        email = map[emails] as String,
        text = map[Notes] as String,
        sync = (map[cloud] as int) == 1 ? true : false;

  @override
  String toString() {
    return 'Notes id:$id,email:$email,notes:$Notes,is_synced:$sync';
  }

  @override
  bool operator ==(covariant Notes other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// class Usertable
// {
// final int id;
// final Text email;

//   Usertable(this.id, this.email);

// }

