

import SwiftUI
import RealmSwift

struct LoginView: View {

    @EnvironmentObject var state: AppState
    @State private var username = ""
    @State private var password = ""
    @State private var additional = ""
    @State private var newUser = false

    private enum Dimensions {
        static let padding: CGFloat = 14.0
        static let spacing: CGFloat = 44.0
    }

    var body: some View {
        VStack(spacing: Dimensions.spacing) {
            
            Spacer()
            if newUser {
                Text("You will be automatically logged in")
                    .font(.callout)
                    .bold()
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
            VStack(alignment: .leading) {
                Text("Email/Username:")
                    .font(.callout)
                    .bold()
                TextField("Enter username...", text: self.$username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
            if newUser {
                VStack(alignment: .leading) {
                    Text("Additional:")
                        .font(.callout)
                        .bold()
                    TextField("Enter additional...", text: self.$additional)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
            }
            VStack(alignment: .leading) {
                Text("Password:")
                    .font(.callout)
                    .bold()
                SecureField("Enter password...", text: self.$password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
            }
            
            CallToActionButton(
                title: newUser ? "Register User" : "Log In",
                action: { self.userAction(username: self.username, password: self.password) })
            
            HStack {
                CheckBox(title: "Register new user", isChecked: $newUser)
                
            }
            
            
            Spacer()
        }
        .navigationBarTitle("Home Plus", displayMode: .large)
        .padding(.horizontal, Dimensions.padding)
        
    }

    private func userAction(username: String, password: String) {
        state.shouldIndicateActivity = true
        if newUser {
            signup(username: username, password: password)
        } else {
            login(username: username, password: password)
        }
    }

    private func signup(username: String, password: String) {
        if username.isEmpty || password.isEmpty {
            state.shouldIndicateActivity = false
            return
        }
        self.state.error = nil
        app.emailPasswordAuth.registerUser(email: username, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                state.shouldIndicateActivity = false
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    self.state.error = error.localizedDescription
                }
            }, receiveValue: {
                self.state.error = nil
                login(username: username, password: password)
            })
            .store(in: &state.cancellables)
    }

    private func login(username: String, password: String) {
        if username.isEmpty || password.isEmpty {
            state.shouldIndicateActivity = false
            return
        }
        self.state.error = nil
        app.login(credentials: .emailPassword(email: username, password: password))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                state.shouldIndicateActivity = false
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    self.state.error = error.localizedDescription
                }
            }, receiveValue: {
                self.state.error = nil
                state.loginPublisher.send($0)
            })
            .store(in: &state.cancellables)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            Group {
                LoginView()
                    .environmentObject(AppState())
                Landscape(
                    LoginView()
                        .environmentObject(AppState())
                    )
            }
        )
        .preferredColorScheme(.dark)
    }
}
