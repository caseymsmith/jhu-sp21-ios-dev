//
//  GameScene.swift
//  SideScroller
//
//  Created by Teacher on 8/6/17.
//  Copyright © 2017 Teacher. All rights reserved.
//

import SpriteKit

//HW6: This is verbatim the code from the example app.  Per the assignment instructions, tweak this to include your own widgets/background, remove what's not needed, and also add functionality so the player can shoot a sprite where the user touches.


func random(min: CGFloat, max: CGFloat) -> CGFloat
{
  return CGFloat.random(in: min...max)
}

struct PhysicsCategory
{
  static let None    : UInt32 = 0
  static let All     : UInt32 = UInt32.max
  static let Asteroid : UInt32 = 0b1  //1
  static let Shield   : UInt32 = 0b10 //2
  static let Torpedo  : UInt32 = 0b11 //3
}


class GameScene: SKScene, SKPhysicsContactDelegate {
  
  var ship: SKSpriteNode!
  var shield: SKSpriteNode!
  var emitterNode: SKEmitterNode!
  var sunSprite: SKSpriteNode!
  var gravityField: SKFieldNode!
  
  override func sceneDidLoad()
  {
    addBackground()
    
    addShip()
    
    addShield()
    
    
    run(SKAction.repeatForever(SKAction.sequence(
      [
        SKAction.run(addAsteroid),
        SKAction.wait(forDuration: 1.0)
      ])))
    
    addPhysics()
    
    addImpulseEmitter()
    
    addSunAndGravityField()
//    print("at end of scene did load scene size is \(size)")
  }
  
  override func didChangeSize(_ oldSize: CGSize) {
    if size != .zero
    {
      guard ship != nil, shield != nil, emitterNode != nil, sunSprite != nil, gravityField != nil else { return }
      ship.position = CGPoint(x: size.width*0.22, y: size.height*0.5)
      shield.position = CGPoint(x: size.width*0.30, y: size.height*0.5)
      emitterNode!.position = CGPoint(x: size.width*0.18, y: size.height*0.5 - 25)
      sunSprite.position = CGPoint(x: size.width/2, y: 0)
      gravityField.position = CGPoint(x: size.width/2, y: 0)
    }
  }
  
  func addShip()
  {
    ship = SKSpriteNode(imageNamed: "enterprise")
    ship.xScale = 0.5
    ship.yScale = 0.5
    ship.position = CGPoint(x: size.width*0.22, y: size.height*0.5)
    self.addChild(ship)
  }
  
  func addShield()
  {
    shield = SKSpriteNode(imageNamed: "shield")
    shield.xScale = 0.5
    shield.yScale = 0.5
    shield.position = CGPoint(x: size.width*0.30, y: size.height*0.5)
    
    configureShieldPhysics()
    
    self.addChild(shield)
  }
  
  func configureShieldPhysics()
  {
    shield.physicsBody = SKPhysicsBody(circleOfRadius: shield.size.width/2)
    shield.physicsBody?.isDynamic = false
    shield.physicsBody?.categoryBitMask = PhysicsCategory.Shield
    shield.physicsBody?.contactTestBitMask = PhysicsCategory.Asteroid
    shield.physicsBody?.collisionBitMask = PhysicsCategory.None
    shield.physicsBody?.usesPreciseCollisionDetection = false
  }
  
  func addAsteroid()
  {
    let asteroid = SKSpriteNode(imageNamed: "asteroid")
    asteroid.xScale = 0.5
    asteroid.yScale = 0.5

    let actualY = random(min:asteroid.size.height/2, max:size.height - asteroid.size.height/2)
    asteroid.position = CGPoint(x: size.width + asteroid.size.width/2, y: actualY)
    
    addChild(asteroid)
    
    configureAsteroidPhysics(asteroid: asteroid)
    
    let actualDuration = random(min:CGFloat(2.0), max: CGFloat(4.0))
    
    let actionMove = SKAction.move(to: CGPoint(x:-asteroid.size.width/2, y:actualY), duration: TimeInterval(actualDuration))
    let actionMoveDone = SKAction.removeFromParent()
    asteroid.run(SKAction.sequence([actionMove, actionMoveDone]))
  }
  
