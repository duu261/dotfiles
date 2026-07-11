local vars = require("variables")

hl.gesture({ fingers = vars.workspaceSwipeFingers, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = vars.gestureFingers, direction = "up", action = "special" })
hl.gesture({ fingers = vars.gestureFingers, direction = "down", action = function() hl.exec_cmd("caelestia toggle specialws") end })
hl.gesture({ fingers = vars.gestureFingersMore, direction = "down", action = function() hl.exec_cmd(vars.sleepGestureCmd) end })
