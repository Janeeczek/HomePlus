//
//  TasksView.swift
//  task-tracker-swiftui
//
//  Created by Andrew Morgan on 03/11/2020.
//

import SwiftUI
import RealmSwift

struct DevicesView: View {
    @ObservedResults(Device.self, sortDescriptor: SortDescriptor(keyPath: "_id", ascending: true)) var devices
    @EnvironmentObject var state: AppState

    let deviceGroup: DeviceGroup?
    @State var showingSheet = false

    var body: some View {
        List {
            ForEach(devices) { device in
                DeviceView(device: device)
            }
            .onDelete(perform: $devices.remove)
        }
        .navigationBarTitle("Devices in \(deviceGroup?.name ?? "")", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: { self.showingSheet = true }) {
            Image(systemName: "plus.circle.fill")
                .renderingMode(.original)

        })
        .sheet(isPresented: $showingSheet) { AddDeviceView(partition: deviceGroup?.partition ?? "") }
    }
}

struct DevicesView_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()

        return AppearancePreviews(
            Group {
                NavigationView {
                    DevicesView(deviceGroup: .sample)
                }
                Landscape(
                    NavigationView {
                        DevicesView(deviceGroup: .sample)
                    }
                )
            }
        )
        .environmentObject(AppState())
    }
}
