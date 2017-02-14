//
//  File.swift
//  BTreeTester
//
//  Created by Moorthy, Prashanth on 2/13/17.
//  Copyright © 2017 Moorthy, Prashanth. All rights reserved.
//

import Foundation
import UIKit


class BTViewer {
    
    init() {}
    
    var iCurrentWorkingNode : BTNode? = nil
    var treeRootPosition = 2   // Root Node always has 2 tabs.

    var theTreeString = ""

    func displayTree(_ theTree : BTree){
        calculateTreeWidth(theNode: theTree.rootNode!)
        print("The Tree Left Width is ......... \(treeRootPosition)")
        startPrinting(fromNode: theTree.rootNode!)
        }
    
    func  startPrinting(fromNode theNode : BTNode) {
        
        let currentWorkingNode = theNode
        
        if !theNode.hasLeftNode && !theNode.hasRightNode {return}
        
        // Make the Root Node :
        let initialSpace = String(repeating: "\t", count: treeRootPosition)
        let rootString = " " + String(currentWorkingNode.value)
        let leftLeg = "\n" + initialSpace + "⋰"
        let rightLeg = "⋱"
        
        let finalString = initialSpace + rootString + leftLeg + rightLeg
        print(finalString)
        
        if currentWorkingNode.hasLeftNode{
            treeRootPosition -= 1
            startPrinting(fromNode: currentWorkingNode.leftChildNode!)
        } else {return}
    }
    
    func calculateTreeWidth(theNode : BTNode) -> Int{
        
        let currentWorkingNode = theNode
        
        if currentWorkingNode.hasLeftNode {
            treeRootPosition += 2
            return calculateTreeWidth(theNode: currentWorkingNode.leftChildNode!)
        }
        
        // Adding space for the final leaf node.
        print("We... have fallen trough.. the in the calculate function.....  ")
        treeRootPosition += 2
        return treeRootPosition
    }
}




class BTNodeDisplay {
    
    static func displayNode(binaryTreeNode : BTNode){
        
    }
    
    func buildRoot(node : BTNode) -> UIView {
        return NodeView(color: nil, displayValue: "Nil")
    }
    
    
    func makeEmptyNode() -> NodeView {
        
      return NodeView(color: nil, displayValue: "Nil")
        
    }
}



class NodeView : UIView {
    
    var nodeDisplayValue : String?
    var nodeColor : UIColor = UIColor.red
    
    override init(frame : CGRect){
        super.init(frame: frame)
    }
    
    convenience init(color : UIColor? = nil, displayValue : String? = nil) {
        self.init(frame : CGRect(x: 0, y: 0, width: 20.0, height: 20.0))
        nodeColor = color ?? UIColor.gray
        nodeDisplayValue = displayValue ?? nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        print("Draw Rect Got called.")
        self.backgroundColor = UIColor.red
        self.layer.backgroundColor = UIColor.red.cgColor
        
    }
    
}
