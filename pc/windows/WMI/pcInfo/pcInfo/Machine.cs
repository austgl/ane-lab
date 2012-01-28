using System;
using System.DirectoryServices;
using System.Management;

namespace pcInfo {
    class Machine {

        private ManagementObjectSearcher searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_ComputerSystem");

        private string computerName;
        private string  domain;
        private string  model;
        private string manufacturer;
        private string memory;
        private string userObj;
        private string rolename;
        private string logonTime;

        public Machine() {
            this.setParameter();
        }

        private void setParameter() {
            try {
                int role = 0;
                ManagementObjectCollection collection = searcher.Get();
                foreach (ManagementObject queryObj in collection) {
                    computerName = (String)queryObj["Name"];
                    domain = (String)queryObj["Domain"];
                    model = (String)queryObj["Model"];
                    manufacturer = (String)queryObj["Manufacturer"];
                    memory = Convert.ToString((UInt64)queryObj["TotalPhysicalMemory"]);
                    userObj = (String)queryObj["UserName"];
                    role = Convert.ToInt32(queryObj["DomainRole"]);
                }
                switch (role) {
                    case 0:
                        rolename = "Standalone WorkStation";
                        break;
                    case 1:
                        rolename = "Member WorkStation";
                        break;
                    case 2:
                        rolename = "Standalone Server";
                        break;
                    case 3:
                        rolename = "Member Server";
                        break;
                    case 4:
                        rolename = "Backup Domain Controller";
                        break;
                    case 5:
                        rolename = "Primary Domain Controller";
                        break;
                }
                this.setLogonTime();

            } catch (ManagementException me) {
                Console.WriteLine(me.StackTrace);
            }
        }
        public string GetComputerName {
            get { return computerName; }
        }
        public string GetWorkGroupName {
            get{ return domain; }
        }
        public string GetComputerModel {
            get { return model; }
        }
        public string GetRole {
            get { return rolename; }
        }
        public string GetMemory {
           get{ return memory; }
        }
        public string GetUserName {
            /*
            //ArrayList userList = SensNotification.OnSessionLogon();
            foreach (String account in SensNotification.OnSessionLogon())
            {
                userObj = account;
            }
            */
           get{ return userObj; }
        }
        public string GetLogonTime {
            get { return logonTime; }
        }
        private void setLogonTime() {
            try
            {
                string domain = GetWorkGroupName ;//Environment.UserDomainName; // ドメイン名
                string uName = GetUserName;//Environment.UserName;       // ユーザー名
                string path = "WinNT://" + domain + "/" + uName;
                DirectoryEntry entry = new DirectoryEntry(path);
                this.logonTime = entry.Properties["LastLogin"].Value.ToString();
            }catch (Exception) {
                string domain = Environment.UserDomainName; // ドメイン名
                string uName = Environment.UserName;       // ユーザー名
                string path = "WinNT://" + domain + "/" + uName;
                DirectoryEntry entry = new DirectoryEntry(path);
                this.logonTime = entry.Properties["LastLogin"].Value.ToString();
            }
            this.logonTime = this.setLogonTimeStyle(this.logonTime);
        }
        private string setLogonTimeStyle(string logonTime) {
            try {
                if (logonTime.IndexOf('-') != -1) { logonTime = logonTime.Replace('-', '/'); }
                if (logonTime.IndexOf('.') != -1) { logonTime = logonTime.Replace('.', '/'); }
                DateTime time1 = System.DateTime.Parse(logonTime);
                logonTime = time1.ToString("yyyy/MM/dd HH:mm:ss");
            }catch(Exception e){
                Console.WriteLine(e.Message);
            }
            return logonTime;
        }
    }
}
