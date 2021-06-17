
import SwiftUI

struct LastUpdate: View {
    let date: Date

    var body: some View {
        HStack {
            Text("Last updated ")
            Text(date, style: .relative)
            Text("ago")
            Spacer()
        }
        .font(.caption)
        .lineLimit(5)
        .multilineTextAlignment(.leading)
        .foregroundColor(.secondary)
    }
}

struct LastUpdate_Previews: PreviewProvider {
    static var previews: some View {
        LastUpdate(date: Date())
    }
}
