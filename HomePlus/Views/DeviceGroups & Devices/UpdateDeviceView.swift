

import SwiftUI
import RealmSwift

struct UpdateDeviceView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var status: DeviceStatus

    let padding: CGFloat = 16.0

    var body: some View {
        NavigationView {
            VStack(spacing: padding) {
                Spacer()
                if status != .On {
                    CallToActionButton(
                        title: "Device on") {
                        updateStatus(.On)
                    }
                }
                if status != .TurningOn {
                    CallToActionButton(
                        title: "Device turning on") {
                        updateStatus(.TurningOn)
                    }
                }
                if status != .Off {
                    CallToActionButton(
                        title: "Device Off") {
                        updateStatus(.Off)
                    }
                }
                if status != .TurningOff {
                    CallToActionButton(
                        title: "Device turning off") {
                        updateStatus(.TurningOff)
                    }
                }
                Spacer()
            }
            .navigationBarTitle(Text("Change Device Status"), displayMode: .inline)
            .navigationBarItems(
                leading: Button(
                    action: { self.presentationMode.wrappedValue.dismiss() }) { Image(systemName: "xmark.circle") })
            .padding(.horizontal, padding)
        }
    }

    func updateStatus(_ newStatus: DeviceStatus) {
        status = newStatus
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct UpdateDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            UpdateDeviceView(status: .constant(.Off))
        )
    }
}
