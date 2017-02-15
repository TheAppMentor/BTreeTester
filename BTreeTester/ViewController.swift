//
//  ViewController.swift
//  BTreeTester
//
//  Created by Moorthy, Prashanth on 2/13/17.
//  Copyright © 2017 Moorthy, Prashanth. All rights reserved.
//

import UIKit

struct Hospital {
    
    let provider_id : String
    let hospital_name : String
    let address : String
    let city : String
    let state : String
    let zip_code : String
    let county_name : String
    let hospital_type : String
    
    let emergency_services : Bool
    let phone_number : String
}


class ViewController: UIViewController {
    
    typealias JSONObj = [String:AnyObject?]
    
    func extractJSONFromFile() -> [String:AnyObject?] {

        let startTime = NSDate()
        if let fileLocation = Bundle.main.url(forResource: "HospitalData", withExtension: "json"){
            do {
                let theD = try Data.init(contentsOf: fileLocation, options: Data.ReadingOptions.mappedIfSafe)
                
                if let theReturnD = try JSONSerialization.jsonObject(with: theD, options: .mutableLeaves) as? [String:AnyObject?]{
                    print("Inside Function : Time to Run.. \(-startTime.timeIntervalSinceNow)")
                    return theReturnD
                }
            } catch  {
                print("We have an error extracting the file... ")
            }
        }
        return  [String:AnyObject?]()
    }
    

    func buildDictionary(theFullD : JSONObj) -> [Hospital]{
        
        var returnArray = [Hospital]()
        
        if let theData = theFullD["data"] as? [AnyObject]{
            for eachItem in theData{
                
                guard let provider_id = eachItem[8] as? String else {continue}
                guard let hospital_name = eachItem[9] as? String else {continue}
                guard let address = eachItem[10] as? String else {continue}
                guard let city = eachItem[11] as? String else {continue}
                guard let state = eachItem[12] as? String else {continue}
                guard let zip_code = eachItem[13] as? String else {continue}
                guard let county_name = eachItem[14] as? String else {continue}
                guard let hospital_type = eachItem[16] as? String else {continue}
                guard let emergency_services = eachItem[18] as? Bool else {continue}
                guard let phone_number = (eachItem[15] as? [AnyObject?])?[0] as? String  else {continue}
                
                var tempHospital = Hospital(provider_id: provider_id,
                                            hospital_name: hospital_name,
                                            address: address,
                                            city: city,
                                            state: state,
                                            zip_code: zip_code,
                                            county_name: county_name,
                                            hospital_type: hospital_type,
                                            emergency_services: emergency_services,
                                            phone_number: phone_number)
                
                returnArray.append(tempHospital)
            }
        }
        return returnArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        let theNodeView = NodeView(color: UIColor.red, displayValue: "H")
        self.view.addSubview(theNodeView)
        
        theNodeView.center = self.view.center
    }

