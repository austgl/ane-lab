using System;
using System.Collections;
using System.Diagnostics;

namespace EventLog_CS {
    class LocalEventLog {

        public ArrayList getEventLogEntry(string entryName) {
            ArrayList logArray = null;

            try {
                EventLogPermission perm = new EventLogPermission(EventLogPermissionAccess.Administer, ".");
                perm.PermitOnly();
                try {
                    EventLog log = new EventLog(entryName, ".");
                    logArray = new ArrayList();

                    for (int i = 0; i < log.Entries.Count; i++) {
                        if (log.Entries[i].EntryType == EventLogEntryType.Error) {
                            if (log.Entries[i].TimeWritten >= DateTime.Now.AddDays(-1)) {
                                try {
                                    errEventLog _log = new errEventLog();
                                    _log.timeWritten = log.Entries[i].TimeWritten.ToString();
                                    //_log.message = log.Entries[i].Message;
                                    _log.source = log.Entries[i].Source;
                                    long eventId = (log.Entries[i].InstanceId & 0x3fffffff);
                                    _log.eventID = eventId.ToString();
                                    //_log.category = log.Entries[i].Category;
                                    logArray.Add(_log);
                                } catch (Exception e) {
                                    Console.WriteLine(e.StackTrace);
                                }
                            }
                        }
                    }
                } catch (Exception e) {
                    Console.WriteLine(e.StackTrace);
                }
            } catch (Exception e) {
                Console.WriteLine(e.StackTrace);
            }
            return logArray;
        }
        //True‚¾‚Á‚½‚çWORKGROUP
        private bool isWorkGroup() {
            string logonUser = System.Environment.UserName;
            string computerName = System.Environment.MachineName;

            if (logonUser.StartsWith(computerName) == true ||
                            logonUser.IndexOf(computerName) != -1) {
                return true;
            }

            return false;
        }
    }
}
