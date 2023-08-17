//
//  FetchResults+Extension.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 11/06/23.
//

import SwiftUI

// MARK: - OrderedActivity

struct OrderedActivity {
  var activities = [String: [Activity]]()
  var keys = [String]()
}

extension FetchedResults<Activity> {
  var byDate: OrderedActivity {
    var dictOfActivities = [String: [Activity]]()
    var keyOfDict = [String]()

    for activity in self {
      let key = Utilities.formattedDate(from: activity.createdAt!, format: "EEEE, d MMM yyyy")

      if var dict = dictOfActivities[key] {
        dict.append(activity)

        dictOfActivities[key] = dict
      } else {
        keyOfDict.append(key)
        dictOfActivities[key] = [activity]
      }
    }

    return OrderedActivity(activities: dictOfActivities, keys: keyOfDict)
  }
}
