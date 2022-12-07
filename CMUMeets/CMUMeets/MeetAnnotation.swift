//
//  MeetAnnotations.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/17/22.
//

import Foundation
import UIKit
import MapKit
import FirebaseFirestore
import SwiftUI

class MeetAnnotation:NSObject,MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var type: String?
    var joined: Int?
    var capacity: Int?
    var host : String
    var meet: Meet
    var people : [String]
    
  init(meet: Meet){
    self.coordinate = CLLocationCoordinate2D(latitude: Double(CLLocationDegrees(meet.latitude)), longitude: Double(CLLocationDegrees(meet.longitude)))
      self.title = meet.title
      self.subtitle = meet.location
      self.type = meet.icon
      self.joined = meet.joined
      // on ricky's branch, missing joined field for meets in hosting
      self.capacity = meet.capacity
      self.host = meet.host
      self.people = meet.people
      self.meet = meet
    }
}

class MeetAnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? { didSet { configureDetailView() } }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
}

private extension MeetAnnotationView {
    func configure() {
        canShowCallout = true
        configureDetailView()
    }

    func configureDetailView() {
        guard let annotation = annotation else { return }

        let rect = CGRect(origin: .zero, size: CGSize(width: 300, height: 200))

        // 
        let snapshotView = UIView()
        snapshotView.translatesAutoresizingMaskIntoConstraints = false
        snapshotView.frame = rect

      var child = UIHostingController(rootView: MeetPreviewView(annotation: annotation as! MeetAnnotation))
        child.view.frame = snapshotView.bounds
        snapshotView.addSubview(child.view)

        detailCalloutAccessoryView = snapshotView
        NSLayoutConstraint.activate([
            snapshotView.widthAnchor.constraint(equalToConstant: rect.width),
            snapshotView.heightAnchor.constraint(equalToConstant: rect.height)
        ])
    }
}
