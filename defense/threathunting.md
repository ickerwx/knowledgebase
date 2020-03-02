# Notes on Threat Hunting

## Basic Principle

```
            +----------------------+
       +--> | 1. Create Hypothesis +-----+
       |    +----------------------+     |
       |                                 |
       |                                 |
       |                                 v
+------+-----+                   +-------+-----+
| 4. Refine/ |                   | 2. Develop  |
|    Discard |                   |    the Hunt |
+------+-----+                   +-------+-----+
       ^                                 |
       |         +------------+          |
       |         | 3. Examine |          |
       +---------+    Results +<---------+
                 +------------+          
```

tags: blueteam [Threat Hunting]
