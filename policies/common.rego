package common

import data.abbey.functions

allow[msg] {
    true; functions.expire_after("1h")
    msg := "granting access for 1 hour"
}
