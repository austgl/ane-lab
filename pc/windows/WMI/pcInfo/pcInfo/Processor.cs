using System;
using System.Collections.Generic;
using System.Text;
using System.Management;

namespace pcInfo {
    class Processor {
        private ManagementObjectSearcher searcher;

        public string getCpu() {
            string cpu = "";
            searcher = new ManagementObjectSearcher("SELECT * FROM Win32_ComputerSystem");
            foreach (ManagementObject queryObj in searcher.Get()) {
                cpu = Convert.ToString(queryObj["NumberOfProcessors"]);
            }
            //System.Console.WriteLine("CPU�̐�: " + cpu);
            return cpu;
        }
        public string getCpuClock() {
            string clock = "";
            searcher = new ManagementObjectSearcher("root\\CIMV2","SELECT * FROM Win32_Processor"); 
            foreach (ManagementObject queryObj in searcher.Get()) {
                clock = Convert.ToString(queryObj["CurrentClockSpeed"]);
            }
            //System.Console.WriteLine("Clock���g��: " + clock);
            return clock;
        }
        public string getCpuInfo() {
            string cpu = "";
            searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_Processor");
            foreach (ManagementObject queryObj in searcher.Get()) {
                cpu = Convert.ToString(queryObj["Name"]);
            }
            //System.Console.WriteLine("CPU���: " + cpu);
            return cpu;
        }
    }
}
