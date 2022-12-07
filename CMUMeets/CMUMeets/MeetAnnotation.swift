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

class MeetAnnotation:NSObject,MKAnnotation,Identifiable{
  let id = UUID()
  var coordinate: CLLocationCoordinate2D
  var title: String?
  var subtitle: String?
  var meet: Meet
  var firebase: Firebase
  init(meet: Meet, firebase: Firebase){
    self.coordinate = CLLocationCoordinate2D(latitude: meet.latitude, longitude: meet.longitude)
    self.title = meet.title
    self.subtitle = meet.location
    self.meet = meet
    self.firebase = firebase
    }
}

class MeetAnnotationView: MKMarkerAnnotationView {
    static let reuseID = "MeetAnnotation"
  
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

        let rect = CGRect(origin: .zero, size: CGSize(width: 275, height: 190))

        //
        let snapshotView = UIView()
        snapshotView.translatesAutoresizingMaskIntoConstraints = false
        snapshotView.frame = rect

        let child = UIHostingController(rootView: MeetPreviewView(annotation: annotation as! MeetAnnotation))
        child.view.frame = snapshotView.bounds
        snapshotView.addSubview(child.view)

        detailCalloutAccessoryView = snapshotView
        NSLayoutConstraint.activate([
            snapshotView.widthAnchor.constraint(equalToConstant: rect.width),
            snapshotView.heightAnchor.constraint(equalToConstant: rect.height)
        ])
    }
}