  func configureAsteroidPhysics(asteroid:SKSpriteNode)
  {
    asteroid.physicsBody = SKPhysicsBody(rectangleOf: asteroid.size)
    asteroid.physicsBody?.isDynamic = true
    asteroid.physicsBody?.categoryBitMask = PhysicsCategory.Asteroid
    asteroid.physicsBody?.contactTestBitMask = PhysicsCategory.Shield
    asteroid.physicsBody?.collisionBitMask = PhysicsCategory.None
    asteroid.physicsBody?.usesPreciseCollisionDetection = false
  }
  
  func addPhysics()
  {
    physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    physicsWorld.contactDelegate = self
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    var firstBody:SKPhysicsBody
    var secondBody:SKPhysicsBody
    var secondMask: UInt32
    if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
    {
      firstBody = contact.bodyA
      secondBody = contact.bodyB
      secondMask = contact.bodyB.categoryBitMask
    }
    else
    {
      firstBody = contact.bodyB
      secondBody = contact.bodyA
      secondMask = contact.bodyA.categoryBitMask
    }
    
    guard firstBody.node != nil else { return }
    (firstBody.node as! SKSpriteNode).removeFromParent()
    if (secondMask == 0b11) {
      (secondBody.node as! SKSpriteNode).removeFromParent()
    }
  }
  
  
  func addImpulseEmitter()
  {
    let emitterPath:String  = Bundle.main.path(forResource: "Impulse", ofType: "sks")!
    let emitterPathURL:URL = URL(fileURLWithPath: emitterPath)
    let emitterData = try? Data(contentsOf: emitterPathURL)
    emitterNode = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(emitterData!) as? SKEmitterNode
    
    emitterNode!.position = CGPoint(x: size.width*0.18, y: size.height*0.5 - 25)
    emitterNode!.name = "impulse"
    emitterNode!.zPosition = 10
    emitterNode!.targetNode = self
    self.addChild(emitterNode!)
  }
  
  func addSunAndGravityField()
  {
    sunSprite = SKSpriteNode(imageNamed: "asteroid")
    sunSprite.xScale = 1
    sunSprite.yScale = 1
    
    let shader = SKShader(fileNamed: "sun.fsh")
    sunSprite.shader = shader
    sunSprite.position = CGPoint(x: size.width/2, y: 0)
    
    self.addChild(sunSprite)
    
    gravityField = SKFieldNode.radialGravityField()
    gravityField.isEnabled = true
    gravityField.position = CGPoint(x: size.width/2, y: 0)
    gravityField.strength = 50
    
    addChild(gravityField)
  }
  
  func addBackground()
  {
    let map = SKNode()
    addChild(map)
    
    let tileSet = SKTileSet(named: "Stars")!
    let tileSize = CGSize(width: 75, height: 75)
    let columns = 16
    let rows = 10
    
    let star = tileSet.tileGroups.first { $0.name == "Star"}
    
    let space = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: tileSize)
    space.fill(with: star)
    map.addChild(space)
  }
  
  func createTorpedo(travelTo pos: CGPoint) {
    let torpedo = SKSpriteNode(imageNamed: "torpedo")
    torpedo.xScale = 0.2
    torpedo.yScale = 0.2
    torpedo.position = CGPoint(x: size.width*0.22, y: size.height*0.5)
    self.addChild(torpedo)
    torpedo.physicsBody = SKPhysicsBody(circleOfRadius: torpedo.size.width/2)
    torpedo.physicsBody?.isDynamic = false
    torpedo.physicsBody?.categoryBitMask = PhysicsCategory.Torpedo
    torpedo.physicsBody?.contactTestBitMask = PhysicsCategory.Asteroid
    torpedo.physicsBody?.collisionBitMask = PhysicsCategory.None
    torpedo.physicsBody?.usesPreciseCollisionDetection = false
    
    let actionMove = SKAction.move(to: pos, duration: TimeInterval(0.2))
    let actionMoveDone = SKAction.removeFromParent()
    torpedo.run(SKAction.sequence([actionMove, actionMoveDone]))
  }
  
  func touchDown(atPoint pos : CGPoint) {
    createTorpedo(travelTo: pos)
  }
  
  func touchMoved(toPoint pos : CGPoint) {
    
  }
  
  func touchUp(atPoint pos : CGPoint) {
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    for t in touches { self.touchDown(atPoint: t.location(in: self)) }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }
  
  
  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
  }
}

