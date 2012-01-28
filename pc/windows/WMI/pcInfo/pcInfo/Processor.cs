using System;
using System.Collections.Generic;
using System.Text;
using System.Management;

namespace pcInfo {
    class Processor {
        private ManagementObjectSearcher searcher = new ManagementObjectSearcher("root\\CIMV2","SELECT * FROM Win32_Processor");

        private string clock;
        private string cpu;

        public Processor() {
            this.setParameter();
        }
        private void setParameter() {
            try {
                foreach (ManagementObject queryObj in searcher.Get()) {
                    clock = Convert.ToString(queryObj["CurrentClockSpeed"]);
                    cpu = Convert.ToString(queryObj["Name"]);
                }
            }catch(ManagementException me){
                Console.WriteLine(me.StackTrace);
            }
        }

        public string GetCpuClock {
            get { return clock; }
        }
        public string GetCpuInfo {
            get { return cpu; }
        }
    }
}
