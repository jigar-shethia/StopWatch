//
//  StopWatchScreen.swift
//
//
//  Created by Jigar Shethia on 11/04/24.
//

import SwiftUI

public struct StopWatchView: View {
    public init(){}
    @StateObject var stopwatch = StopWatchViewModel()
    @State private var isRunning = false
   public var body: some View {
       VStack {
           Text(formattedTime)
               .font(.system(size: 40))
               .padding()
           
           HStack {
                     Button(isRunning ? "Stop" : "Start") {
                         if self.isRunning {
                             stopwatch.stop()
                             isRunning = false
                         } else {
                             isRunning = true
                             stopwatch.start()
                         }
                     }
                     .padding()
                     .background(Color.blue)
                     .foregroundColor(.white)
                     .cornerRadius(8)
                     
                     Button("Reset") {
                         stopwatch.reset()
                     }
                     .padding()
                     .background(Color.red)
                     .foregroundColor(.white)
                     .cornerRadius(8)
                 }
       }
   }
    private var formattedTime: String {
            let minutes = Int(stopwatch.elapsedTime) / 60
            let seconds = Int(stopwatch.elapsedTime) % 60
            let milliseconds = Int((stopwatch.elapsedTime * 10).truncatingRemainder(dividingBy: 10))
            return String(format: "%02d:%02d.%01d", minutes, seconds, milliseconds)
        }
}

#Preview {
    StopWatchView()
}
