// ScheduleData.swift
import Foundation

// A LUNCH (1st Lunch)
let schedules: [String: [ScheduleBlock]] = [
    "Monday": [
        ScheduleBlock(name: "Period 1", start: "8:35 AM", end: "9:55 AM"),
        ScheduleBlock(name: "Passing",  start: "9:55 AM", end: "10:05 AM"),
        ScheduleBlock(name: "Period 2", start: "10:05 AM", end: "10:50 AM"),
        ScheduleBlock(name: "Passing",  start: "10:50 AM", end: "11:00 AM"),
        ScheduleBlock(name: "1st Lunch", start: "11:00 AM", end: "11:30 AM"),
        ScheduleBlock(name: "Period 3", start: "11:30 AM", end: "12:50 PM"),
        ScheduleBlock(name: "Passing",  start: "12:50 PM", end: "1:00 PM"),
        ScheduleBlock(name: "Period 5", start: "1:00 PM",  end: "2:20 PM"),
        ScheduleBlock(name: "Passing",  start: "2:20 PM",  end: "2:30 PM"),
        ScheduleBlock(name: "Period 6", start: "2:30 PM",  end: "3:15 PM")
    ],
    "Tuesday": [
        ScheduleBlock(name: "Period 1", start: "8:35 AM", end: "9:20 AM"),
        ScheduleBlock(name: "Passing",  start: "9:20 AM", end: "9:30 AM"),
        ScheduleBlock(name: "Period 2", start: "9:30 AM", end: "10:50 AM"),
        ScheduleBlock(name: "Passing",  start: "10:50 AM", end: "11:00 AM"),
        ScheduleBlock(name: "1st Lunch", start: "11:00 AM", end: "11:30 AM"),
        ScheduleBlock(name: "Period 4", start: "11:30 AM", end: "12:50 PM"),
        ScheduleBlock(name: "Passing",  start: "12:50 PM", end: "1:00 PM"),
        ScheduleBlock(name: "Period 4", start: "1:00 PM",  end: "1:45 PM"),
        ScheduleBlock(name: "Passing",  start: "1:45 PM",  end: "1:55 PM"),
        ScheduleBlock(name: "Period 6", start: "1:55 PM",  end: "3:15 PM")
    ],
    "Wednesday": [
        ScheduleBlock(name: "Period 1", start: "8:35 AM", end: "9:55 AM"),
        ScheduleBlock(name: "Passing",  start: "9:55 AM", end: "10:05 AM"),
        ScheduleBlock(name: "Period 3", start: "10:05 AM", end: "11:25 AM"),
        ScheduleBlock(name: "Passing",  start: "11:25 AM", end: "11:35 AM"),
        ScheduleBlock(name: "Period 5", start: "11:35 AM", end: "12:55 PM"),
        ScheduleBlock(name: "Passing",  start: "12:55 PM", end: "1:00 PM"),
        ScheduleBlock(name: "Lunch",    start: "1:00 PM",  end: "1:30 PM"),
    ],
    "Thursday": [
        ScheduleBlock(name: "Period 2", start: "8:35 AM", end: "9:55 AM"),
        ScheduleBlock(name: "Passing",  start: "9:55 AM", end: "10:05 AM"),
        ScheduleBlock(name: "Period 3", start: "10:05 AM", end: "10:50 AM"),
        ScheduleBlock(name: "Passing",  start: "10:50 AM", end: "11:00 AM"),
        ScheduleBlock(name: "1st Lunch", start: "11:00 AM", end: "11:30 AM"),
        ScheduleBlock(name: "Period 4", start: "11:30 AM", end: "12:50 PM"),
        ScheduleBlock(name: "Passing",  start: "12:50 PM", end: "1:00 PM"),
        ScheduleBlock(name: "Period 5", start: "1:00 PM",  end: "1:45 PM"),
        ScheduleBlock(name: "Passing",  start: "1:45 PM",  end: "1:55 PM"),
        ScheduleBlock(name: "Period 6", start: "1:55 PM",  end: "3:15 PM")
    ],
    "Friday": [
        ScheduleBlock(name: "Period 1", start: "8:35 AM", end: "9:23 AM"),
        ScheduleBlock(name: "Passing",  start: "9:23 AM", end: "9:30 AM"),
        ScheduleBlock(name: "Homeroom", start: "9:30 AM", end: "10:10 AM"),
        ScheduleBlock(name: "Passing",  start: "10:10 AM", end: "10:17 AM"),
        ScheduleBlock(name: "Period 2", start: "10:17 AM", end: "11:05 AM"),
        ScheduleBlock(name: "1st Lunch", start: "11:05 AM", end: "11:35 AM"),
        ScheduleBlock(name: "Passing",  start: "11:35 AM", end: "11:42 AM"),
        ScheduleBlock(name: "Period 3", start: "11:42 AM", end: "12:30 PM"),
        ScheduleBlock(name: "Passing",  start: "12:30 PM", end: "12:37 PM"),
        ScheduleBlock(name: "Period 4", start: "12:37 PM", end: "1:25 PM"),
        ScheduleBlock(name: "Passing",  start: "1:25 PM",  end: "1:32 PM"),
        ScheduleBlock(name: "Period 5", start: "1:32 PM",  end: "2:20 PM"),
        ScheduleBlock(name: "Passing",  start: "2:20 PM",  end: "2:27 PM"),
        ScheduleBlock(name: "Period 6", start: "2:27 PM",  end: "3:15 PM")
    ]
]

