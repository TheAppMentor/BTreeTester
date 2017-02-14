//
//  ViewController.swift
//  BTreeTester
//
//  Created by Moorthy, Prashanth on 2/13/17.
//  Copyright © 2017 Moorthy, Prashanth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let theTree = BTree()
        theTree.insertNoder(inputNode: BTNode(8))
        theTree.insertNoder(inputNode: BTNode(3))
        theTree.insertNoder(inputNode: BTNode(1))
        theTree.insertNoder(inputNode: BTNode(6))
        theTree.insertNoder(inputNode: BTNode(4))
        theTree.insertNoder(inputNode: BTNode(7))
        theTree.insertNoder(inputNode: BTNode(10))
        theTree.insertNoder(inputNode: BTNode(14))
        theTree.insertNoder(inputNode: BTNode(13))
        theTree.insertNoder(inputNode: BTNode(0))
        theTree.insertNoder(inputNode: BTNode(-1))

        theTree.search(10)

        let theTreeViewer = BTViewer()
        theTreeViewer.displayTree(theTree)

        //theTree.traverseTree(traversalType: .PreOrder)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let theNodeView = NodeView(color: UIColor.red, displayValue: "H")
        self.view.addSubview(theNodeView)
        
        theNodeView.center = self.view.center
        
    }
}

//func ==(lhs : BTNode , rhs : BTNode) {return lhs.value == rhs.value}
func <(lhs : BTNode , rhs : BTNode) -> Bool {return lhs.value < rhs.value}
func >(lhs : BTNode , rhs : BTNode) -> Bool {return lhs.value > rhs.value}
func >=(lhs : BTNode , rhs : BTNode) -> Bool {return (lhs.value > rhs.value || lhs.value == rhs.value)}
func <=(lhs : BTNode , rhs : BTNode)  -> Bool {return (lhs.value > rhs.value || lhs.value == rhs.value)}
func ==(lhs: BTNode, rhs: BTNode) -> Bool {return lhs.value == rhs.value}

class BTNode : CustomStringConvertible, Comparable{

    
    var description: String {
        return "\t\t\(_parentNode) \n \t\t¦ \n  \t\t\(self.theValue) \n\t ⋰  ⋱  \n   \(leftNode?.value ?? -1) \t  \(rightNode?.value ?? -1)"
    }
    
    private var theValue : Int
    private var _parentNode : BTNode? = nil
    private var leftNode : BTNode? = nil
    private var rightNode : BTNode? = nil
    
    private init(){
        theValue = 0
    }
    
    init(_ value : Int) {
        theValue = value
    }
    
    var value : Int {return theValue}
    
    var leftChildNode : BTNode? {
        get{
            return leftNode
        }
        
        set{
            self.leftNode = newValue
        }
    }
    var rightChildNode : BTNode? {
        get{
            return rightNode
        }
        
        set{
            self.rightNode = newValue
        }
    }
    weak var parentNode : BTNode? {
        get {return _parentNode}
        set {print("Setting Parent Node to \(newValue)")
            _parentNode = newValue
        }
    }
    
    var hasLeftNode : Bool{
        return leftChildNode != nil
    }

    var hasRightNode : Bool{
        return rightChildNode != nil
    }
    
    var hasLeaves : Bool{
        return hasLeftNode || hasRightNode
    }
}


enum BTreeTraverseType{
    case InOrder
    case PreOrder
    case PostOrder
}

class BTree{
    
    private var _rootNode : BTNode?
    private var _treeHeight : Int = 0
    private var _workingNode : BTNode? = nil
    
    var rootNode : BTNode? {
        get{
            return _rootNode
        }
        set {
            if _rootNode == nil {_rootNode = newValue}
        }
    }
    
    var treeHeight : Int {
        return _treeHeight
    }
    
