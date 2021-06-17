//
//  SampleData.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 12/11/2020.
//

import Foundation

protocol Samplable {
    associatedtype Item
    static var sample: Item { get }
}

extension User: Samplable {
    static var sample: User {
        let user = User()
        user._partition = "dummy-partition"
        user.name = "Fred Flinstone"
        user.memberOf.append(.sample)
        let deviceGroup2: DeviceGroup = .sample
        deviceGroup2.name = "Another group"
        user.memberOf.append(deviceGroup2)
        return user
    }
}

extension DeviceGroup: Samplable {
    static var sample: DeviceGroup {
        let deviceGroup = DeviceGroup()
        deviceGroup.name = "My group"
        deviceGroup.partition = "devicegroup=489375897238957"
        return deviceGroup
    }
}

extension Device: Samplable {
    static var sample: Device {
        let device = Device()
        device.name = "My Device"
        device._partition = "device=489375897238957"
        device.owner = "Fred Flinstone"
        device.status = "On"
        return device
    }

    convenience init (_ device: Device) {
        self.init()
        name = device.name
        _partition = device._partition
        owner = device.owner
        status = device.status
    }
}
