using System;
using System.Collections;

namespace EventLog_CS {
    public class EventLogList {
        public ArrayList getEventLog(string entryName){
            LocalEventLog log = new LocalEventLog();
            return log.getEventLogEntry(entryName);
        }
    }
}
