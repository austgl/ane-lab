using System;
using System.Management;

namespace pcInfo {
    class Os {
        private ManagementObjectSearcher searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_OperatingSystem");

        private string osName;
        private string osVer;

        public Os() {
            this.setParameter();
        }

        private void setParameter() {
            try {
                foreach (ManagementObject queryObj in searcher.Get()) { 
                    osName = Convert.ToString(queryObj["Caption"]);
                    osVer = Convert.ToString(queryObj["CSDVersion"]);
                }
            } catch (ManagementException e) {
                Console.WriteLine("An error occurred while querying for WMI data: " + e.Message);
            }
        
        }

        public string GetOS {
            get { return osName; }
        }
        public string GetOsVersion {
            get { return osVer; }
        }
    }
}
