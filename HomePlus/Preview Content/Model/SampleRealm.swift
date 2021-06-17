

import RealmSwift

extension Realm: Samplable {
    static var sample: Realm {
        let realm = try! Realm()
        let user1: User = .sample
        let user2: User = .sample
        user2.name = "John Barnes"

        let device1: Device = .sample
        let device2: Device = .sample
        let device3: Device = .sample
        device2.name = "Think of better task name"
        device2.status = "Off"
        device3.name = "Think of a number"
        device3.status = "On"

        try! realm.write {
            realm.deleteAll()
            realm.add(user1)
            realm.add(user2)
            realm.add(device1)
            realm.add(device2)
            realm.add(device3)
        }

        return realm
    }
    static func bootstrap() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
                realm.add(User.sample)
                realm.add(Device.sample)
            }
        } catch {
            print("Failed to bootstrap the default realm")
        }
    }
}
