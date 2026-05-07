Easily track any float value you wish to track

# Functions

use ```add_value(value: float)``` everytime you want to add a point into the graph tracking the value
## note:
to always track a value use ```set()```
## for example:
```
@onready var Tracker: ValueTracker = $ValueTracker

var speed: float : set = speed_set
func speed_set(value):
	Tracker.add_value(value)
	speed = value

```

# Settings

* set ```MaxSeprates``` to how many max points can be in the graph at the same time.
* enable ```AlwaysClamp``` to always change maximum and minimum to whatever is the currents seen in graph values, instead of all graphed values.
* enable ```UseCustom``` to use the custom clamp values.
  - set ```CustomMax``` to clamp the maximum of graphed values.
  - set ```CustomMin``` to clamp the minimum of graphed values.
