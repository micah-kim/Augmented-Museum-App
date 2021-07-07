//
//  ViewController.swift
//  TitlePageTest
//
//  Created by Micah Kim on 6/22/21.
//
import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var dioramaNode: SCNNode?
    var titleNode: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        let dioramaScene = SCNScene(named: "art.scnassets/dioramaTest.obj")
        let titleScene = SCNScene(named: "art.scnassets/Title.obj")
        dioramaNode = dioramaScene?.rootNode
        titleNode = titleScene?.rootNode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        
        // this is the "Photos" file that contains the reference images
        guard let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "Title", bundle: Bundle.main) else {
            print("No image available")
            return
        }
        
        configuration.trackingImages = trackedImages
        configuration.maximumNumberOfTrackedImages = 3

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let size = imageAnchor.referenceImage.physicalSize
            let plane = SCNPlane(width: size.width, height: size.height)
            plane.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.5)
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
            
            // this is the object scene that is being displayed
            var shapeNode: SCNNode?
            if imageAnchor.referenceImage.name == "Aristotle" {
                shapeNode = titleNode
            } else {
                shapeNode = dioramaNode
            }
            
            guard let shape = shapeNode else { return nil }
            shape.position = SCNVector3Zero
            shape.scale = SCNVector3(x: 0.0015, y: 0.0015, z: 0.0015)
            shape.position.y = 0.00
            node.addChildNode(shape)
        }
        return node
    }
}

