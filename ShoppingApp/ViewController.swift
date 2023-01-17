//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Aniket Patil on 17/01/23.
//

import UIKit
import EMTNeumorphicView
import SDWebImage
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var mainView: EMTNeumorphicView!
    @IBOutlet weak var backView: EMTNeumorphicView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var shareView: EMTNeumorphicView!
    @IBOutlet weak var itemImgCV: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var likeView: EMTNeumorphicView!
    @IBOutlet weak var DecsLbl: UILabel!
    @IBOutlet weak var attLbl: UILabel!
    @IBOutlet weak var attName: UILabel!
    @IBOutlet weak var attCV: UICollectionView!
    @IBOutlet weak var addToBagBtn: EMTNeumorphicButton!
    @IBOutlet weak var skuLbl: UILabel!
    
    var dataModel: DataModel? = nil
    var images: [String] = [] {
        didSet{
            DispatchQueue.main.async {
                self.pageControl.currentPage = 0
                self.pageControl.numberOfPages = self.images.count
                self.itemImgCV.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API()
        setNeumorphicEffect()
    }
    private func initViews(){
        itemImgCV.delegate = self
        itemImgCV.dataSource = self
        itemImgCV.register(UINib(nibName: "ImagesCVC", bundle: nil), forCellWithReuseIdentifier: "ImagesCVC")
        attCV.delegate = self
        attCV.dataSource = self
        attCV.register(UINib(nibName: "ColorsCVC", bundle: nil), forCellWithReuseIdentifier: "ColorsCVC")
    }
    private func API(){
        let request = "https://www.minisokw.com/rest/V3/inosolnapiV1/productdetails/947/0"
        AF.request(request, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result{
            case .success(_):
                if let data = response.data {
                    print("APIDATA---",response.result)
                    if let apiData = try? JSONDecoder().decode(DataModel.self, from: data) {
                        self.dataModel = apiData
                        self.images.append(contentsOf: apiData.data.images ?? [])
                        self.itemTitle.text = apiData.data.name ?? ""
                        self.itemPrice.text = "K D \(apiData.data.price ?? "")"
                        self.DecsLbl.text = (apiData.data.description ?? "")+(apiData.data.howToUse ?? "")
                        self.skuLbl.text = apiData.data.sku ?? ""
                        self.attLbl.text = "Select "+(apiData.data.configurableOption.first?.attributeLabel ?? "")
                        DispatchQueue.main.async {
                            self.attCV.reloadData()
                        }
                        print(apiData)
                    } else {
                        print("Invalid Response")
                    }
                }
            case .failure(_):
                print("FAILURE: \(response.error?.underlyingError?.localizedDescription ?? "")\n ")
            }
        }
        
        
        
//        let request = URLRequest(url: URL(string: "https://www.minisokw.com/rest/V3/inosolnapiV1/productdetails/947/0?lang=e")!)
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//            if let data = data {
//                do {
//                    print("APIDATA---",data)
//                    if let apiData = try? JSONDecoder().decode(DataModel.self, from: data) {
//                        self.dataModel = apiData
//                        self.images.append(contentsOf: apiData.data.images ?? [])
//                        self.itemTitle.text = apiData.data.name ?? ""
//                        self.itemPrice.text = "K D \(apiData.data.price ?? "")"
//                        self.DecsLbl.text = (apiData.data.description ?? "")+(apiData.data.howToUse ?? "")
//                        self.skuLbl.text = apiData.data.sku ?? ""
//                        self.attLbl.text = "Select "+(apiData.data.configurableOption.first?.attributeLabel ?? "")
//                        DispatchQueue.main.async {
//                            self.attCV.reloadData()
//                        }
//                        print(apiData)
//                    } else {
//                        print("Invalid Response")
//                    }
//                } catch {
//                    print(error)
//                }
//            }
//        }.resume()
    }
    private func setNeumorphicEffect(){
        mainView.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        mainView.neumorphicLayer?.cornerRadius = 25
        mainView.neumorphicLayer?.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        mainView.neumorphicLayer?.shadowOffset = CGSize(width: 3, height: 3)
        mainView.neumorphicLayer?.shadowOffset = CGSize(width: -3, height: -2)
        mainView.neumorphicLayer?.shadowRadius = 6
        mainView.neumorphicLayer?.cornerType = .bottomRow
        mainView.neumorphicLayer?.darkShadowOpacity = 0.3
        mainView.neumorphicLayer?.shadowOpacity = 1
        mainView.neumorphicLayer?.depthType = .convex
        
        backView.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        backView.neumorphicLayer?.cornerRadius = 10
        backView.neumorphicLayer?.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        backView.neumorphicLayer?.shadowOffset = CGSize(width: 3, height: 3)
        backView.neumorphicLayer?.shadowOffset = CGSize(width: -3, height: -2)
        backView.neumorphicLayer?.shadowRadius = 6
        backView.neumorphicLayer?.cornerType = .all
        backView.neumorphicLayer?.darkShadowOpacity = 0.3
        backView.neumorphicLayer?.shadowOpacity = 1
        backView.neumorphicLayer?.depthType = .concave
        
        shareView.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        shareView.neumorphicLayer?.cornerRadius = 10
        shareView.neumorphicLayer?.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        shareView.neumorphicLayer?.shadowOffset = CGSize(width: 3, height: 3)
        shareView.neumorphicLayer?.shadowOffset = CGSize(width: -3, height: -2)
        shareView.neumorphicLayer?.shadowRadius = 6
        shareView.neumorphicLayer?.cornerType = .all
        shareView.neumorphicLayer?.darkShadowOpacity = 0.3
        shareView.neumorphicLayer?.shadowOpacity = 1
        shareView.neumorphicLayer?.depthType = .convex
        
        likeView.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        likeView.neumorphicLayer?.cornerRadius = 10
        likeView.neumorphicLayer?.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        likeView.neumorphicLayer?.shadowOffset = CGSize(width: 3, height: 3)
        likeView.neumorphicLayer?.shadowOffset = CGSize(width: -3, height: -2)
        likeView.neumorphicLayer?.shadowRadius = 6
        likeView.neumorphicLayer?.cornerType = .all
        likeView.neumorphicLayer?.darkShadowOpacity = 0.3
        likeView.neumorphicLayer?.shadowOpacity = 1
        likeView.neumorphicLayer?.depthType = .convex
        
        addToBagBtn.neumorphicLayer?.elementBackgroundColor = UIColor.red.cgColor
        addToBagBtn.neumorphicLayer?.cornerRadius = 10
        addToBagBtn.neumorphicLayer?.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        addToBagBtn.neumorphicLayer?.shadowOffset = CGSize(width: 3, height: 3)
        addToBagBtn.neumorphicLayer?.shadowOffset = CGSize(width: -3, height: -2)
        addToBagBtn.neumorphicLayer?.shadowRadius = 6
        addToBagBtn.neumorphicLayer?.cornerType = .all
        addToBagBtn.neumorphicLayer?.darkShadowOpacity = 0.3
        addToBagBtn.neumorphicLayer?.shadowOpacity = 1
        addToBagBtn.neumorphicLayer?.depthType = .convex
    }
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == itemImgCV{
            return self.images.count
        } else{
            return (dataModel?.data.configurableOption.first?.attributes ?? []).count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == itemImgCV{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCVC", for: indexPath) as? ImagesCVC{
                let data = images[indexPath.row]
                cell.Imgs.sd_setImage(with: URL(string: data), completed: nil)
                return cell
            }
        } else{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorsCVC", for: indexPath) as? ColorsCVC{
                let data = dataModel?.data.configurableOption.first?.attributes[indexPath.row]
                cell.colorView.backgroundColor = UIColor(hexaRGB: data?.hexCode ?? "")
                return cell
            }
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        images.removeAll()
        if collectionView == attCV{
            let data = dataModel?.data.configurableOption.first?.attributes[indexPath.row]
            self.images.append(contentsOf: data?.images ?? [])
            self.attName.text = data?.value ?? ""
            self.itemPrice.text = "K D \(data?.price ?? "")"
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == itemImgCV{
            self.pageControl.currentPage = indexPath.row
        }
    }
}
