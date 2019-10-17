//
//  ARObjectViewController.swift
//  MessagesExtension
//
//  Created by Tuncay Cansız on 16.10.2019.
//  Copyright © 2019 Tuncay Cansız. All rights reserved.
//

import Foundation
import UIKit
import Messages

//MARK: - Protocols
/// A delegate protocol for the `ARObjectViewController` class.
protocol ARObjectViewControllerDelegate: class {
  func sendARObject(fileName: String, objectImageName: String)
}


class ARObjectViewController: UIViewController {
  
  //MARK: - Variables
  weak var delegate: ARObjectViewControllerDelegate?
  
  let arObjectArray = ["toy_biplane","toy_drummer","toy_car","toy_robot_vintage","fender_stratocaster","tv_retro","gramophone","trowel","wateringcan","wheelbarrow","chair_swan","flower_tulip","cup_saucer_set","pot_plant","teapot"]
  
  var arObjectImageArray = [UIImage]()
  
  @IBOutlet weak var arObjectCollectionView: UICollectionView!
  
  var collectionViewFlowLayout: UICollectionViewFlowLayout!
  let arObjectCellIdentifier = "ARObjectCollectionViewCell"
  
  //MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for object in arObjectArray {
      if let objectsImage = UIImage(named: "\(object)") {
        arObjectImageArray.append(objectsImage)
      }
    }
    
    print("Item count in ARObjectImageArray: ",arObjectImageArray.count)
  
    setupCollectionView()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    setupCollectionViewItemSize()
  }
  
  private func setupCollectionView() {
    arObjectCollectionView.delegate = self
    arObjectCollectionView.dataSource = self
    
    let nib = UINib(nibName: "ARObjectCollectionViewCell", bundle: nil)
    arObjectCollectionView.register(nib, forCellWithReuseIdentifier: arObjectCellIdentifier)
  }
  
  private func setupCollectionViewItemSize() {
    if collectionViewFlowLayout == nil {
      print("layout nill")
      let numberOfItemPerRow: CGFloat = 3
      let lineSpacing: CGFloat = 5
      let interItemSpacing: CGFloat = 5
      let sectionInsetSpacing: CGFloat = 10
      let screenWidth = UIScreen.main.bounds.size.width
      
      let width = (screenWidth - ((numberOfItemPerRow - 1) * interItemSpacing) - (sectionInsetSpacing * 2)) / numberOfItemPerRow
      
      print("width: ", width)
      print("ARObjectCollectionView Frame width:", arObjectCollectionView.frame.width)
      let height = width
      
      collectionViewFlowLayout = UICollectionViewFlowLayout()
      
      collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
      collectionViewFlowLayout.sectionInset = UIEdgeInsets.init(top: sectionInsetSpacing, left: sectionInsetSpacing, bottom: sectionInsetSpacing, right: sectionInsetSpacing)
      collectionViewFlowLayout.scrollDirection = .vertical
      collectionViewFlowLayout.minimumLineSpacing = lineSpacing
      collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
      print("collectionViewFlowLayout.minimumInteritemSpacing: ",collectionViewFlowLayout.minimumInteritemSpacing)
      
      arObjectCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
    }
  }
  
  
}

//MARK: - Extensions

extension ARObjectViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arObjectImageArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = arObjectCollectionView.dequeueReusableCell(withReuseIdentifier: arObjectCellIdentifier, for: indexPath) as! ARObjectCollectionViewCell
    
    cell.arObjectImageView.image = arObjectImageArray[indexPath.item]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("didSelectItemName: \(arObjectArray[indexPath.item])")
  
    let objectImageName = "\(arObjectArray[indexPath.item])"
    let objectName = "\(arObjectArray[indexPath.item])"
  
    delegate?.sendARObject(fileName: "\(objectName)", objectImageName: "\(objectImageName)")
  }
}



