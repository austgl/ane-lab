using System;
using System.Management;

namespace pcInfo {
    class Memory {
        private ManagementObjectSearcher searcher;
        public string getMemory() {
            searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_ComputerSystem");
            String memory = "";
            try {
                foreach (ManagementObject queryObj in searcher.Get()) {
                    memory = Convert.ToString((UInt64)queryObj["TotalPhysicalMemory"]);
                }
                //Console.WriteLine("ëSï®óùÉÅÉÇÉäÅ[: " + memory);
            } catch (ManagementException e) {
                Console.WriteLine(e.StackTrace);
            }
            return memory;
        }
    }
}
