

import SwiftUI
import RealmSwift

struct AddDeviceView: View {
    @ObservedResults(Device.self) var devices

    @Environment(\.presentationMode) var presentationMode

    let partition: String
    @State var deviceName = ""

    private enum Dimensions {
        static let padding: CGFloat = 16.0
    }

    var body: some View {
        NavigationView {
            VStack(spacing: Dimensions.padding) {
                Spacer()
                InputField(title: "New device name",
                           text: self.$deviceName)
                CallToActionButton(
                    title: "Add Device",
                    action: {
                        let device = Device(partition: partition, name: deviceName)
                        $devices.append(device)
                        self.presentationMode.wrappedValue.dismiss()
                    })
                Spacer()
            }
        }
        .navigationBarTitle(Text("Add Device"), displayMode: .inline)
        .navigationBarItems(
            leading: Button(
                action: { self.presentationMode.wrappedValue.dismiss() }) { Image(systemName: "xmark.circle") })
        .padding(.horizontal, Dimensions.padding)
    }
}

struct AddDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()

        return AddDeviceView(partition: "Doesn't matter")
    }
}
