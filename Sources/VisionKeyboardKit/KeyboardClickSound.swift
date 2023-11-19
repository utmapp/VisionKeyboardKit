//
// Copyright © 2023 osy. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import AVFAudio
import RealityKit

/// Plays the system keyboard click sound
class KeyboardClickSound {
    enum File {
        case normal
        case delete
        case modifier
    }
    
    /// The RK entity where the sound will originate
    let entity = Entity()

    private var pressNormalPlayer: AudioPlaybackController?
    private var pressDeletePlayer: AudioPlaybackController?
    private var pressModifierPlayer: AudioPlaybackController?

    private func loadAudioResource(for url: URL) -> AudioFileResource? {
        let configuration = AudioFileResource.Configuration(calibration: .absolute(dBSPL: 58.0))
        return try? .load(contentsOf: url, configuration: configuration)
    }

    #if targetEnvironment(simulator)
    /// This is a very hacky way to get the keyboard sound files in a simulator
    private lazy var uiSoundsUrl: URL = {
        let fm = FileManager.default
        let library = fm.urls(for: .libraryDirectory, in: .localDomainMask)[0]
        let simulators = library.appending(components: "Developer", "CoreSimulator", "Volumes")
        let visionos = try? fm.contentsOfDirectory(at: simulators, includingPropertiesForKeys: nil).first(where: { $0.lastPathComponent.starts(with: "xrOS") || $0.lastPathComponent.starts(with: "visionOS") })
        guard let visionos = visionos else {
            return Bundle.main.resourceURL!
        }
        let runtimes = visionos.appending(components: "Library", "Developer", "CoreSimulator", "Profiles", "Runtimes")
        let runtime = try? fm.contentsOfDirectory(at: runtimes, includingPropertiesForKeys: nil).first
        guard let runtime = runtime else {
            return Bundle.main.resourceURL!
        }
        return runtime.appending(components: "Contents", "Resources", "RuntimeRoot", "System", "Library", "Audio", "UISounds")
    }()
    #else
    private lazy var uiSoundsUrl: URL = {
        let fm = FileManager.default
        let library = fm.urls(for: .libraryDirectory, in: .systemDomainMask)[0]
        return library.appending(components: "Audio", "UISounds")
    }()
    #endif

    private lazy var isEnabled: Bool = {
        var valid: DarwinBoolean = false
        CFPreferencesAppSynchronize("com.apple.preferences.sounds" as CFString)
        let enabled = CFPreferencesGetAppBooleanValue("keyboard-audio" as CFString, "com.apple.preferences.sounds" as CFString, &valid)
        return !valid.boolValue || enabled
    }()

    init() {
        // if we disabled system sounds then do not create the players
        guard isEnabled else {
            return
        }
        let pressNormalUrl = uiSoundsUrl.appending(component: "key_press_click.caf")
        let pressDeleteUrl = uiSoundsUrl.appending(component: "key_press_delete.caf")
        let pressModifierUrl = uiSoundsUrl.appending(component: "key_press_modifier.caf")
        if let resource = loadAudioResource(for: pressNormalUrl) {
            pressNormalPlayer = entity.prepareAudio(resource)
        }
        if let resource = loadAudioResource(for: pressDeleteUrl) {
            pressDeletePlayer = entity.prepareAudio(resource)
        }
        if let resource = loadAudioResource(for: pressModifierUrl) {
            pressModifierPlayer = entity.prepareAudio(resource)
        }
    }

    private func withAmbientSession(_ callback: () async -> Void) async {
        let session = AVAudioSession.sharedInstance()
        let oldCategory = session.category
        let oldMode = session.mode
        let oldPolicy = session.routeSharingPolicy
        let oldOptions = session.categoryOptions
        do {
            try session.setCategory(.ambient, mode: .default, policy: .default, options: .mixWithOthers)
            await callback()
            try session.setCategory(oldCategory, mode: oldMode, policy: oldPolicy, options: oldOptions)
        } catch {
            print(error)
        }
    }

    @MainActor
    private func play(_ player: AudioPlaybackController?) async {
        guard let player = player else {
            return
        }
        await withAmbientSession {
            if player.isPlaying {
                player.stop()
                player.completionHandler?()
            }
            await withCheckedContinuation { continuation in
                player.completionHandler = {
                    player.completionHandler = nil
                    continuation.resume()
                }
                player.play()
            }
        }
    }

    /// Play the click sound
    ///
    /// Will return asynchronously when the sound finishes playing.
    /// - Parameter sound: Which sound to play
    @MainActor
    func play(sound: File = .normal) async {
        switch sound {
        case .normal: await play(pressNormalPlayer)
        case .delete: await play(pressDeletePlayer)
        case .modifier: await play(pressModifierPlayer)
        }
    }
}
