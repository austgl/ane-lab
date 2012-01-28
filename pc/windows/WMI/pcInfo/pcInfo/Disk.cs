using System;
using System.Management;

namespace pcInfo {
    class Disk {
        private ManagementObjectSearcher searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_LogicalDisk WHERE DriveType = 3");

        private string C_Total;
        private string C_Used;
        private string C_Free;
        private string C_FreePercent;

        public Disk() {
            this.setDriveInfo();
        }
        public string GetC_Total {
            get{  return this.C_Total; }
        }
        public string GetC_Used {
            get { return this.C_Used; }
        }
        public string GetC_Free {
            get { return this.C_Free; }
        }
        public string GetC_FreePercent {
            get{ return this.C_FreePercent; }
        }
        private void setDriveInfo() {
            try {
                foreach (ManagementObject queryObj in searcher.Get()) {
                    string id = Convert.ToString(queryObj["DeviceID"]);
                    if (id.Equals("C:")){
                        Double freeSpace = Convert.ToDouble(queryObj["FreeSpace"]);
                        Double maxSize = Convert.ToDouble(queryObj["Size"]);
                        double parsent = (freeSpace / maxSize);
                        ulong useDisk = (ulong)(Convert.ToUInt64(queryObj["Size"]) - Convert.ToUInt64(queryObj["FreeSpace"]));
                        this.C_Total = Convert.ToUInt64(queryObj["Size"]).ToString("N");
                        this.C_Used = useDisk.ToString("N");
                        this.C_Free = Convert.ToUInt64(queryObj["FreeSpace"]).ToString("N");
                        this.C_FreePercent = parsent.ToString("N");

                        //Console.WriteLine("C: 合計: " + Convert.ToUInt64(queryObj["Size"]).ToString("N"));
                        //Console.WriteLine("C: 使用量: " + useDisk.ToString("N"));
                        //Console.WriteLine("C: 空き容量: " + Convert.ToUInt64(queryObj["FreeSpace"]).ToString("N"));
                        //Console.WriteLine("C: 空き容量(%): " + parsent.ToString("N"));
                    }
                }
            } catch (ManagementException e) {
                Console.WriteLine(e.StackTrace);
            }
            
        }
    }
}
