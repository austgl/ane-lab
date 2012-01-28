using System;
using System.Collections;

namespace EventLog_CS {
    public class EventLogList {
        
        private LocalEventLog log = new LocalEventLog();

        public ArrayList getEventLog(string entryName){
            return log.getEventLogEntry(entryName);
        }
    }
}
