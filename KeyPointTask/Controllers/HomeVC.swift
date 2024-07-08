//
//  HomeVC.swift
//  KeyPointTask
//
//  Created by Jagadeesh on 05/07/24.
//

import UIKit

class HomeVC: UIViewController {
    
  var BannerData:[Datum] = []
    var YoutubeData:[YouTubeModel] = []
    var list = ["LogOut"]
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.tag = 2
        tbView.register(UINib(nibName: "BannerCell", bundle: nil), forCellReuseIdentifier: "BannerCell")
        tbView.register(UINib(nibName: "YouTubeCell", bundle: nil), forCellReuseIdentifier: "YouTubeCell")
        tbView.delegate = self
        tbView.dataSource = self
        print("API Data \(BannerData)")
        self.BannerAPICalling()
        self.YoutubeAPICalling()
    }
   
    @IBAction func listBtn(_ sender: Any) {
        self.SideMenuView()
    }
    
    @IBAction func segmentList(_ sender: Any) {
        tbView.reloadData()
    }

}

//MARK: TableView delegate and Datasources
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = Int()
        
        switch tableView.tag {
        case 1:
            rowCount = list.count
        case 2:
            switch segmentControl.selectedSegmentIndex {
            case 0:
                rowCount = BannerData.count
            case 1:
                rowCount = YoutubeData.count
                
            default:
                break
            }
            rowCount = BannerData.count
        default:
            break
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    var cell = UITableViewCell()
        
        switch tableView.tag {
        case 1:
           let tbCells = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
            tbCells.titleLabel.text = list[indexPath.row]
            tbCells.selectionStyle = .none
            cell = tbCells
        case 2:
            switch segmentControl.selectedSegmentIndex {
            case 0:
                
                let bannerCell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as! BannerCell
                let imageURLString = BannerData[indexPath.row].imageDesktop
                if let imageURL = URL(string: imageURLString) {
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: imageURL) {
                            DispatchQueue.main.async {
                                if let image = UIImage(data: imageData) {
                                    bannerCell.bannerImage.image = image
                                } else {
                                    print("Error: Could not create image from data")
                                }
                            }
                        } else {
                            print("Error: Could not load data from URL")
                        }
                    }
                } else {
                    print("Error: Invalid URL string")
                }

                bannerCell.labelTitlt.text = BannerData[indexPath.row].title
                bannerCell.selectionStyle = .none
                cell = bannerCell
            case 1:
                let youtubeCell = tableView.dequeueReusableCell(withIdentifier: "YouTubeCell", for: indexPath) as! YouTubeCell
                youtubeCell.titleLabel.text = YoutubeData[indexPath.row].title
                youtubeCell.descpLabel.text = YoutubeData[indexPath.row].description
                let imageURLString = YoutubeData[indexPath.row].thumbnailURL
                if let imageURL = URL(string: imageURLString) {
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: imageURL) {
                            DispatchQueue.main.async {
                                if let image = UIImage(data: imageData) {
                                    youtubeCell.youtubeImage.image = image
                                } else {
                                    print("Error: Could not create image from data")
                                }
                            }
                        } else {
                            print("Error: Could not load data from URL")
                        }
                    }
                } else {
                    print("Error: Invalid URL string")
                }
                youtubeCell.selectionStyle = .none
                cell = youtubeCell
            default:
                break
            }
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView.tag {
        case 1:
            logoutPopup()
            
        case 2:
            switch segmentControl.selectedSegmentIndex {
            case 1 :
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let vedioVC = storyboard.instantiateViewController(withIdentifier: "VedioVC") as? VedioVC {
                    vedioVC.vedioplayer = YoutubeData
                    let navController = UINavigationController(rootViewController: vedioVC)
                    self.present(navController, animated: true, completion: nil)
                }
            default:
                break
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat()
        switch tableView.tag {
        case 1:
            height = 30
        case 2:
            switch segmentControl.selectedSegmentIndex {
            case 0:
                height = 195
            case 1:
                height = 415
            default:
                break
            }
        default:
            break
        }
        return height
    }
}

//MARK: extension Sidemenu popup

extension HomeVC {
    func DissmissSideMenu() {
        if let bgv = view.viewWithTag(112233) {
            bgv.removeFromSuperview()
        }
    }
    
    func SideMenuView() {
        var heigth = Int()
        if UIScreen.main.bounds.height > 812 {
            heigth = 60
        }else {
            heigth = 30
        }
    let Mainview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        Mainview.backgroundColor = UIColor(white: 0.8, alpha: 0.4)
        Mainview.tag = 112233
        let SideMenuview = UIView(frame: CGRect(x:0 , y:0, width: Mainview.frame.width / 2 + 30 , height: Mainview.frame.height))
        SideMenuview.backgroundColor = UIColor.white
        
        let cancelBtn = UIButton(frame: CGRect(x: Int(SideMenuview.frame.width) - 30, y: heigth, width: 24, height: 24))
        cancelBtn.setImage(UIImage(named: "CancelImage"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(GotocancelSideView), for: .touchUpInside)
       
        var SideMenutbview = UITableView(frame: CGRect(x: 0, y: CGFloat(heigth + 26), width: SideMenuview.frame.width, height: SideMenuview.frame.height))
        SideMenutbview.tag = 1
        SideMenutbview.delegate = self
        SideMenutbview.dataSource = self
        SideMenutbview.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "SideMenuCell")
        
        SideMenuview.addSubview(SideMenutbview)
        SideMenuview.addSubview(cancelBtn)
        Mainview.addSubview(SideMenuview)
        self.view.addSubview(Mainview)
    }
    @objc func GotocancelSideView() {
        self.DissmissSideMenu()
    }
    
 // Logout popUp
    func logoutPopup() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure your App is logout", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancle", style: .default)
        let actionSheet  = UIAlertAction(title: "Ok", style: .default) { alert in
            print("Your App is Logut")
            self.DissmissSideMenu()
        }
        alert.addAction(action)
        alert.addAction(actionSheet)
        self.present(alert, animated: true)
    }
}

//MARK: Extension Viewcontroller

extension HomeVC {
    func BannerAPICalling() {
        HttpClient.shared.getDataFromURL(url: urls.Banner_Url) { data, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    print("Error: Data is nil")
                    return
                    }
                do {
                    let json = JSONDecoder()
                    let jsonData = try! json.decode(BannerModel.self, from: data)
                    self.BannerData = jsonData.data
                    print(self.BannerData)
                    self.tbView.reloadData()
                }catch {
                    print("Error \(error)")
                }
            }
        }
        
    }
    func YoutubeAPICalling() {
        HttpClient.shared.getDataFromURL(url: urls.Youtube_Url) { data, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    print("Error: Data is nil")
                    return
                }
                do {
                    let json = JSONDecoder()
                    self.YoutubeData = try! json.decode(Welcome.self, from: data)
                    print("This is my you data\(self.YoutubeData as Any)")
                   self.tbView.reloadData()
                }catch {
                    print("Error \(error)")
                }
            }
        }
    }
}
