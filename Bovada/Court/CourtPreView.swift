//
//  FeedingPreView.swift
//  ChickenRoad
//
//  Created by Кирилл Архипов on 27.06.2025.
//

import SwiftUI

struct CourtPreView: View {
    var court: CourtModel

    var body: some View {
        VStack (alignment: .leading) {
            HStack (alignment: .top) {
                ZStack {
                    Color.black
                    TabView {
                        if let data = court.imageData1, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        }
                        if let data = court.imageData2, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        }
                        if let data = court.imageData3, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack (alignment: .leading, spacing: 10) {
                    Text(court.name)
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                    HStack {
                        Image("location")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.grayMain)
                            .frame(width: 15, height: 15)
                        Text(court.location)
                            .foregroundStyle(.grayMain)
                            .font(.system(size: 12))
                    }
                    HStack (spacing: 0) {
                        ForEach (1...5, id: \.self) { index in
                            Image(systemName: court.overallRating >= index ? "star.fill" : "star")
                                .foregroundStyle(.redMain)
                                .font(.system(size: 14))
                        }
                        Text("\(court.overallRating)")
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                    }

                }
                .padding(.top, 2)
            }
            HStack {
                Text(court.type.rawValue)
                    .foregroundStyle(.white)
                    .font(.system(size: 12))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.backgroundMain)
                    )
                Text(court.setting.rawValue)
                    .foregroundStyle(.white)
                    .font(.system(size: 12))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.backgroundMain)
                    )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .darkFramed()
    }
}

#Preview {
    CourtPreView(court: CourtModel(name: "asfasdfasd"))
}