    func setLeftNode(_ leftNode : BTNode, parentNode : BTNode) {
        parentNode.leftChildNode = leftNode
        leftNode.parentNode = parentNode
        _treeHeight += 1
    }

    func setRightNode(_ rightNode : BTNode, parentNode : BTNode) {
        parentNode.rightChildNode = rightNode
        rightNode.parentNode = parentNode
        _treeHeight += 1
    }
    
    func setRootNode(_ node : BTNode){
        rootNode = node
        rootNode?.parentNode = nil
        rootNode?.leftChildNode = nil
        rootNode?.rightChildNode = nil
        _treeHeight += 1
        
    }
    
    
    
    
    func insertNoder(inputNode : BTNode, currentWorkingNode : BTNode? = nil) {
        
        // Empty Tree -> Insert as Root.
        if _treeHeight == 0 && rootNode == nil {
            setRootNode(inputNode)
            return
        }
        
        let tempWorkingNode = currentWorkingNode ?? _rootNode!
        
        // If inputNode < CWC.value. Shift Left
        if inputNode < tempWorkingNode {
            if tempWorkingNode.hasLeftNode {
                //Keep looking further to the left of current node.
                return insertNoder(inputNode: inputNode, currentWorkingNode: tempWorkingNode.leftChildNode!)
            }
            
            // If we have a node with no left leaf. Insert here.
            setLeftNode(inputNode, parentNode: tempWorkingNode)
            return
        }
        
        // If inputNode > CWC.value. Shift Right
        if inputNode > tempWorkingNode {
            if tempWorkingNode.hasRightNode {
                // Keep looking further to the right of current node.
                return insertNoder(inputNode: inputNode, currentWorkingNode: tempWorkingNode.rightChildNode!)
            }
            
            // If we have a node with no right leaf. Insert here.
            setRightNode(inputNode, parentNode: tempWorkingNode)
            return
        }
        
        return
    }
    
    
    
    

    // Finding a node in the Tree :
    func  search(_ value : Int) -> BTNode?  {
        
        if _treeHeight == 0 {return nil}
        return checkNode(node: _rootNode!, value)
    }
    
    private func checkNode(node : BTNode, _ valueToFind : Int) -> BTNode?{
        
        if node.value == valueToFind {return node}
        
        if node.leftChildNode?.value == valueToFind {
            print("\n\n ================= \n Found It Left \n \(node.leftChildNode!)")
            return node.leftChildNode
        }
        if node.rightChildNode?.value == valueToFind {
            print("\n\n ================= \n Found It Right \n \(node.rightChildNode!)")
            return node.rightChildNode
        }
        
        if (node.leftChildNode?.value)! < valueToFind {
            if let theRightNode = node.rightChildNode{
                return checkNode(node: theRightNode,valueToFind)
            }
            print("Did not find the node you are looking for... Right")
            return nil
        }
        
        if (node.leftChildNode?.value)! > valueToFind {
            print("Moving Left...")
            if let theLeftNode = node.leftChildNode{
                return checkNode(node: theLeftNode,valueToFind)
            }
            print("Did not find the node you are looking for... Left")
            return nil
        }
        
        print("Its bad.. WE dont have fallen through.")
        return nil
    }
    
    
    
    func traverseTree(traversalType : BTreeTraverseType = BTreeTraverseType.PreOrder){
        
        switch traversalType {
        case .PreOrder:
            print("Traversing the tree.. Pre_Order....")
        default:
            print("Not yet Implemented this Traversal")
            break
        }
    }
    
    func preOrderTraverse() {
        
    }
    
    func printTreeProperties(){
        
        print("\n\nHeight : \(_treeHeight) -> \n\(_rootNode?.description ?? "NO Root Node")\n   -> RootNode : \(_rootNode?.value ?? -1) RootNode.lefNote : \(_rootNode?.leftChildNode?.value ?? -1)  RootNode.rightNode : \(_rootNode?.rightChildNode?.value ?? -1)")
    }
}