let schedulesBLunch: [String: [ScheduleBlock]] = [
    "Monday": [
        ScheduleBlock(name: "Period 1",  start: "8:35 AM", end: "9:55 AM"),
        ScheduleBlock(name: "Passing",   start: "9:55 AM", end: "10:05 AM"),
        ScheduleBlock(name: "Period 2",  start: "10:05 AM", end: "10:50 AM"),
        ScheduleBlock(name: "Passing",   start: "10:50 AM", end: "11:00 AM"),
        ScheduleBlock(name: "Period 3",  start: "11:00 AM", end: "12:20 PM"),
        ScheduleBlock(name: "2nd Lunch", start: "12:20 PM", end: "12:50 PM"),
        ScheduleBlock(name: "Passing",  start: "12:50 PM", end: "1:00 PM"),
        ScheduleBlock(name: "Period 5",  start: "1:00 PM",  end: "2:20 PM"),
        ScheduleBlock(name: "Passing",   start: "2:20 PM",  end: "2:30 PM"),
        ScheduleBlock(name: "Period 6",  start: "2:30 PM",  end: "3:15 PM")
    ],
    "Tuesday": [
        ScheduleBlock(name: "Period 1",  start: "8:35 AM", end: "9:20 AM"),
        ScheduleBlock(name: "Passing",   start: "9:20 AM", end: "9:30 AM"),
        ScheduleBlock(name: "Period 2",  start: "9:30 AM", end: "10:50 AM"),
        ScheduleBlock(name: "Passing",   start: "10:50 AM", end: "11:00 AM"),
        ScheduleBlock(name: "Period 4",  start: "11:00 AM", end: "12:20 PM"),
        ScheduleBlock(name: "2nd Lunch", start: "12:20 PM", end: "12:50 PM"),
        ScheduleBlock(name: "Passing",   start: "12:50 PM", end: "1:00 PM"),
        ScheduleBlock(name: "Period 4",  start: "1:00 PM",  end: "1:45 PM"),
        ScheduleBlock(name: "Passing",   start: "1:45 PM",  end: "1:55 PM"),
        ScheduleBlock(name: "Period 6",  start: "1:55 PM",  end: "3:15 PM")
    ],
    "Wednesday": [
        ScheduleBlock(name: "Period 1",  start: "8:35 AM", end: "9:55 AM"),
        ScheduleBlock(name: "Passing",   start: "9:55 AM", end: "10:05 AM"),
        ScheduleBlock(name: "Period 3",  start: "10:05 AM", end: "11:25 AM"),
        ScheduleBlock(name: "Passing",   start: "11:25 AM", end: "11:35 AM"),
        ScheduleBlock(name: "Period 5",  start: "11:35 AM", end: "12:55 PM"),
        ScheduleBlock(name: "Passing",  start: "12:55 PM", end: "1:00 PM"),
        ScheduleBlock(name: "Lunch",     start: "1:00 PM",  end: "1:30 PM"),
    ],
    "Thursday": [
        ScheduleBlock(name: "Period 2",  start: "8:35 AM", end: "9:55 AM"),
        ScheduleBlock(name: "Passing",   start: "9:55 AM", end: "10:05 AM"),
        ScheduleBlock(name: "Period 3",  start: "10:05 AM", end: "10:50 AM"),
        ScheduleBlock(name: "Passing",   start: "10:50 AM", end: "11:00 AM"),
        ScheduleBlock(name: "Period 4",  start: "11:00 AM", end: "12:20 PM"),
        ScheduleBlock(name: "2nd Lunch", start: "12:20 PM", end: "12:50 PM"),
        ScheduleBlock(name: "Passing",   start: "12:50 PM", end: "1:00 PM"),
        ScheduleBlock(name: "Period 5",  start: "1:00 PM",  end: "1:45 PM"),
        ScheduleBlock(name: "Passing",   start: "1:45 PM",  end: "1:55 PM"),
        ScheduleBlock(name: "Period 6",  start: "1:55 PM",  end: "3:15 PM")
    ],
    "Friday": [
        ScheduleBlock(name: "Period 1",  start: "8:35 AM", end: "9:23 AM"),
        ScheduleBlock(name: "Passing",   start: "9:23 AM", end: "9:30 AM"),
        ScheduleBlock(name: "Homeroom",  start: "9:30 AM", end: "10:10 AM"),
        ScheduleBlock(name: "Passing",   start: "10:10 AM", end: "10:17 AM"),
        ScheduleBlock(name: "Period 2",  start: "10:17 AM", end: "11:05 AM"),
        ScheduleBlock(name: "Passing",   start: "11:05 AM", end: "11:12 AM"),
        ScheduleBlock(name: "Period 3",  start: "11:12 AM", end: "12:00 PM"),
        ScheduleBlock(name: "2nd Lunch", start: "12:00 PM", end: "12:30 PM"),
        ScheduleBlock(name: "Passing",   start: "12:30 PM", end: "12:37 PM"),
        ScheduleBlock(name: "Period 4",  start: "12:37 PM", end: "1:25 PM"),
        ScheduleBlock(name: "Passing",   start: "1:25 PM",  end: "1:32 PM"),
        ScheduleBlock(name: "Period 5",  start: "1:32 PM",  end: "2:20 PM"),
        ScheduleBlock(name: "Passing",   start: "2:20 PM",  end: "2:27 PM"),
        ScheduleBlock(name: "Period 6",  start: "2:27 PM",  end: "3:15 PM")
    ]
]
