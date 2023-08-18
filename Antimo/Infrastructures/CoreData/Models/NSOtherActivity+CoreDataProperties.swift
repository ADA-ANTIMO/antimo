//
//  NSOtherActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import CoreData
import Foundation

extension NSOtherActivity {
  @NSManaged public var id: UUID?
  @NSManaged public var activity: NSActivity?

  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<NSOtherActivity> {
    NSFetchRequest<NSOtherActivity>(entityName: "NSOtherActivity")
  }

}

// MARK: - NSOtherActivity + Identifiable

extension NSOtherActivity: Identifiable { }
