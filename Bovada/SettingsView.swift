//
//  SettingsView.swift
//  ProMatch
//
//  Created by Кирилл Архипов on 23.06.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    @State private var showNotificationAlert = false

    @State private var showImagePicker = false
    @State private var pickerSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var showSourceSheet = false

    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 15) {
                Text("Settings")
                    .foregroundStyle(.white)
                    .font(.system(size: 20))
                    .padding(.bottom)
                Text("Your Photo")
                    .foregroundStyle(.white)
                    .font(.system(size: 18))
                HStack {
                    ZStack {
                        Color.backgroundMain
                        Image(systemName: "person.fill")
                            .foregroundStyle(.grayMain)
                            .font(.system(size: 40))
                        if let data = userService.imageData, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    Button {
                        showSourceSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "camera.fill")
                            Text("Upload Photo")
                        }
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                        .colorFramed(color: .backgroundMain)
                    }
                    Spacer()
                }
                .darkFramed()
                Text("Notifications")
                    .foregroundStyle(.white)
                    .font(.system(size: 18))
                HStack {
                    VStack (alignment: .leading, spacing: 10) {
                        Text("App Notifications")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                        Text("Enable/disable all notifications")
                            .foregroundStyle(.grayMain)
                            .font(.system(size: 14))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .layoutPriority(1)
                    Spacer()
                    Toggle("", isOn: Binding(
                        get: { userService.isNotificationEnabled },
                        set: { newValue in
                            userService.toggleNotifications(to: newValue) {
                                showNotificationAlert = true
                            }
                        }
                    ))
                    .toggleStyle(CustomToggleStyle())
                }
                .darkFramed()
                .padding(.bottom)

                Text("Vibration")
                    .foregroundStyle(.white)
                    .font(.system(size: 18))
                HStack {
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Vibration Alerts")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                        Text("For timers and side changes in umpire mode")
                            .foregroundStyle(.grayMain)
                            .font(.system(size: 14))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .layoutPriority(1)
                    Spacer()
                    Toggle("", isOn: $userService.isVibration)
                    .toggleStyle(CustomToggleStyle())
                }
                .darkFramed()
                .padding(.bottom)

                Text("Data Management")
                    .foregroundStyle(.white)
                    .font(.system(size: 18))
                HStack {
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Clear Match History")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                        Text("Delete all match records")
                            .foregroundStyle(.grayMain)
                            .font(.system(size: 14))
                    }
                    Spacer()
                    Button {
                        userService.removeMatches()
                    } label: {
                        Text("Clear")
                            .foregroundStyle(.redMain)
                            .font(.system(size: 14))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.backgroundMain)
                            )
                    }

                }
                .darkFramed()
                .padding(.bottom)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 60)
            .padding(.bottom, getSafeAreaBottom())
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .alert("Notifications Disabled", isPresented: $showNotificationAlert) {
            Button("Open Settings") {
                NotificationManager.shared.openAppSettings()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("To enable notifications, please allow them in Settings.")
        }
        .confirmationDialog("Select Source", isPresented: $showSourceSheet, titleVisibility: .visible) {
            Button("Camera") {
                pickerSource = .camera
                showImagePicker = true
            }
            Button("Photo Library") {
                pickerSource = .photoLibrary
                showImagePicker = true
            }
            Button("Cancel", role: .cancel) {}
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: pickerSource) { selectedImage in
                userService.imageData = selectedImage
            }
        }
        .background(.backgroundMain)
    }
}

#Preview {
    SettingsView()
        .environmentObject(UserService())
        .background(.black)
}


#Preview {
    NavigationStack {
        NavigationLink("Settings") {
            SettingsView()
                .environmentObject(UserService())
                .background(.black)
        }
    }
}
