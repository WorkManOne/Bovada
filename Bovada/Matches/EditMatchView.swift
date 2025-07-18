//
//  EditMatchView.swift
//  Bovada
//
//  Created by Кирилл Архипов on 16.07.2025.
//

import SwiftUI

struct EditMatchView: View {
    let isEditing: Bool
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    @State private var showingDatePicker = false
    @State private var match = MatchModel()

    @State private var showImagePicker = false
    @State private var pickerSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var showSourceSheet = false


    init(match: MatchModel? = nil) {
        if let match = match {
            self._match = State(initialValue: match)
            isEditing = true
        } else {
            self._match = State(initialValue: MatchModel())
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
                    Text(isEditing ? "Edit Match" : "Add Match")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 30)
                Text("Opponent")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                Menu {
                    Button(action: {
                        match.opponent = nil
                    }) {
                        Text("Select opponent")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                    }
                    ForEach(userService.players) { opponent in
                        Button(action: {
                            match.opponent = opponent
                        }) {
                            Text(opponent.name)
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                        }
                    }
                } label: {
                    HStack {
                        Text(match.opponent == nil ? "Select opponent" : match.opponent?.name ?? "")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .foregroundColor(.white)
                    .darkFramed()
                }
                NavigationLink {
                    EditPlayerView()
                } label: {
                    Text("+ Add new opponent")
                        .font(.system(size: 14))
                        .foregroundStyle(.redMain)
                }
                .padding(.bottom)
                HStack {
                    VStack (alignment: .leading) {
                        Text("Date")
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                        Button {
                            showingDatePicker = true
                        } label: {
                            HStack {
                                Text(formatter.string(from: match.date))
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16))
                                Spacer()
                            }
                            .darkFramed()
                        }
                    }
                    VStack (alignment: .leading) {
                        Text("Location")
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                        Menu {
                            Button(action: {
                                match.location = nil
                            }) {
                                Text("Select Court")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                            }
                            ForEach(userService.courts) { court in
                                Button(action: {
                                    match.location = court
                                }) {
                                    Text(court.name)
                                        .font(.system(size: 16))
                                        .foregroundStyle(.white)
                                }
                            }
                        } label: {
                            HStack {
                                Text(match.location == nil ? "Select Court" : match.location?.name ?? "")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .foregroundColor(.white)
                            .darkFramed()
                        }
                    }
                }
                .padding(.bottom)
                Text("Final Score")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                ForEach (Array(match.sets.enumerated()), id: \.element.id) { index, opponent in
                    HStack {
                        Text("Set \(index+1)")
                            .font(.system(size: 14))
                            .foregroundStyle(.grayMain)
                        TextField("", text: Binding(
                            get: { "\(match.sets[index].score1)" },
                            set: { match.sets[index].score1 = Int($0) ?? 0 })
                        )
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                        .darkFramed()
                        .frame(width: 60)
                        Text(":")
                            .font(.system(size: 16))
                            .foregroundStyle(.grayMain)
                        TextField("", text: Binding(
                            get: { "\(match.sets[index].score2)" },
                            set: { match.sets[index].score2 = Int($0) ?? 0 })
                        )
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                        .darkFramed()
                        .frame(width: 60)
                    }
                }
                HStack {
                    Button {
                        withAnimation {
                            match.sets.append(SetModel())
                        }
                    } label: {
                        Text("+ Add set")
                            .font(.system(size: 14))
                            .foregroundStyle(.redMain)
                    }
                    Spacer()
                    Button {
                        withAnimation {
                            if !match.sets.isEmpty {
                                match.sets.removeLast()
                            }
                        }
                    } label: {
                        Text("- Remove set")
                            .font(.system(size: 14))
                            .foregroundStyle(.redMain)
                    }
                }
                .padding(.bottom)
                Text("Match Outcome")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                HStack {
                    Button {
                        withAnimation {
                            match.isWin = true
                        }
                    } label: {
                        HStack {
                            Image("win")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.redMain)
                                .frame(width: 15, height: 15)
                            Text("Win")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                        .darkFramed(isBordered: match.isWin)
                    }
                    Button {
                        withAnimation {
                            match.isWin = false
                        }
                    } label: {
                        HStack {
                            Image(systemName: "xmark")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.white)
                                .frame(width: 15, height: 15)
                            Text("Loss")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                        .darkFramed(isBordered: !match.isWin)
                    }
                }
                .padding(.bottom)
                Text("General Notes")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                ZStack(alignment: .topLeading) {
                    if match.notes.isEmpty {
                        Text("Add your match notes here...")
                            .foregroundColor(.grayMain)
                            .font(.system(size: 16))
                            .padding(.top, 8)
                            .padding(.leading, 5)
                    }
                    TextEditor(text: $match.notes)
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .regular))
                        .frame(minHeight: 70)
                }
                .darkFramed()
                .padding(.bottom)
                Button {
                    if isEditing {
                        if let index = userService.matches.firstIndex(where: { $0.id == match.id }) {
                            userService.matches[index] = match
                        }
                    } else {
                        userService.matches.append(match)
                    }
                    dismiss()
                } label: {
                    Text("Save Match")
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
        .sheet(isPresented: $showingDatePicker) {
            CustomDatePickerSheet(selectedDate: $match.date)
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    EditMatchView()
        .environmentObject(UserService())
}
