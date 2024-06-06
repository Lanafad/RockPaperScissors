//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by lana alfaadhel on 06/06/2024.
//

import SwiftUI

struct RockPaperScissorsView: View {

    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack {
                
                Text("\(viewModel.userScore)")
                    .font(.largeTitle.bold())
                    .animation(.easeIn(duration: 0.1))
                    .foregroundStyle(.text)
                
                Image("Computer\(viewModel.moves[viewModel.appMove])")
                    .resizable()
                    .frame(width: 150, height: 270)
                
                Spacer()
                
                Text(viewModel.shouldWin ? "WIN!" : "LOSE!")
                    .font(.system(size: 70, weight: .bold, design: .rounded))
                    .foregroundStyle(.text)
                
                
                Spacer()
                
                HStack {
                    ForEach(viewModel.moves , id:\.self) { move in
                        Button(action: {
                            viewModel.buttonPressed(move: move)
                            print(viewModel.userScore)
                        }, label: {
                            Image("Human\(move)")
                                .resizable()
                                .frame(width: 60, height: 105)
                                .padding()
                        })
                    }
                }
            }
            .foregroundStyle(.white)
            
        }
        .alert(item: $viewModel.alertItem) { alert in
            Alert(title: alert.title, message: alert.message, dismissButton: .default(alert.resetButtonText, action: {
                
            }))
        }
    }
    

}




#Preview {
    RockPaperScissorsView()
}
