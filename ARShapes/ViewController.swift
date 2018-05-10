//
//  ViewController.swift
//  ARShapes
//
//  Created by Shawn Roller on 5/8/18.
//  Copyright © 2018 Shawn Roller. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    private let useScene = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true
        var scene = SCNScene()
        if useScene {
            scene = SCNScene(named: "art.scnassets/TestScene.scn")!
        }
        sceneView.scene = scene
        if !useScene {
            createShapes()
        }
    }
    
    func createShapes() {
        let pyramid = SCNPyramid(width: 0.2, height: 0.2, length: 0.2)
        pyramid.firstMaterial?.diffuse.contents = UIColor.blue
        let pyramidNode = SCNNode(geometry: pyramid)
        pyramidNode.position.z = -0.8
        sceneView.scene.rootNode.addChildNode(pyramidNode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
}
