

import SwiftUI

struct ManageTeamButton: View {

    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill.badge.plus")
                .renderingMode(.original)
            Text("Manage Team")
        }
    }
}

struct ManageTeamButton_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            ManageTeamButton()
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
