//
//  AddFeedingView.swift
//  ChickenRoad
//
//  Created by Кирилл Архипов on 27.06.2025.
//

import SwiftUI

struct EditCourtView: View {
    let isEditing: Bool
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    @State private var court = CourtModel()

    @State private var selectedImageSlot: Int? = nil
    @State private var showImagePicker = false
    @State private var pickerSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var showSourceSheet = false

    init(court: CourtModel? = nil) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.redMain)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.grayMain], for: .normal)
        if let court = court {
            self._court = State(initialValue: court)
            isEditing = true
        } else {
            self._court = State(initialValue: CourtModel())
            isEditing = false
        }
    }

    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 10) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                    }
                    Text(isEditing ? "Edit Court" : "Add Court")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
                Text("Court Name")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                TextField("", text: $court.name, prompt: Text("Enter court or club name").foregroundColor(.grayMain))
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                    .darkFramed()
                Text("Location")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white)
                TextField("", text: $court.location, prompt: Text("Address or location details").foregroundColor(.grayMain))
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                    .darkFramed()
                Text("Court Type")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white)
                HStack (spacing: 10) {
                    TypePickView(type: .hard, selectedType: $court.type)
                    TypePickView(type: .clay, selectedType: $court.type)
                    TypePickView(type: .grass, selectedType: $court.type)
                }
                HStack (spacing: 10) {
                    TypePickView(type: .carpet, selectedType: $court.type)
                    TypePickView(type: .other, selectedType: $court.type)
                    Text("")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.bottom, 20)
                Text("Court Setting")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                Picker("", selection: $court.setting) {
                    ForEach(CourtSetting.allCases, id: \.self) { court in
                        Text(court.rawValue)
                            .foregroundStyle(.white)
                            .font(.system(size: 16))

                    }
                }
                .pickerStyle(.segmented)
                Text("Upload Photos (optional, max 3)")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white)
                    .padding(.top)
                HStack {
                    Button {
                        showSourceSheet = true
                        selectedImageSlot = 1
                    } label: {
                        ZStack {
                            VStack {
                                Image(systemName: "camera.fill")
                                    .foregroundStyle(.redMain)
                                Text("Add photo")
                                    .foregroundStyle(.grayMain)
                                    .font(.system(size: 14, weight: .medium))
                            }
                            if let data = court.imageData1, let image = UIImage(data: data) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100)
                            }
                        }
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .background(.darkFrame)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .clipped()
                    }
                    Button {
                        showSourceSheet = true
                        selectedImageSlot = 2
                    } label: {
                        ZStack {
                            VStack {
                                Image(systemName: "camera.fill")
                                    .foregroundStyle(.redMain)
                                Text("Add photo")
                                    .foregroundStyle(.grayMain)
                                    .font(.system(size: 14, weight: .medium))
                            }
                            if let data = court.imageData2, let image = UIImage(data: data) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100)
                            }
                        }
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .background(.darkFrame)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .clipped()
                    }
                    Button {
                        showSourceSheet = true
                        selectedImageSlot = 3
                    } label: {
                        ZStack {
                            VStack {
                                Image(systemName: "camera.fill")
                                    .foregroundStyle(.redMain)
                                Text("Add photo")
                                    .foregroundStyle(.grayMain)
                                    .font(.system(size: 14, weight: .medium))
                            }
                            if let data = court.imageData3, let image = UIImage(data: data) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100)
                            }
                        }
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .background(.darkFrame)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .clipped()
                    }
                }
                .padding(.bottom)
                Text("Rate This Court")
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                HStack {
                    Text("Booking Convenience")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                    Spacer()
                    ForEach (1...5, id: \.self) { index in
                        Image(systemName: Int(court.convenience) >= index ? "star.fill" : "star")
                            .foregroundStyle(.redMain)
                            .font(.system(size: 14))
                    }
                }
                CustomSlider(value: $court.convenience)
                HStack {
                    Text("Surface Condition")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                    Spacer()
                    ForEach (1...5, id: \.self) { index in
                        Image(systemName: Int(court.condition) >= index ? "star.fill" : "star")
                            .foregroundStyle(.redMain)
                            .font(.system(size: 14))
                    }
                }
                CustomSlider(value: $court.condition)
                HStack {
                    Text("Lighting")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                    Spacer()
                    ForEach (1...5, id: \.self) { index in
                        Image(systemName: Int(court.lighting) >= index ? "star.fill" : "star")
                            .foregroundStyle(.redMain)
                            .font(.system(size: 14))
                    }
                }
                CustomSlider(value: $court.lighting)
                HStack {
                    Text("Amenities")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                    Spacer()
                    ForEach (1...5, id: \.self) { index in
                        Image(systemName: Int(court.amenities) >= index ? "star.fill" : "star")
                            .foregroundStyle(.redMain)
                            .font(.system(size: 14))
                    }
                }
                CustomSlider(value: $court.amenities)
                Text("Comments (optional)")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                ZStack(alignment: .topLeading) {
                    if court.comments.isEmpty {
                        Text("Share your experience with this court...")
                            .foregroundColor(.grayMain)
                            .font(.system(size: 16))
                            .padding(.top, 8)
                            .padding(.leading, 5)
                    }
                    TextEditor(text: $court.comments)
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .regular))
                        .frame(minHeight: 100)
                }
                .darkFramed()
                Button {
                    if isEditing {
                        if let index = userService.courts.firstIndex(where: { $0.id == court.id }) {
                            userService.courts[index] = court
                        }
                    } else {
                        userService.courts.append(court)
                    }
                    dismiss()
                } label: {
                    Text("Save Court")
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
                guard let slot = selectedImageSlot else { return }
                switch slot {
                case 1:
                    court.imageData1 = selectedImage
                case 2:
                    court.imageData2 = selectedImage
                case 3:
                    court.imageData3 = selectedImage
                default:
                    break
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil, from: nil, for: nil)
        }
    }
}

struct TypePickView: View {
    let type: CourtType
    @Binding var selectedType: CourtType

    var body : some View {
        Button {
            selectedType = type
        } label: {
            Text(type.rawValue)
                .font(.system(size: 16))
                .foregroundStyle(.white)
                .darkFramed(isBordered: selectedType == type)
        }
    }
}


#Preview {
    EditCourtView()
        .environmentObject(UserService())
}
