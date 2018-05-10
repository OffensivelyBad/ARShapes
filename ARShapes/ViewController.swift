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
            addLights()
        }
    }
    
    private func createShapes() {
        let pyramid = SCNPyramid(width: 0.2, height: 0.2, length: 0.2)
        pyramid.firstMaterial?.diffuse.contents = UIColor.blue
        let pyramidNode = SCNNode(geometry: pyramid)
        pyramidNode.position.z = -0.8
        sceneView.scene.rootNode.addChildNode(pyramidNode)
        
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0.01)
        box.firstMaterial?.diffuse.contents = UIColor.red
        let boxNode = SCNNode(geometry: box)
        boxNode.position = SCNVector3Make(-0.5, 0, -0.8)
        sceneView.scene.rootNode.addChildNode(boxNode)
        
        let sphere = SCNSphere(radius: 0.2)
        sphere.firstMaterial?.diffuse.contents = UIColor.yellow
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3Make(0.5, 0, -0.8)
        sceneView.scene.rootNode.addChildNode(sphereNode)
    }
    
    private func addLights() {
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        let directionalNode = SCNNode()
        directionalNode.light = directionalLight
        directionalNode.eulerAngles.x = -.pi/4
        sceneView.scene.rootNode.addChildNode(directionalNode)
        
        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.color = UIColor.lightGray
        let ambientNode = SCNNode()
        ambientNode.light = ambientLight
        sceneView.scene.rootNode.addChildNode(ambientNode)
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
