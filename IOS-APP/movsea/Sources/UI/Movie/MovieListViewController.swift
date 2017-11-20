//
//  MovieListViewController.swift
//  movsea
//
//  Created by Movsea Team on 4/27/16.
//  Copyright © 2017 Movsea Team.
//

import UIKit

class MovieListViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var collectionData = Movie.getAllFindings()
    let itemSpacing: CGFloat = 10
    let elementWidth = UIScreen.main.bounds.size.width / 2 - 15;
    var lpgr:UILongPressGestureRecognizer?

    override func loadView() {
        super.loadView()
        lpgr = UILongPressGestureRecognizer(target: self, action: #selector(MovieListViewController.handleLongPress))

        collectionView.backgroundColor = UIColor.clear
        collectionView.addGestureRecognizer(lpgr!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let typeInfo = R.segue.movieListViewController.showMovieDetails(segue: segue) {
            guard let movieDetailVC = typeInfo.destination.viewControllers.first as? MovieDetailsViewController else { return }
            guard let sender = sender as? MovieListCollectionCell else { return }
                movieDetailVC.movie = sender.movie
        }
    }
    
    @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
        let point = gesture.location(in: self.collectionView)
        if self.collectionView.indexPathForItem(at: point) != nil {
            setEditingState(isEditing: true)
        }
    }
    
    @objc func deleteCell(sender: UIButton) {
        let point = self.collectionView.convert(sender.center, from: sender.superview)
        guard let indexPath = self.collectionView.indexPathForItem(at: point) else { return }
        
        let movie = collectionData[indexPath.item] as Movie
        collectionData.remove(at: indexPath.item)
        movie.deleteObject()
        
        self.collectionView.deleteItems(at: [indexPath])
    }
    
    func setEditingState(isEditing: Bool) {
        self.setEditing(isEditing, animated: true)
        self.lpgr?.isEnabled = !isEditing
        self.collectionView.reloadData()
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = collectionData[(indexPath as NSIndexPath).item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionCell", for: indexPath) as! MovieListCollectionCell
        cell.prepareCell(movie)
        
        cell.deleteButton.addTarget(self, action: #selector(MovieListViewController.deleteCell(sender:)), for: .touchUpInside)
        cell.deleteButton.isHidden = !self.isEditing
        
        return cell
    }
    
}

extension MovieListViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: elementWidth, height: elementWidth * 1.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.isEditing {
            setEditingState(isEditing: false)
        } else {
            let cell = collectionView.cellForItem(at: indexPath)
            self.performSegue(withIdentifier: R.segue.movieListViewController.showMovieDetails, sender: cell)
        }
    }
    
}
