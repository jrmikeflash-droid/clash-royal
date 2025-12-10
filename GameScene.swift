import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var playerTower: SKSpriteNode!
    private var enemyTower: SKSpriteNode!
    private var lastSpawnTime: TimeInterval = 0

    override func didMove(to view: SKView) {
        backgroundColor = .green
        setupTowers()
    }

    func setupTowers() {
        playerTower = SKSpriteNode(color: .blue, size: CGSize(width: 60, height: 120))
        playerTower.position = CGPoint(x: size.width * 0.2, y: size.height / 2)
        addChild(playerTower)

        enemyTower = SKSpriteNode(color: .red, size: CGSize(width: 60, height: 120))
        enemyTower.position = CGPoint(x: size.width * 0.8, y: size.height / 2)
        addChild(enemyTower)
    }

    func spawnUnit(isPlayer: Bool) {
        let unit = SKSpriteNode(color: isPlayer ? .cyan : .orange, size: CGSize(width: 30, height: 30))
        unit.position = isPlayer ? playerTower.position : enemyTower.position
        unit.name = isPlayer ? "playerUnit" : "enemyUnit"

        let direction: CGFloat = isPlayer ? 1 : -1
        let move = SKAction.moveBy(x: direction * 1000, y: 0, duration: 8)
        unit.run(move)

        addChild(unit)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        spawnUnit(isPlayer: true)
    }

    override func update(_ currentTime: TimeInterval) {
        if currentTime - lastSpawnTime > 3 {
            spawnUnit(isPlayer: false)
            lastSpawnTime = currentTime
        }
    }
}
