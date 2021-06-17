

import SwiftUI
import RealmSwift

struct DeviceView: View {
    @ObservedRealmObject var device: Device
    @State var showingUpdateSheet = false

    private enum Dimensions {
        static let padding: CGFloat = 16.0
    }

    var body: some View {
        Button(action: { self.showingUpdateSheet = true }) {
            HStack(spacing: Dimensions.padding) {
                switch device.statusEnum {
                case .On:
                    Text(device.name)
                        .strikethrough()
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "checkmark.square")
                        .foregroundColor(.gray)
                case .TurningOn:
                    Text(device.name)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "tornado")
                case .Off:
                    Text(device.name)
                    Spacer()
                case .TurningOff:
                    Text(device.name)
                    Image(systemName: "tornado")
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showingUpdateSheet) {
            UpdateDeviceView(status: $device.statusEnum)
        }
        .padding(.horizontal, Dimensions.padding)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        let sample1: Device = .sample
        let sample2: Device = .sample
        sample1.statusEnum = .TurningOn
        sample2.statusEnum = .Off

        return AppearancePreviews(
            VStack {
                DeviceView(device: .sample)
                DeviceView(device: sample1)
                DeviceView(device: sample2)
            }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
