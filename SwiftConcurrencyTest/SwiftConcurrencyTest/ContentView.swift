//
//  ContentView.swift
//  SwiftConcurrencyTest
//
//  Created by goazle on 2022/08/04.
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ContentView: View {

    private let animalSoundPlayer = AnimalSoundsPlayer()

    // Current date
    private var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return dateFormatter.string(from: Date())
    }

    var body: some View {
        Button("Animal Sound Play", action: {
            // Dog Task and Cat Task are parallel processes.

            // Dog Task
            // after await task, a dog barks, again after await task, a dog barks.
            Task {
                try await taskSleep(taskName: "Dog-1")
                animalSoundPlayer.playDog()
                try await taskSleep(taskName: "Dog-2")
                animalSoundPlayer.playDog()
            }
            // Cat Task
            // after await task, a cat mews
            Task {
                try await taskSleep(taskName: "Cat-1")
                animalSoundPlayer.playCat()
            }
        })
    }

    // This task is a pseudo asynchronous processing and actually sleeps for 2 seconds.
    private func taskSleep(taskName: String) async throws {
        print("\(date) \(taskName) Start")
        try await Task.sleep(nanoseconds: 2_000_000_000)
        print("\(date) \(taskName) End")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
