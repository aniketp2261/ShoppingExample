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
    
    private var dataModel: DataModel? = nil
    private var images: [String] = [] {
        didSet{
            DispatchQueue.main.async {
                self.pageControl.currentPage = 0
                self.pageControl.numberOfPages = self.images.count
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        API()
        initViews()
    }
    private func initViews(){
        setNeumorphicEffect()
        itemImgCV.delegate = self
        itemImgCV.dataSource = self
        itemImgCV.register(UINib(nibName: "ImagesCVC", bundle: nil), forCellWithReuseIdentifier: "ImagesCVC")
        attCV.delegate = self
        attCV.dataSource = self
        attCV.register(UINib(nibName: "ColorsCVC", bundle: nil), forCellWithReuseIdentifier: "ColorsCVC")
    }
    private func API(){
        let request = "https://www.minisokw.com/rest/V3/inosolnapiV1/productdetails/947/0?lang=e"
        AF.request(request, method: .get, parameters: nil).responseJSON { response in
            switch response.result{
            case .success(_):
                if let data = response.data {
                    if let parsedData = try? JSONDecoder().decode([DataModel].self, from: data) {
                        self.dataModel = parsedData.first
                        let data = parsedData[0]
                        self.images.append(contentsOf: data.data?.images ?? [])
                        self.itemTitle.text = data.data?.name ?? ""
                        self.itemPrice.text = "K D \(data.data?.price ?? "")"
                        self.DecsLbl.text = (data.data?.description ?? "")+"\n"+(data.data?.howToUse ?? "")
                        self.skuLbl.text = "SKU: \(data.data?.sku ?? "")"
                        self.attLbl.text = "Select \(data.data?.configurableOption?.first?.attributeCode ?? ""): "
                        self.attName.text = (data.data?.configurableOption?.first?.attributeLabel ?? "")
                        DispatchQueue.main.async {
                            self.attCV.reloadData()
                            self.itemImgCV.reloadData()
                        }
                    } else {
                        print("Invalid Response")
                    }
                }
            case .failure(let error):
                print(error)
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
//                    if let parsedData = try? JSONDecoder().decode([DataModel].self, from: data) {
//                        self.dataModel = parsedData.first
//                        let data = parsedData[0]
//                        self.images.append(contentsOf: data.data?.images ?? [])
//                        self.itemTitle.text = data.data?.name ?? ""
//                        self.itemPrice.text = "K D \(data.data?.price ?? "")"
//                        self.DecsLbl.text = (data.data?.description ?? "")+(data.data?.howToUse ?? "")
//                        self.skuLbl.text = "SKU: \(data.data?.sku ?? "")"
//                        self.attLbl.text = "Select "+(data.data?.configurableOption?.first?.attributeLabel ?? "")
//                        self.attName.text = (data.data?.configurableOption?.first?.attributeLabel ?? "")
//                        DispatchQueue.main.async {
//                            self.attCV.reloadData()
//                            self.itemImgCV.reloadData()
//                        }
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
        mainView.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9450980392, blue: 0.9568627451, alpha: 1)
        mainView.neumorphicLayer?.cornerRadius = 25
        mainView.neumorphicLayer?.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        mainView.neumorphicLayer?.shadowOffset = CGSize(width: 3, height: 3)
        mainView.neumorphicLayer?.shadowOffset = CGSize(width: -3, height: -2)
        mainView.neumorphicLayer?.shadowRadius = 6
        mainView.neumorphicLayer?.cornerType = .bottomRow
        mainView.neumorphicLayer?.darkShadowOpacity = 0.3
        mainView.neumorphicLayer?.shadowOpacity = 1
        mainView.neumorphicLayer?.depthType = .convex
        
        backView.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9450980392, blue: 0.9568627451, alpha: 1)
        backView.neumorphicLayer?.cornerRadius = 10
        backView.neumorphicLayer?.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        backView.neumorphicLayer?.shadowOffset = CGSize(width: 3, height: 3)
        backView.neumorphicLayer?.shadowOffset = CGSize(width: -3, height: -2)
        backView.neumorphicLayer?.shadowRadius = 6
        backView.neumorphicLayer?.cornerType = .all
        backView.neumorphicLayer?.darkShadowOpacity = 0.3
        backView.neumorphicLayer?.shadowOpacity = 1
        backView.neumorphicLayer?.depthType = .concave
        
        shareView.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9450980392, blue: 0.9568627451, alpha: 1)
        shareView.neumorphicLayer?.cornerRadius = 10
        shareView.neumorphicLayer?.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        shareView.neumorphicLayer?.shadowOffset = CGSize(width: 3, height: 3)
        shareView.neumorphicLayer?.shadowOffset = CGSize(width: -3, height: -2)
        shareView.neumorphicLayer?.shadowRadius = 6
        shareView.neumorphicLayer?.cornerType = .all
        shareView.neumorphicLayer?.darkShadowOpacity = 0.3
        shareView.neumorphicLayer?.shadowOpacity = 1
        shareView.neumorphicLayer?.depthType = .convex
        
        likeView.neumorphicLayer?.elementBackgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9450980392, blue: 0.9568627451, alpha: 1)
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
    private func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == itemImgCV{
            return self.images.count
        } else{
            return (dataModel?.data?.configurableOption?.first?.attributes ?? []).count
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == itemImgCV{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else{
            return CGSize(width: 95, height: 95)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == itemImgCV{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCVC", for: indexPath) as? ImagesCVC{
                let data = images[indexPath.row]
                cell.Imgs.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.Imgs.sd_setImage(with: URL(string: data), completed: nil)
                return cell
            }
        } else{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorsCVC", for: indexPath) as? ColorsCVC{
                let data = dataModel?.data?.configurableOption?.first?.attributes?[indexPath.row]
                cell.colorView.neumorphicLayer?.elementBackgroundColor = hexStringToUIColor(hex: data?.hexCode ?? "").cgColor
                return cell
            }
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == attCV{
            images.removeAll()
            let data = dataModel?.data?.configurableOption?.first?.attributes?[indexPath.row]
            images.append(contentsOf: data?.images ?? [])
            attName.text = data?.value ?? ""
            itemPrice.text = "K D \(data?.price ?? "")"
            itemImgCV.reloadData()
        } else{
            let data = images[indexPath.row]
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageDetailViewController") as? ImageDetailViewController{
                vc.image = data
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == itemImgCV{
            pageControl.currentPage = indexPath.row
        }
    }
}
