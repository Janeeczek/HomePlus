

import Foundation
import RealmSwift

@objcMembers class User: Object, ObjectKeyIdentifiable {
    dynamic var _id: String = UUID().uuidString
    dynamic var _partition: String = ""
    dynamic var name: String = ""
    let memberOf = RealmSwift.List<DeviceGroup>()

    override static func primaryKey() -> String? {
        return "_id"
    }
}
