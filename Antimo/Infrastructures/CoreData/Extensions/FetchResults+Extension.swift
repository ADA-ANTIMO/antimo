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

// MARK: - OrderedEvent

struct OrderedEvent {
  var events = [String: [Event]]()
  var keys = [String]()
}

extension FetchedResults<Event> {
  var byDate: OrderedEvent {
    var dictOfEvents = [String: [Event]]()
    var keyOfDict = [String]()

    for event in self {
      let key = Utilities.formattedDate(from: event.triggerDate ?? Date(), format: "EEEE, d MMM yyyy")

      if var dict = dictOfEvents[key] {
        dict.append(event)

        dictOfEvents[key] = dict
      } else {
        keyOfDict.append(key)
        dictOfEvents[key] = [event]
      }
    }

    return OrderedEvent(events: dictOfEvents, keys: keyOfDict)
  }
}
