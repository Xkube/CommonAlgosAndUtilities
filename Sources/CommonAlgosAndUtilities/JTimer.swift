//
//  JTimer.swift
//  
//
//  Created by Jimekor Hini on 2023-06-05.
//

import Foundation

class JTimer {
  typealias JTimerAction = (JTimer) -> Void
  
  private(set) var timeInterval: Double
  private var shouldStop = false
  private var repeats: Bool = false
  private var action: JTimerAction
  
  init(timeInterval: Double, repeats: Bool = false,  action: @escaping JTimerAction) {
    self.timeInterval = timeInterval
    self.action = action
    self.repeats = repeats
  }
  
  func start() {
    Task { // creates a new lane to run this code so that we are not blocking the calling lane
      var count = 0.0
      while shouldStop == false {
        sleep(1) // count
        count += 1 // remember your count
        if count == timeInterval { // is this equal to when we should be notifying the caller
          fire()
          count = 0 // reset count
        }
      }
    }
  }
  
  func stop() {
    shouldStop = true
  }
  
  func fire() {
    Task{@MainActor in // creates a new lane that jumps back to the main and then call the action in main lane
      action(self)
    }
    
    if repeats == false {
      shouldStop = true
    }
  }
  
  func invalidate() {
    // Remember Big Self is for Class methods and variables and small self is for intance or initialized method
    Self.activeJTimer?.stop()
    Self.activeJTimer = nil
  }
}

// Static methods -- This is a method on the Class (Think Factory/Blueprint) not the object (Think instance/ items made from blueprint)
extension JTimer {
  private static var activeJTimer: JTimer?
  
  @discardableResult
  static func scheduledTimer(withTimeInterval timerInterval: Double, repeats: Bool, action: @escaping JTimerAction) -> JTimer {
    let aTimer: JTimer
    if activeJTimer == nil || activeJTimer?.shouldStop ?? true {
      aTimer = JTimer(timeInterval: timerInterval, repeats: repeats, action: action)
      activeJTimer = aTimer
    } else {
      aTimer = activeJTimer!
    }
    aTimer.start()
    return aTimer
  }
}
