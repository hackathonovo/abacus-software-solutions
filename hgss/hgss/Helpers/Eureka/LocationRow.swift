//
//  LocationRow.swift
//  hgss
//
//  Created by Tin Jurkovic on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//


import Foundation
import UIKit
import Eureka
import MapKit

public class LocationRowCell: Cell<CLLocation>, CellType {
    @IBOutlet weak var mapKitView: MKMapView!
    
    

    
    public override func setup() {
        super.setup()
        
        height = { return 250 }
        
        
        
    }
    
    public override func update() {
        super.update()
        if let location = row.value {
            let locationPin = MKPointAnnotation()
            locationPin.coordinate = location.coordinate
            
            mapKitView.addAnnotation(locationPin)
            
            mapKitView.centerCoordinate = locationPin.coordinate
        }
    }
    
    
}
 
public final class LocationRow : SelectorRow<LocationRowCell, MapViewController>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
        
        presentationMode = .show(
            controllerProvider: ControllerProvider.callback {
                return MapViewController(){ _ in }
            },
            onDismiss: { vc in _ = vc.navigationController?.popViewController(animated: true) })
        
        cellProvider = CellProvider<LocationRowCell>(nibName: "LocationRowCell")
        
        //        displayValueFor = {
        //            guard let location = $0 else { return "" }
        //            let fmt = NumberFormatter()
        //            fmt.maximumFractionDigits = 4
        //            fmt.minimumFractionDigits = 4
        //            let latitude = fmt.string(from: NSNumber(value: location.coordinate.latitude))!
        //            let longitude = fmt.string(from: NSNumber(value: location.coordinate.longitude))!
        //            return  "\(latitude), \(longitude)"
        //        }
    }
}
public class MapViewController : UIViewController, TypedRowControllerType, MKMapViewDelegate {
    
    public var row: RowOf<CLLocation>!
    public var onDismissCallback: ((UIViewController) -> ())?
    
    lazy var mapView : MKMapView = { [unowned self] in
        let v = MKMapView(frame: self.view.bounds)
        v.autoresizingMask = UIViewAutoresizing.flexibleWidth.union(.flexibleHeight)
        return v
        }()
    
    lazy var pinView: UIImageView = { [unowned self] in
        let v = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        v.image = UIImage(named: "map_pin", in: Bundle(for: MapViewController.self), compatibleWith: nil)
        v.image = v.image?.withRenderingMode(.alwaysTemplate)
        v.tintColor = self.view.tintColor
        v.backgroundColor = .clear
        v.clipsToBounds = true
        v.contentMode = .scaleAspectFit
        v.isUserInteractionEnabled = false
        return v
        }()
    
    let width: CGFloat = 10.0
    let height: CGFloat = 5.0
    
    lazy var ellipse: UIBezierPath = { [unowned self] in
        let ellipse = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        return ellipse
        }()
    
    
    lazy var ellipsisLayer: CAShapeLayer = { [unowned self] in
        let layer = CAShapeLayer()
        layer.bounds = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        layer.path = self.ellipse.cgPath
        layer.fillColor = UIColor.gray.cgColor
        layer.fillRule = kCAFillRuleNonZero
        layer.lineCap = kCALineCapButt
        layer.lineDashPattern = nil
        layer.lineDashPhase = 0.0
        layer.lineJoin = kCALineJoinMiter
        layer.lineWidth = 1.0
        layer.miterLimit = 10.0
        layer.strokeColor = UIColor.gray.cgColor
        return layer
        }()
    
    public func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3))
        mapView.setRegion(region, animated: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience public init(_ callback: ((UIViewController) -> ())?){
        self.init(nibName: nil, bundle: nil)
        onDismissCallback = callback
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        
        mapView.delegate = self
        mapView.addSubview(pinView)
        mapView.layer.insertSublayer(ellipsisLayer, below: pinView.layer)
        
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(MapViewController.tappedDone(_:)))
        button.title = "Done"
        navigationItem.rightBarButtonItem = button
        
        if let value = row.value {
            let region = MKCoordinateRegionMakeWithDistance(value.coordinate, 400, 400)
            mapView.setRegion(region, animated: true)
        }
        else{
            mapView.showsUserLocation = true
        }
        updateTitle()
        
        mapView.showsUserLocation = true
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let center = mapView.convert(mapView.centerCoordinate, toPointTo: pinView)
        pinView.center = CGPoint(x: center.x, y: center.y - (pinView.bounds.height/2))
        ellipsisLayer.position = center
    }
    
    
    func tappedDone(_ sender: UIBarButtonItem){
        let target = mapView.convert(ellipsisLayer.position, toCoordinateFrom: mapView)
        row.value = CLLocation(latitude: target.latitude, longitude: target.longitude)
        onDismissCallback?(self)
    }
    
    func updateTitle(){
        let fmt = NumberFormatter()
        fmt.maximumFractionDigits = 4
        fmt.minimumFractionDigits = 4
        let latitude = fmt.string(from: NSNumber(value: mapView.centerCoordinate.latitude))!
        let longitude = fmt.string(from: NSNumber(value: mapView.centerCoordinate.longitude))!
        title = "\(latitude), \(longitude)"
    }
    
    public func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        ellipsisLayer.transform = CATransform3DMakeScale(0.5, 0.5, 1)
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.pinView.center = CGPoint(x: self!.pinView.center.x, y: self!.pinView.center.y - 10)
        })
    }
    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        ellipsisLayer.transform = CATransform3DIdentity
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.pinView.center = CGPoint(x: self!.pinView.center.x, y: self!.pinView.center.y + 10)
        })
        updateTitle()
    }
}
public final class ImageCheckRow<T: Equatable>: Row<ImageCheckCell<T>>, SelectableRowType, RowType {
    public var selectableValue: T?
    required public init(tag: String?) {
        super.init(tag: tag)
        displayValueFor = nil
    }
}
public class ImageCheckCell<T: Equatable> : Cell<T>, CellType {
    
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy public var trueImage: UIImage = {
        return UIImage(named: "selected")!
    }()
    
    lazy public var falseImage: UIImage = {
        return UIImage(named: "unselected")!
    }()
    
    public override func update() {
        super.update()
        accessoryType = .none
        imageView?.image = row.value != nil ? trueImage : falseImage
    }
    
    public override func setup() {
        super.setup()
    }
    
    public override func didSelect() {
        row.reload()
        row.select()
        row.deselect()
    }
    
}
