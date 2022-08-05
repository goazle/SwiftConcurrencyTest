//
//  AnimalPlayer.swift
//  SwiftConcurrencyTest
//
//  Created by goazle on 2022/08/04.
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import AVFoundation

struct AnimalSoundsPlayer {
    private var dogPlayer: AVAudioPlayer?
    private var catPlayer: AVAudioPlayer?

    init() {
        dogPlayer = player(animal: "dog")
        catPlayer = player(animal: "cat")
    }

    private func player(animal: String) -> AVAudioPlayer? {
        if let animalData = NSDataAsset(name: animal) {
            print(animalData.data)
            do {
                let player = try AVAudioPlayer(data: animalData.data)
                player.prepareToPlay()
                return player
            } catch {
                print("Fail to create \(animal) sound.")
            }
        }
        return nil
    }

    func playDog() {
        dogPlayer?.play()
    }

    func playCat() {
        catPlayer?.play()
    }
}
