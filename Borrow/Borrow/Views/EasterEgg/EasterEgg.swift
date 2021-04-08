//
//  EasterEgg.swift
//  EPGradebook
//
//  Created by Teacher on 3/3/21.
//

import SwiftUI
import SpriteKit

struct EasterEgg: View {
  
  var scene: SKScene {
    let scene = GameScene()
    scene.scaleMode = .resizeFill
    return scene
  }
  
  var body: some View {
    SpriteView(scene: scene)
      .ignoresSafeArea()
  }
}

struct EasterEgg_Previews: PreviewProvider {
    static var previews: some View {
        EasterEgg()
    }
}
