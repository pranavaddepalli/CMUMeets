//
//  ClusterView.swift
//  CMUMeets
//
//  Created by Ricky Lee on 12/5/22.
//
import Foundation
import UIKit
import MapKit
import FirebaseFirestore
import SwiftUI

class ClusterView: MKMarkerAnnotationView {
    static let reuseID = "ClusterAnnotation"

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension ClusterView {
    func configure() {
        canShowCallout = true
        configureDetailView()
    }

    func configureDetailView() {

        guard let annotation = annotation as? MKClusterAnnotation else { return }

        let rect = CGRect(origin: .zero, size: CGSize(width: 275, height: 190))

        let snapshotView = UIView()
        snapshotView.translatesAutoresizingMaskIntoConstraints = false
        snapshotView.frame = rect

        var listAnnos : [MeetAnnotation] = []
        for item in annotation.memberAnnotations {
          listAnnos.append(item as! MeetAnnotation)
        }
        let child = UIHostingController(rootView: ClusteredMeetsView(annotations: listAnnos))
        child.view.frame = snapshotView.bounds
        snapshotView.addSubview(child.view)

        detailCalloutAccessoryView = snapshotView
        NSLayoutConstraint.activate([
            snapshotView.widthAnchor.constraint(equalToConstant: rect.width),
            snapshotView.heightAnchor.constraint(equalToConstant: rect.height)
        ])
    }
}
