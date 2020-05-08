import Foundation

var reward_for_action = [String: Float] ()
reward_for_action["Ravine"] = 0.2
reward_for_action["Fairway"] = 0.3
reward_for_action["Over"] = 0.4
reward_for_action["Left"] = 0.5
reward_for_action["Same"] = 0.6
reward_for_action["Close"] = 0.9

var env = [String: [String : [String : Float]]] ()
while let input: String = readLine(strippingNewline: true) {
    let input_array  = input.split(separator: "/", maxSplits: 3)
    let origin_state = String(input_array.first!)
    let shot_name    = String(input_array[1])
    let new_state    = String(input_array[2])
    let prob         = Float(input_array[3])
    
    if (env[origin_state] == nil) {
        env[origin_state] = [String : [String : Float]] ()
    }
    if (env[origin_state]?[shot_name] == nil) {
        env[origin_state]?[shot_name] = [String : Float]()
    }
    
    env[origin_state]?[shot_name]?[new_state] = prob
}

print("--Model Free Learning Poicy--")
print("",
      "STATE" .padding(toLength: 7, withPad: " ", startingAt: 0), "|",
      "ACTION".padding(toLength: 6, withPad: " ", startingAt: 0), "|",
      "UTILITY")

model_free().forEach { state in
    state.value.forEach{ action, utility in
        print("",
        state.key.padding(toLength: 7, withPad: " ", startingAt: 0), "|",
        action   .padding(toLength: 6, withPad: " ", startingAt: 0), "|",
        String(utility))
    }
}
