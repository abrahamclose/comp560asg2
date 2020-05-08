import Foundation

public func model_free() -> [String: [String : Float]] {
    let LEARNING_RATE   = Float(0.1)
    let DISCOUNT        = Float(0.75)
    let epsilon         = Float(0.1)
    let n               = Int(25000)

    var q_table = [String: [String : Float]] ()
    env.forEach{ origin_state, shot_name in
        q_table[origin_state] = [String : Float] ()
        shot_name.forEach{ action,_ in
            q_table[origin_state]?[action] = 0
        }
    }
    
    for _ in (0..<n) {
        var discrete_state = q_table.keys.randomElement()!
        
        while discrete_state != "In" {
            var action = ""
            if (Float.random(in: 0..<1) > epsilon) {
                action = (q_table[discrete_state]?.max { a, b in a.value < b.value }?.key)!
            }
            else {
                action = (env[discrete_state]?.keys.randomElement())!
            }
            let new_discrete_state = (env[discrete_state]?[action]?.keys.randomElement()!)!
            
            if new_discrete_state != "In" {
                let max_future_q: Float = (q_table[new_discrete_state]?.max { a, b in a.value < b.value }?.value)!
                let curr_q: Float = q_table[discrete_state]![action]!
                let reward:Float = reward_for_action[new_discrete_state]!
                
                let new_q = (1 - LEARNING_RATE) * curr_q + LEARNING_RATE * (reward + DISCOUNT * max_future_q)
                q_table[discrete_state]![action]! = new_q
            }
            discrete_state = new_discrete_state
        }
    }
    return q_table
}