    @IBAction func constructTree(_ sender: UIButton) {
        let backgroundQ = DispatchQueue.global(qos: .utility)
        
        let startTime = NSDate()
        backgroundQ.async {
            let theFinalD = self.extractJSONFromFile()
            let theDataD = self.buildDictionary(theFullD: theFinalD)
            print("Outside Function : Time to Run.. \(-startTime.timeIntervalSinceNow)")
        }
        
        
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
        
        print("Searching....10 \(theTree.find(10))")
        print("Delete Status ... \(theTree.delete(10))")
        print("Searching....10 \(theTree.find(10))")
        
        let theTreeViewer = BTViewer()
        theTreeViewer.displayTree(theTree)
        
        print("result \(theTree.traverseTree(traversalType: .PreOrder))")
        print("result \(theTree.traverseTree(traversalType: .PostOrder))")
        print("result \(theTree.traverseTree(traversalType: .InOrder))")
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
    
    //TODO: rename this to key.. and we should add a value guy also.
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
    
    var value : Int {
        get{
        return theValue
        }
        
        set {
            theValue = newValue
        }
}
    
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

    var hasLeftAndRightNodes : Bool{
        return hasLeaves && hasRightNode
    }
    
    var hasOnlyOneChildNode : Bool{
        if hasRightNode && hasLeftNode == false {return true}
        if hasLeftNode && hasRightNode == false {return true}
        
        return false
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
    
    
    
    //MARK: Searching
    
    func find(_ value : Int) -> BTNode? {
        if _treeHeight == 0 {return nil}
        
        return lookUp(value)
    }
    
    
    func lookUp(_ value : Int, startingNode : BTNode? = nil) -> BTNode? {
        
        let tempWorkingNode = startingNode ?? _rootNode!
        
        if tempWorkingNode.value == value{return tempWorkingNode}
        
        if tempWorkingNode.value < value {
            if tempWorkingNode.hasRightNode{
                return lookUp(value, startingNode: tempWorkingNode.rightChildNode)
            }
            return nil
        }
        
        if tempWorkingNode.value > value {
            if tempWorkingNode.hasLeftNode{
                return lookUp(value, startingNode: tempWorkingNode.leftChildNode)
            }
            return nil
        }
        
        return nil
        
    }
    
    
    
    
    

    // Finding a node in the Tree :
    func  search(_ value : Int) -> BTNode? {
        
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
    
    
    //MARK: Tree Traversal
    
    func traverseTree(traversalType : BTreeTraverseType = BTreeTraverseType.PreOrder) -> [BTNode]{
        
        switch traversalType {
        case .PreOrder:
            print("\n\n\n =====================================")
            print("Traversing the tree.. Pre_Order....")
            return preOrderTraverse()
            print("\n\n\n =====================================")

        case .PostOrder:
            print("\n\n\n =====================================")
            print("Traversing the tree.. Post_Order....")
            return postOrderTraverse()
            print("\n\n\n =====================================")

        case .InOrder:
            print("\n\n\n =====================================")
            print("Traversing the tree.. In_Order....")
            return InOrderTraverse()
            print("\n\n\n =====================================")
        }
    }
    
    
    func preOrderTraverse(startNode : BTNode? = nil, returnArray: [BTNode]? = nil) -> [BTNode] {
        let currentWorkingNode = startNode ?? _rootNode!
        var tempNodeArray : [BTNode] = returnArray ?? [BTNode]()
        
        //print("Value...   \(currentWorkingNode.value)")
        tempNodeArray.append(currentWorkingNode)
        
        if currentWorkingNode.hasLeftNode {
            return preOrderTraverse(startNode: currentWorkingNode.leftChildNode!, returnArray: tempNodeArray)
        }

        if currentWorkingNode.hasRightNode{
            return preOrderTraverse(startNode: currentWorkingNode.rightChildNode!, returnArray: tempNodeArray)
        }
        return tempNodeArray
    }

    
    func postOrderTraverse(startNode : BTNode? = nil, returnArray: [BTNode]? = nil) -> [BTNode] {
        let currentWorkingNode = startNode ?? _rootNode!
        var tempNodeArray : [BTNode] = returnArray ?? [BTNode]()

        if currentWorkingNode.hasLeftNode {
            return postOrderTraverse(startNode: currentWorkingNode.leftChildNode!, returnArray: tempNodeArray)
        }
        
        if currentWorkingNode.hasRightNode{
            return postOrderTraverse(startNode: currentWorkingNode.rightChildNode!, returnArray: tempNodeArray)
        }
        
        //print("Value...   \(currentWorkingNode.value)")
        tempNodeArray.append(currentWorkingNode)
        return tempNodeArray

    }
    
    func InOrderTraverse(startNode : BTNode? = nil, returnArray: [BTNode]? = nil) -> [BTNode] {
        let currentWorkingNode = startNode ?? _rootNode!
        var tempNodeArray : [BTNode] = returnArray ?? [BTNode]()
        
        if currentWorkingNode.hasLeftNode {
            return InOrderTraverse(startNode: currentWorkingNode.leftChildNode!, returnArray: tempNodeArray)
        }
        print("Value...   \(currentWorkingNode.value)")
        tempNodeArray.append(currentWorkingNode)
        
        if currentWorkingNode.hasRightNode{
            return InOrderTraverse(startNode: currentWorkingNode.rightChildNode!, returnArray: tempNodeArray)
        }
        return tempNodeArray

    }
    
    
    func delete(_ value : Int) -> Bool {
        
        // Find the Node
        if let nodeToDelete = find(value){
            // Scenario 1 : Node to be deleted has no child nodes.
            if nodeToDelete.hasLeaves == false {
                cleanUpNode(nodeToDelete)
                return true
            }
            
            // Scenario 2 : Node to be deleted has ONLY one child node
            if nodeToDelete.hasOnlyOneChildNode{
                var tempNode = nodeToDelete.leftChildNode ?? nodeToDelete.rightChildNode
                
                tempNode?.parentNode = nodeToDelete.parentNode
                cleanUpNode(nodeToDelete)
                return true
            }
            
            //TODO: This needs a clean up.
            // Scenario 3.
            if nodeToDelete.hasLeftAndRightNodes {
                // Find the Min value of the right node.
                let theReplacementNode = minValue(startingNode: nodeToDelete.rightChildNode!)
                
                // Only the Value is being replaced.. not the node.. !!
                nodeToDelete.parentNode?.value = (theReplacementNode?.value)!
                cleanUpNode(theReplacementNode!)
            }
        }
        
        return false
    }
    
    func minValue(startingNode : BTNode) -> BTNode? {
        let theArray = preOrderTraverse(startNode: startingNode)
        return theArray.min()
    }

    func maxValue(startingNode : BTNode) -> BTNode? {
        let theArray = preOrderTraverse(startNode: startingNode)
        return theArray.max()
    }

    func  cleanUpNode(_ node : BTNode)  {
        node.parentNode = nil
        node.leftChildNode = nil
        node.rightChildNode = nil
    }
    

    func printTreeProperties(){
        
        print("\n\nHeight : \(_treeHeight) -> \n\(_rootNode?.description ?? "NO Root Node")\n   -> RootNode : \(_rootNode?.value ?? -1) RootNode.lefNote : \(_rootNode?.leftChildNode?.value ?? -1)  RootNode.rightNode : \(_rootNode?.rightChildNode?.value ?? -1)")
    }
}

