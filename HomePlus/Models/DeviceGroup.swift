

import Foundation
import RealmSwift

@objcMembers class DeviceGroup: EmbeddedObject, ObjectKeyIdentifiable {
    dynamic var name: String?
    dynamic var partition: String?

    convenience init(partition: String, name: String) {
        self.init()
        self.partition = partition
        self.name = name
    }
}
