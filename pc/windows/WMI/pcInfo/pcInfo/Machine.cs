using System;
using System.DirectoryServices;
using System.Management;

namespace pcInfo {
    class Machine {

        private ManagementObjectSearcher searcher;

        public string getComputerName() {
            string computerName = "";
            searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_ComputerSystem");
            try {
                ManagementObjectCollection collection = searcher.Get();
                foreach (ManagementObject queryObj in collection) {
                    computerName = (String)queryObj["Name"];
                }
            } catch (ManagementException e) {
                Console.WriteLine(e.StackTrace);
            }
            //Console.WriteLine("�R���s���[�^��: " + computerName);
            return computerName;
        }
        public string getWorkGroupName() {
            String domain = "";
            try {
                searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_ComputerSystem");
                foreach (ManagementObject queryObj in searcher.Get()) {
                    domain = (String)queryObj["Domain"];
                }
            } catch (ManagementException e) {
                Console.WriteLine(e.StackTrace);
            }
            //Console.WriteLine("�h���C��/���[�N�O���[�v��: " + domain);
            return domain;
        }
        public string getComputerModel() {
            //string manufacturer = "";
            string model = "";
            searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_ComputerSystem");
            try {
                ManagementObjectCollection collection = searcher.Get();
                foreach (ManagementObject queryObj in collection) {
                    model = Convert.ToString(queryObj["Model"]);
                    //manufacturer = Convert.ToString(queryObj["Manufacturer"]);
                }
            } catch (ManagementException e) {
                Console.WriteLine(e.StackTrace);
            }
            //Console.WriteLine("���f��: " + model);
            return model;
        }
        public string getComputerManufacturer() {
            string manufacturer = "";
            //string model = "";
            searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_ComputerSystem");
            try {
                ManagementObjectCollection collection = searcher.Get();
                foreach (ManagementObject queryObj in collection) {
                    //model = Convert.ToString(queryObj["Model"]);
                    manufacturer = Convert.ToString(queryObj["Manufacturer"]);
                }
            } catch (ManagementException e) {
                Console.WriteLine(e.StackTrace);
            }
            //Console.WriteLine("���[�J�[: " + manufacturer);
            return manufacturer;
        }
        public string getRole() {
            string rolename = "";
            try {
                int role = 0;
                searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_ComputerSystem");
                foreach (ManagementObject queryObj in searcher.Get()) {
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
                };

            } catch (ManagementException e) {
                Console.WriteLine("An error occurred while querying for WMI data: " + e.Message);
            }
            //System.Console.WriteLine("�R���s���[�^�̖���: " + rolename);
            return rolename;
        }
        public string getUserName() {
            string userObj = "";
            try {
                searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_ComputerSystem");
                foreach (ManagementObject queryObj in searcher.Get()) {
                    userObj = (String)queryObj["UserName"];
                }
                /*
                if (userObj == "" || userObj == null)
                {
                    //ArrayList userList = SensNotification.OnSessionLogon();
                    foreach (String account in SensNotification.OnSessionLogon())
                    {
                        userObj = account;
                    }
                }
                 */ 
            } catch (Exception e) {
                //userObj = System.Environment.UserDomainName + "\\" + System.Environment.UserName;
                //Console.WriteLine("getUserName Enviroment logonUser: " + userObj);
                Console.WriteLine("An error occurred while querying for WMI data: " + e.Message);
                Console.WriteLine(e.StackTrace);
            }
            //Console.WriteLine("���O�I�����[�U��: " + userObj);
            return userObj;
        }
        public string getLogonTime() {
            string value = "";
            try
            {
                string domain = this.getWorkGroupName();//Environment.UserDomainName; // �h���C����
                string uName = this.getUserName();//Environment.UserName;       // ���[�U�[��
                string path = "WinNT://" + domain + "/" + uName;
                DirectoryEntry entry = new DirectoryEntry(path);
                value = entry.Properties["LastLogin"].Value.ToString();
                //value = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
            }
            catch (Exception) {
                string domain = Environment.UserDomainName; // �h���C����
                string uName = Environment.UserName;       // ���[�U�[��
                string path = "WinNT://" + domain + "/" + uName;
                DirectoryEntry entry = new DirectoryEntry(path);
                value = entry.Properties["LastLogin"].Value.ToString();
            }
            value = this.setLogonTimeStyle(value);
            return value;
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
