

import SwiftUI
import RealmSwift

struct GroupsView: View {
    @EnvironmentObject var state: AppState

    @State var groupName = ""
    @State var showingDevices = false
    @State var showingSheet = false
    @State var groupToOpen: DeviceGroup?
    var isPreview = false

    private enum Dimensions {
        static let padding: CGFloat = 16.0
    }

    var body: some View {
        VStack(spacing: Dimensions.padding) {
            if let deviceGroups = state.user?.memberOf {
                ForEach(deviceGroups, id: \.self) { deviceGroup in
                    HStack {
                        LabeledButton(label: deviceGroup.partition ?? "No partition",
                                      text: deviceGroup.name ?? "No group name") {
                            groupToOpen = deviceGroup
                            showingDevices = true
                        }
                    }
                }
            }
            Spacer()
            if isPreview {
                NavigationLink( destination: DevicesView(deviceGroup: groupToOpen),
                                isActive: $showingDevices) {
                    EmptyView() }
            } else {
                NavigationLink( destination: DevicesView(deviceGroup: groupToOpen)
                                    .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: groupToOpen?.partition ?? "")),
                                isActive: $showingDevices) {
                    EmptyView() }
            }
        }
        .navigationBarTitle("Groups", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(action: { self.showingSheet = true }) {
                    ManageTeamButton()
                }
            }
        }
        .sheet(isPresented: $showingSheet) { TeamsView() }
        .padding(.all, Dimensions.padding)
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        let state = AppState()
        state.user = .sample

        return AppearancePreviews(
            NavigationView {
                GroupsView(isPreview: true)
                    .environmentObject(state)
            }
        )
    }
}
