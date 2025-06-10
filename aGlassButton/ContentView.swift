//
//  ContentView.swift
//  aGlassButton
//
//  Created by The M4P on 6/9/25.
//

import SwiftUI

struct ContentView: View {
    let icons = ["🍏", "🍎", "🍊", "🍌", "🍇", "🍓", "🍒", "🍑", "🍍", "🍐", "🍋", "🍅"]
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 16) {
                    ForEach(icons, id: \.self) { icon in
                        Text(icon)
                            .font(.system(size: 28))
                            .frame(width: 64, height: 64)
                            .containerShape(Rectangle())
                            .glassButton(
                                downAction: {print("\(icon) DOWN")},
                                downContAction: {print("\(icon) DOWN CONTINUE")},
                                upAction: {print("\(icon) UP")}
                            )
                            .colorScheme(.dark)
                    }
                }
                .padding(16)

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 16) {
                    ForEach(icons, id: \.self) { icon in
                        Text(icon)
                            .font(.system(size: 28))
                            .frame(width: 64, height: 64)
                            .containerShape(Rectangle())
                            .glassButton(
                                downAction: {print("\(icon) DOWN")},
                                downContAction: {print("\(icon) DOWN CONTINUE")},
                                upAction: {print("\(icon) UP")}
                            )
                            .colorScheme(.light)
                    }
                }
                .padding(16)

                Spacer()
                
                HStack {
                    Text("🪴")
                    Text("Hello, world!")
                }
                .font(.system(size: 24, weight: .bold))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .containerShape(Rectangle())
                .glassButton(
                    downAction: {print("DOWN")},
                    downContAction: {print("DOWN CONTINUE")},
                    upAction: {print("UP")}
                )
                .colorScheme(.dark)
                
                HStack {
                    Text("🪴")
                    Text("Hello, world!")
                }
                .font(.system(size: 24, weight: .bold))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .containerShape(Rectangle())
                .glassButton(
                    downAction: {print("DOWN")},
                    downContAction: {print("DOWN CONTINUE")},
                    upAction: {print("UP")}
                )
                .colorScheme(.light)
                
                HStack {
                    Text("🍏")
                    Rectangle()
                        .frame(width: 4, height: 24)
                        .cornerRadius(2)
                    Text("🍎")
                }
                .font(.system(size: 24, weight: .bold))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .containerShape(Rectangle())
                .glassTwoSideButton(
                    downAction1: {print("🍏 DOWN")},
                    downContAction1: {print("🍏 DOWN CONTINUE")},
                    upAction1: {print("🍏 UP")},
                    downAction2: {print("🍎 DOWN")},
                    downContAction2: {print("🍎 DOWN CONTINUE")},
                    upAction2: {print("🍎 UP")}
                )
                .colorScheme(.dark)
                
                HStack {
                    Text("🍏")
                    Rectangle()
                        .frame(width: 4, height: 24)
                        .cornerRadius(2)
                    Text("🍎")
                }
                .font(.system(size: 24, weight: .bold))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .containerShape(Rectangle())
                .glassTwoSideButton(
                    downAction1: {print("🍏 DOWN")},
                    downContAction1: {print("🍏 DOWN CONTINUE")},
                    upAction1: {print("🍏 UP")},
                    downAction2: {print("🍎 DOWN")},
                    downContAction2: {print("🍎 DOWN CONTINUE")},
                    upAction2: {print("🍎 UP")}
                )
                .colorScheme(.light)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
