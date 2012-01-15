using System;
using System.Management;

namespace pcInfo {
    class Os {
        private ManagementObjectSearcher searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_OperatingSystem");
        public string getOS() {
            string osName = "";
            try {
                foreach (ManagementObject queryObj in searcher.Get()) { osName = Convert.ToString(queryObj["Caption"]); }
            } catch (ManagementException e) {
                Console.WriteLine("An error occurred while querying for WMI data: " + e.Message);
            }
            //Console.WriteLine("OS: " + osName);
            return osName;
        }
        public string getOsVersion() {
            string osVer = "";
            try {
                foreach (ManagementObject queryObj in searcher.Get()) { osVer = Convert.ToString(queryObj["CSDVersion"]); }
            } catch (ManagementException e) {
                Console.WriteLine("An error occurred while querying for WMI data: " + e.Message);
            }
            //Console.WriteLine("OS version: " + osVer);
            return osVer;
        }
        /*

public string getProductId() {
    string productId = "";
    try {
        foreach (ManagementObject queryObj in searcher.Get()) { productId = Convert.ToString(queryObj["SerialNumber"]); }
    } catch (ManagementException e) {
        Console.WriteLine("An error occurred while querying for WMI data: " + e.Message);
    }
    //Console.WriteLine("productId: " + productId);
    return productId;
}
public string getOrganization() {
    string org = "";
    try {
        foreach (ManagementObject queryObj in searcher.Get()) {
            org = Convert.ToString(queryObj["Organization"]);
        }
    } catch (ManagementException e) {
        Console.WriteLine("An error occurred while querying for WMI data: " + e.Message);
    }
    //System.Console.WriteLine("組織名: " + org);
    return org;
}
public string getInstallDate() {
    string installdate = "";
    try {
        foreach (ManagementObject queryObj in searcher.Get()) {
            installdate = Convert.ToString(queryObj["InstallDate"]);
        }
    } catch (ManagementException e) {
        Console.WriteLine("An error occurred while querying for WMI data: " + e.Message);
    }
    //Console.WriteLine("インストール日時: " + installdate);
    return installdate;
}
public string getComputerDescription() {
    String description = "";
    try {
        foreach (ManagementObject queryObj in searcher.Get()) {
            description = (String)queryObj["Description"];
        }
    } catch (ManagementException e) {
        Console.WriteLine(e.StackTrace);
    }
    //Console.WriteLine("コンピュータの説明: " + description);
    return description;
}
public string getBootTime() {
    string boottime = "";
    try {
        foreach (ManagementObject queryObj in searcher.Get()) {
            boottime = (String)queryObj["LastBootUpTime"];
        }
    }catch(ManagementException e){
        Console.WriteLine(e.StackTrace);
    }
    return boottime;
}
/*
public string getTerminalService() {
    string terminalService = "";
    try {
        ManagementObjectSearcher searcher = new　ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_TerminalServiceSetting");
        foreach (ManagementObject queryObj in searcher.Get()){
            int _terminalService = int.Parse(queryObj["AllowTSConnections"].ToString());
            if (_terminalService == 1) {
                terminalService = "true";
            } else {
                terminalService = "false";
            }
        }
    }catch(Exception){
        try {
            string rKeyName = @"SYSTEM\CurrentControlSet\Control\Terminal Server";
            string rValueName = "fDenyTSConnections";
            Microsoft.Win32.RegistryKey rKey = Microsoft.Win32.Registry.LocalMachine.OpenSubKey(rKeyName);
            string sValue = (string)rKey.GetValue(rValueName).ToString();
            Console.WriteLine("TS sValue: " + sValue);
            if (int.Parse(sValue) == 0) {
                terminalService = "true";
            } else {
                terminalService = "false";
            }
            rKey.Close();
        }catch(Exception){
            terminalService = "false";
        }
    }
    //Console.WriteLine("TerminalServiceは " + terminalService + " です");
    return terminalService;
}
public string getShareFolder() {
    int cnt = 0;
    try {
        ManagementObjectSearcher searcher = new ManagementObjectSearcher("root\\CIMV2", "SELECT * FROM Win32_Share Where Type = 0");
        foreach (ManagementObject queryObj in searcher.Get()) {
            //(string)queryObj["Name"];
            cnt++;
        }
        //Console.WriteLine("ShareFolderは " + shareFolder + " です");
    } catch (ManagementException e) {
        Console.WriteLine("An error occurred while querying for WMI data: " + e.Message);
    }
    return cnt.ToString();
}
 */
 
    }
}
