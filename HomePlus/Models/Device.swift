

import Foundation
import RealmSwift

enum DeviceStatus: String {
    case On
    case TurningOn
    case Off
    case TurningOff
}

@objcMembers class Device: Object, ObjectKeyIdentifiable {
    dynamic var _id: ObjectId = ObjectId.generate()
    dynamic var _partition: String = ""
    dynamic var name: String = ""
    dynamic var owner: String?
    dynamic var status: String = ""
    override static func primaryKey() -> String? {
        return "_id"
    }

    var statusEnum: DeviceStatus {
        get {
            return DeviceStatus(rawValue: status) ?? .Off
        }
        set {
            status = newValue.rawValue
        }
    }

    convenience init(partition: String, name: String) {
        self.init()
        self._partition = partition
        self.name = name
        self.statusEnum = .Off
    }
}

extension Device: Identifiable {
    var id: String {
        _id.stringValue
    }
}

struct Member: Identifiable {
    let id: String
    let name: String

    init(document: Document) {
        self.id = document["_id"]!!.stringValue!
        self.name = document["name"]!!.stringValue!
    }
}
