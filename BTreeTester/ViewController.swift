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
        theTree.insertNode(node: BTNode(8))
        theTree.insertNode(node: BTNode(3))
        theTree.insertNode(node: BTNode(1))
        theTree.insertNode(node: BTNode(6))
        theTree.insertNode(node: BTNode(4))
        theTree.insertNode(node: BTNode(7))
        theTree.insertNode(node: BTNode(10))
        theTree.insertNode(node: BTNode(14))
        theTree.insertNode(node: BTNode(13))
        
//        theTree.insertNode(node: BTNode(7))
//        theTree.insertNode(node: BTNode(12))
//        theTree.insertNode(node: BTNode(11))
//        theTree.insertNode(node: BTNode(3))
//        theTree.insertNode(node: BTNode(1))
//        theTree.insertNode(node: BTNode(2))
//        theTree.insertNode(node: BTNode(5))
//        theTree.insertNode(node: BTNode(10))
//        theTree.insertNode(node: BTNode(9))
//        
//        theTree.search(10)

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
    
    var rootNode : BTNode? {
        return _rootNode
    }
    
    var treeHeight : Int {
        return _treeHeight
    }
    
    func setLeftNode(parentNode : BTNode, leftNode : BTNode) {
        parentNode.leftChildNode = leftNode
        _treeHeight += 1
    }

    func setRightNode(parentNode : BTNode, rightNode : BTNode) {
        parentNode.rightChildNode = rightNode
        _treeHeight += 1
    }
    
    
    
    
    func insertNoder(inputNode : BTNode) {
        
        // Empty Tree -> Insert as Root.
        
        
        // Current Working Node ==> Has no Leaves.. Insert Left or right based on value.
        
        
        
        // Current Working Node (CWN) ==> Is < input Node
            // If CWN has no left node : Simply insert.
        
            // if CWN has left node :

        
        // Current Working Node (CWN) ==> Is > input Node
        // If CWN has no left node : Simply insert.
        
        // if CWN has left node :

        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    func insertNode(node : BTNode) -> Bool {
        
        // Empty Tree : Set node as root node.
        if _treeHeight == 0 {
            print("Empty Tree.. Setting Root Node  => Value \(node.value)")
            _rootNode = node
            node.leftChildNode = nil
            node.rightChildNode = nil
            node.parentNode = nil
            _treeHeight += 1
            return true
        }
        
        // If the new node does not qualify to be a root node.
        var currentWorkingNode = rootNode
        
        // If the current node has no leaves, compare value with the node and set either left or right node.
        if currentWorkingNode?.hasLeaves == false {
            if node.value < (currentWorkingNode?.value)!{
                setLeftNode(parentNode: currentWorkingNode!, leftNode: node)
            }else{
                setRightNode(parentNode: currentWorkingNode!, rightNode: node)
//                currentWorkingNode?.rightChildNode = node
            }
            node.parentNode = currentWorkingNode
            return true
        }
        
        repeat{
            
            if node.value <= currentWorkingNode!.value {
                // We are working with the left half of the tree.
                // Shift Left
                
                // If currrent node has no left node, simply set it.
                if currentWorkingNode?.hasLeftNode == false {
                    setLeftNode(parentNode: currentWorkingNode!, leftNode: node)
                    return true
                }
                
                if (currentWorkingNode?.leftChildNode?.value)! <= node.value{
                    // We have lower values.. keep looking further down the tree.
                    currentWorkingNode = currentWorkingNode?.leftChildNode!
                    continue
                } else {
                    if currentWorkingNode?.hasRightNode == true{
                        currentWorkingNode = currentWorkingNode?.rightChildNode!
                        continue
                    }else{
                        setRightNode(parentNode: currentWorkingNode!, rightNode: node)
                    }
                }
                
            } else {
                // We are working with the Right half of the tree.
                // Shift Right.
                
                if currentWorkingNode?.hasRightNode == false {
                    setRightNode(parentNode: currentWorkingNode!, rightNode: node)
                    return true
                }
                
                if currentWorkingNode?.hasLeftNode == true{
                    if (currentWorkingNode?.leftChildNode?.value)! <= node.value{
                        // We have lower values.. keep looking further down the tree.
                        currentWorkingNode = currentWorkingNode?.leftChildNode!
                        continue
                    }
                }
                
                else {
                    currentWorkingNode = currentWorkingNode?.rightChildNode!
                    continue
                }
                
            }
            
        }while true
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

