using System;
using System.Collections;
using System.Diagnostics;

namespace EventLog_CS {
    class LocalEventLog {

        public ArrayList getEventLogEntry(string entryName) {
            ArrayList logArray = new ArrayList();

            EventLog log = new EventLog();
            log.Log = entryName;
            log.MachineName = System.Environment.MachineName;

            for (int i = 0; i < log.Entries.Count; i++) {
                if (log.Entries[i].EntryType == EventLogEntryType.Error) {
                    if (log.Entries[i].TimeWritten >= DateTime.Now.AddDays(-1)) {
                        try {
                            errEventLog _log = new errEventLog();
                            _log.timeWritten = log.Entries[i].TimeWritten.ToString();
                            _log.message = log.Entries[i].Message;
                            _log.source = log.Entries[i].Source;
                            long eventId = (log.Entries[i].InstanceId & 0x3fffffff);
                            _log.eventID = eventId.ToString();
                            _log.category = log.Entries[i].Category;
                            logArray.Add(_log);
                        } catch (Exception e) {
                            Console.WriteLine(e.StackTrace);
                        } // End try catch
                    } // End if
                } //End if
            } // End for
            log = null;
            return logArray;
        }
    }
}
