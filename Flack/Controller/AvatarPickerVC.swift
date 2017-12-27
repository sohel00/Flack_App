//
//  AvatarPickerVC.swift
//  Flack
//
//  Created by Sohel Dhengre on 20/12/17.
//  Copyright © 2017 Sohel Dengre. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionview: UICollectionView!
    
    //variables
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionview.dataSource = self
        collectionview.delegate = self
        
    }

    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentControlPressed(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0{
            avatarType = .dark
        } else {
            avatarType = .light
        }
        collectionview.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 27
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarcell", for: indexPath) as? AvatarCell{
          cell.configureCell(index: indexPath.item, type: avatarType)
        return cell
        }
        return AvatarCell()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var NumberOfColumns: CGFloat = 3
        if UIScreen.main.bounds.width > 320{
            NumberOfColumns = 4
        }
            let padding: CGFloat = 40
            let spaceBetweenCells: CGFloat = 10
            
           let cellDimention = ((collectionview.bounds.width - padding) - (NumberOfColumns - 1) * spaceBetweenCells) / NumberOfColumns
            
        return CGSize(width: cellDimention, height: cellDimention)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark{
            UserDataService.instance.setAvatarName(avatarname: "dark\(indexPath.item)")
        } else if avatarType == .light{
            UserDataService.instance.setAvatarName(avatarname: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
