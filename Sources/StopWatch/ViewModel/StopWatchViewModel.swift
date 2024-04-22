//
//  File.swift
//
//
//  Created by Jigar Shethia on 13/04/24.
//

import Foundation
import Combine

class StopWatchViewModel: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    
    private var timer: Timer?
    private var startDate: Date?
    private let userDefaults = UserDefaults.standard
    private let elapsedTimeKey = "ElapsedTime"
    
    init() {
        // Load previous elapsed time if available
        elapsedTime = userDefaults.double(forKey: elapsedTimeKey)
        startTimer()
    }
    
    func start() {
        startDate = Date()
        startTimer()
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        if let startDate = startDate {
            elapsedTime += Date().timeIntervalSince(startDate)
            saveElapsedTime()
        }
    }
    
    func reset() {
        stop()
        elapsedTime = 0
        saveElapsedTime()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.objectWillChange.send()
            self?.updateElapsedTime()
        }
    }
    
    private func updateElapsedTime() {
        if let startDate = startDate {
            elapsedTime = Date().timeIntervalSince(startDate) + userDefaults.double(forKey: elapsedTimeKey)
        }
    }
    
    private func saveElapsedTime() {
        print("elapsedTime\(elapsedTime)")
        userDefaults.set(elapsedTime, forKey: elapsedTimeKey)
    }
}
