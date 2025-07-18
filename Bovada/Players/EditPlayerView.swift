//
//  EditPlayerView.swift
//  Bovada
//
//  Created by Кирилл Архипов on 17.07.2025.
//

import SwiftUI

struct EditPlayerView: View {
    let isEditing: Bool
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    @State private var player = PlayerModel()

    @State private var showImagePicker = false
    @State private var pickerSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var showSourceSheet = false

    init(player: PlayerModel? = nil) {
        if let player = player {
            self._player = State(initialValue: player)
            isEditing = true
        } else {
            self._player = State(initialValue: PlayerModel())
            isEditing = false
        }
    }
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 15) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                    }
                    Text(isEditing ? "Edit Player" : "Add Player")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
                Text("Name / Nickname *")
                    .font(.system(size: 14))
                    .foregroundStyle(.grayMain)
                TextField("", text: $player.name, prompt: Text("Enter player name").foregroundColor(.grayMain))
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                    .darkFramed()
                Text("Photo (optional)")
                    .font(.system(size: 14))
                    .foregroundStyle(.grayMain)
                HStack {
                    ZStack {
                        Color.darkFrame
                        Image(systemName: "person.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.grayMain)
                        if let data = player.imageData, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                    .frame(width: 80, height: 80)
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
                        .darkFramed()
                    }
                    .frame(width: 150)
                    Spacer()
                }
                Text("Contact Info (optional)")
                    .font(.system(size: 14))
                    .foregroundStyle(.grayMain)
                TextField("", text: $player.contact, prompt: Text("Phone or email").foregroundColor(.grayMain))
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                    .darkFramed()
                    .padding(.bottom)
                Text("Strengths")
                    .font(.system(size: 14))
                    .foregroundStyle(.grayMain)
                ZStack(alignment: .topLeading) {
                    if player.strengths.isEmpty {
                        Text("e.g. Strong forehand, good serve")
                            .foregroundColor(.grayMain)
                            .font(.system(size: 16))
                            .padding(.top, 8)
                            .padding(.leading, 5)
                    }
                    TextEditor(text: $player.strengths)
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                        .frame(minHeight: 100)
                }
                .darkFramed()
                Text("Weaknesses")
                    .font(.system(size: 14))
                    .foregroundStyle(.grayMain)
                ZStack(alignment: .topLeading) {
                    if player.weaknesses.isEmpty {
                        Text("e.g. Weak backhand, struggles with volleys")
                            .foregroundColor(.grayMain)
                            .font(.system(size: 16))
                            .padding(.top, 8)
                            .padding(.leading, 5)
                    }
                    TextEditor(text: $player.weaknesses)
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                        .frame(minHeight: 100)
                }
                .darkFramed()
                Text("Suggested Tactics")
                    .font(.system(size: 14))
                    .foregroundStyle(.grayMain)
                ZStack(alignment: .topLeading) {
                    if player.suggestedTactics.isEmpty {
                        Text("e.g. Attack backhand, use high balls")
                            .foregroundColor(.grayMain)
                            .font(.system(size: 16))
                            .padding(.top, 8)
                            .padding(.leading, 5)
                    }
                    TextEditor(text: $player.suggestedTactics)
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                        .frame(minHeight: 100)
                }
                .darkFramed()
                Button {
                    if isEditing {
                        if let index = userService.players.firstIndex(where: { $0.id == player.id }) {
                            userService.players[index] = player
                        }
                    } else {
                        userService.players.append(player)
                    }
                    dismiss()
                } label: {
                    Text("Save Player")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.redMain)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .background(.backgroundMain)
        .onAppear {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first,
               let nav = window.rootViewController?.children.first as? UINavigationController {
                nav.interactivePopGestureRecognizer?.isEnabled = true
                nav.interactivePopGestureRecognizer?.delegate = nil
            }
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
                player.imageData = selectedImage
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    EditPlayerView()
}



