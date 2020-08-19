# Recurrence types and schemas

## Weekly

> "Every {N} weeks on {subset of days of week}"

* 'n-weeks' : number
* 'subset of days of week': {weekday names}

## Day(s) of month

> "Every {N} months on {subset of days of month}."

* 'subset of days of month': [1 - 28, 'last']
* 'nth-month' : number

## Adjacent weekday(s) of month

> "Every {N} months on the {'first weekday on or after' | 'last weekday on or before'} the {subset of days of month} of the month."

* 'adjacent weekday' : ['last-before' | 'first-after']
* 'subset of days of month': [1 - 28, 'last']
* 'nth-month' : number

## Week(s) of month

> "Every {N} months on the {subset of weeks of month} weeks, on {subset of days of week}."

* 'subset of weeks of month': [1 - 4, 'last']
* 'subset of days of week': {weekday names}
* 'nth-month' : number

## Day of month of year

> "Every {N} years in the months of {subset of months of year} on {subset of days of month}."

* 'subset of days of month': [1 - 28, 'last']
* 'subset of months of year': {month names}
* 'nth-year' : number

## Adjacent weekday(s) of month of year

> "Every {N} years in the months of {subset of months of year} on the {'first weekday on or after' | 'last weekday on or before'} the {subset of days of month} of the month."

* 'adjacent weekday' : ['last-before' | 'first-after']
* 'subset of days of month': [1 - 28, 'last']
* 'subset of months of year': {month names}
* 'nth-year' : number

## Week(s) of month of year

> "Every {N} years in the months of {subset of months of year} on the {subset of weeks of month} weeks, on {subset of days of week}."

* 'subset of weeks of month': [1 - 4, 'last']
* 'subset of days of week': {weekday names}
* 'subset of months of year': {month names}
* 'nth-year' : number
