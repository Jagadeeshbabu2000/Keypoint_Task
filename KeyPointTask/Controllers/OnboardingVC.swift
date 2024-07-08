//
//  ViewController.swift
//  KeyPointTask
//
//  Created by Jagadeesh on 05/07/24.
//

import UIKit

class OnboardingVC: UIViewController {
    
    var OnboardingImage = ["FirstImage","SecondImage","ThirdImage"]
    
    @IBOutlet weak var onboardingCollectionview: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pagecontroller: UIPageControl!
    
    var pageCount = 0 {
        didSet {
            if pageCount == OnboardingImage.count - 1 {
                self.nextBtn.setTitle("Go To Dashboard", for: .normal)
            }else{
                self.nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingCollectionview.delegate = self
        onboardingCollectionview.dataSource = self
        self.nextBtn.layer.cornerRadius = 10
        self.nextBtn.addTarget(self, action: #selector(OnboardingScreenChange), for: .touchUpInside)
       
    }

    override func viewWillAppear(_ animated: Bool) {
        if Core.shared.isNewUser(){
            Core.shared.notNewUser()
                print("new user")
            }
            else{
                print("existing user")
                let mainAppViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let sceneDelegate = windowScene.delegate as? SceneDelegate,
                    let window = sceneDelegate.window{
                    window.rootViewController = mainAppViewController
                    UIView.transition(with: window,
                                      duration: 0.25,
                                      options: .transitionCrossDissolve,
                                      animations: nil,
                                      completion: nil)
                }
            }
            
        }
    
    @objc func OnboardingScreenChange() {
        if pageCount == OnboardingImage.count - 1 {
            UserDefaults.standard.set(true, forKey: "OnboardingVC")
                        UserDefaults.standard.synchronize()
            let vc = storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            pageCount += 1
            let index = IndexPath(item: pageCount, section: 0)
            onboardingCollectionview.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
}

//MARK: Collectionview Delegate and DataSource

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OnboardingImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        cell.onboardingImage.image = UIImage(named: OnboardingImage[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: onboardingCollectionview.frame.width, height: onboardingCollectionview.frame.width)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        pageCount = Int(scrollView.contentOffset.x / width)
        pagecontroller.currentPage = pageCount
        
    }
    
}
