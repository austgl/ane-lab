using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Management;
using Microsoft.Win32;

namespace AppList_CS {
    class App {

        private ArrayList applications;

        public App() {
            this.setApplicationReg();
        }
        public ArrayList GetApplications {
            get { return this.applications; }
        }

        private void setApplicationReg() {
            string[] val1 = null;
            string[] val2 = null;
            string[] val3 = null;


            ArrayList application;
            ArrayList applicationVersion;
            ArrayList hotfix;

            application = new ArrayList(); // application
            applicationVersion = new ArrayList(); // applicationVersion
            hotfix = new ArrayList(); // HotFix
            try {
                //HotFix情報
                string root = "root\\CIMV2";
                string query = "SELECT * FROM Win32_QuickFixEngineering WHERE ServicePackInEffect <> '' AND InstalledBy <> ''";
                ManagementObjectSearcher searcher = new ManagementObjectSearcher(root, query);
                int cnt = 0;
                foreach (ManagementObject queryObj in searcher.Get()) { cnt++; }
                val1 = new string[cnt];
                int i=0;
                foreach (ManagementObject queryObj in searcher.Get()) {
                    val1[i] = (string)queryObj["HotFixID"];
                    i++;
                }
            }catch(Exception e){
                string error = e.StackTrace;
                //Console.WriteLine(e.StackTrace);
            }
            try {
                //アプリケーション情報
                string reg = @"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\";
                string regValue = "DisplayName";
                RegistryKey regKey = Registry.LocalMachine.OpenSubKey(reg);
                string[] subkey = regKey.GetSubKeyNames();
                int max = subkey.Length;
                regKey.Close();

                //アプリケーションの総数
                val2 = new string[max];
                val3 = new string[max];
                RegistryKey _subRegKey = null;
                int i = 0;
                foreach (string keyName in subkey) {
                    _subRegKey = Registry.LocalMachine.OpenSubKey(reg + keyName);
                    if ((string)_subRegKey.GetValue(regValue) != null) {
                        val2[i] = (string)_subRegKey.GetValue("DisplayName");
                        val3[i] = (string)_subRegKey.GetValue("DisplayVersion");
                        i++;
                    }
                    _subRegKey.Close();
                }
            } catch (NullReferenceException e) {
                string error = e.StackTrace;
                //Console.WriteLine(e.StackTrace);
            }
            try {
                for (int i = 0; i < val2.Length; i++) {
                    if(val2[i] != null){
                        for(int j = 0; j < val1.Length; j++){
                            if (val2[i].Contains(val1[j])) {
                                hotfix.Add(val2[i]);
                                val2[i] = null;
                                val3[i] = null;
                                break;
                            }else if(val2[i].Contains("KB")){
                                hotfix.Add(val2[i]);
                                val2[i] = null;
                                val3[i] = null;
                                break;
                            }
                        }
                    }
                }
                foreach(string _val in val2){
                    if( _val == null){
                        ;
                    } else {
                        application.Add(_val);
                    }
                }
                foreach (string _val in val3) {
                    if (_val == null) {
                        ;
                    } else {
                       applicationVersion.Add(_val);
                    }
                }
                application.TrimToSize();
                applicationVersion.TrimToSize();
                hotfix.TrimToSize();

                application.Sort();
                for (int i = 0; i < application.Count; i++ ) {
                    try {
                        if (application[i].Equals(application[i + 1])) {
                            application.RemoveAt(i);
                        }
                    }catch(Exception){
                    
                    }
                }
                application.TrimToSize();

                this.applications = application;
                //this.application = new string[application.Count];
                //this.applicationVersion = new string[applicationVersion.Count];
                //this.hotfix = new string[hotfix.Count];

                //for (int i = 0; i < application.Count; i++) { this.application[i] = (string)application[i]; }
                //for (int i = 0; i < applicationVersion.Count; i++) { this.applicationVersion[i] = (string)applicationVersion[i]; }
                //for (int i = 0; i < hotfix.Count; i++) { this.hotfix[i] = (string)hotfix[i]; }
            } catch (NullReferenceException ne) {
                Console.WriteLine(ne.StackTrace);
            }
        }
    }
}
