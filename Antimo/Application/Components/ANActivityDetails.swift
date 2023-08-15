//
//  ANActivityDetails.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 02/06/23.
//

import SwiftUI

// MARK: - ActivityActions

enum ActivityActions: String, CaseIterable {
  case edit
  case delete

  func buttonRole() -> ButtonRole? {
    switch self {
    case .delete:
      return ButtonRole.destructive
    case .edit:
      return nil
    }
  }
}

// MARK: - ExtraIcons

enum ExtraIcons: String, CaseIterable {
  case mappin = "mappin.circle.fill"
  case forkKnife = "fork.knife.circle.fill"
  case timer = "timer.circle.fill"
}

// MARK: - Action

struct Action: Identifiable {
  let id: UUID
  let type: ActivityActions
  let action: () -> Void
}

// MARK: - ActivityMeta

struct ActivityMeta: View {
  let activity: Activity

  var body: some View {
    HStack(alignment: .top) {
      VStack(alignment: .leading) {
        if activity.type != ActivityTypes.other.rawValue {
          switch activity.type {
          case ActivityTypes.nutrition.rawValue:
            ActivityExtra(
              icon: .forkKnife,
              extra: "\(activity.nutrition!.menu!) (\(activity.nutrition!.isEatenUp ? "Eaten Up" : "Has Leftover"))")
          case ActivityTypes.medication.rawValue:
            if let vet = activity.medication?.vet, !vet.isEmpty {
              ActivityExtra(icon: .mappin, extra: "\(vet)")
            }
          case ActivityTypes.exercise.rawValue:
            ActivityExtra(icon: .timer, extra: "\(activity.exercise!.duration) Minutes")
          case ActivityTypes.grooming.rawValue:
            ActivityExtra(icon: .mappin, extra: "\(activity.grooming!.salon!)")
          default:
            EmptyView()
          }
        }

        HStack {
          let timeComponents = Utilities.getTime(date: activity.createdAt!)

          Text(String(format: "%02d:%02d", timeComponents.hour!, timeComponents.minute!))
            .font(.cardTime)
        }
        .foregroundColor(Color.primary)
        .padding(8)
        .background(
          Color.white)
        .cornerRadius(8)
      }

      Spacer()

      ZStack {
        VStack(spacing: 0) {
          let type = activity.type ?? ""
          let icon = ActivityIcons.getActivityIcon(type: type)

          Image(icon.rawValue)
            .resizable()
            .frame(width: 29, height: 29)

          Text(type)
            .font(.cardActivity)
            .foregroundColor(Color.anPrimary)
        }
        .foregroundColor(Color.anPrimary)
      }
      .frame(width: 40, height: 40)
      .padding(8)
      .background(
        Color.white)
      .cornerRadius(8)
    }
  }
}

// MARK: - ActivityHeading

struct ActivityHeading: View {
  let actions: [Action]
  let title: String
  let showAction: Bool

  @State var showSheet = false

  var body: some View {
    HStack {
      Text(title)
        .font(.cardTitle)

      Spacer()

      if showAction {
        Button {
          showSheet = true
        } label: {
          Image(systemName: "ellipsis")
            .foregroundColor(.blue)
        }
        .confirmationDialog("Select Action", isPresented: $showSheet) {
          ForEach(actions) { action in
            Button(role: action.type.buttonRole()) {
              action.action()
            } label: {
              Text(action.type.rawValue)
            }
          }
        }
      }
    }
  }
}

// MARK: - ActivityExtra

struct ActivityExtra: View {
  let icon: ExtraIcons
  let extra: String
  var body: some View {
    HStack {
      Image(systemName: icon.rawValue)
        .foregroundColor(Color.anPrimary)
      Text(extra)
        .font(.cardExtra)
    }
  }
}

// MARK: - ActivityStatus

struct ActivityStatus: View {
  let status: Mood

  var body: some View {
    ZStack {
      Image("mood\(status.rawValue.capitalizedFirstLetter)")
        .resizable()
        .frame(width: 30, height: 30)

      Color.anPrimary.blendMode(.sourceAtop)
    }
    .drawingGroup(opaque: false)
    .frame(width: 40, height: 40)
    .padding(8)
    .foregroundColor(Color.anPrimary)
    .background(
      Color.white)
    .cornerRadius(8)
  }
}

// MARK: - ANActivityDetails

struct ANActivityDetails: View {

  // MARK: Lifecycle

  init(activity: Activity, actions: [Action], showAction: Bool = true) {
    self.activity = activity
    self.actions = actions
    self.showAction = showAction
  }

  // MARK: Internal

  let activity: Activity
  let actions: [Action]

  let showAction: Bool

  var body: some View {
    VStack {
      if let image = FileManager().retrieveImage(with: activity.imagePath) {
        VStack {
          Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 200, alignment: .center)
            .clipped()
        }
        .frame(height: 200)
      }

      // Details
      VStack(alignment: .leading, spacing: 16) {
        ActivityHeading(actions: actions, title: activity.title!, showAction: showAction)

        ActivityMeta(activity: activity)

        // Desc
        HStack(alignment: .top) {
          Text(activity.note!)
            .font(.cardContent)
            .frame(maxWidth: .infinity, alignment: .leading)

          ActivityStatus(status: .high)
        }
      }
      .padding(16)
    }
    .background(
      Color.anPrimaryLight)
    .cornerRadius(8)
  }
}
