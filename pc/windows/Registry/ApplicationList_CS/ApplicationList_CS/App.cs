using System;
using System.Collections;
using System.Collections.Generic;
using System.Management;
using Microsoft.Win32;

namespace ApplicationList_CS {
    class App {
        //HotFix情報
        private const string root = "root\\CIMV2";
        private const string query = "SELECT * FROM Win32_QuickFixEngineering WHERE ServicePackInEffect <> '' AND InstalledBy <> ''";

        public ArrayList getApplicationNames() {
            List<string> hotfix = new List<string>();
            List<string> app = new List<string>();

            ManagementObjectSearcher searcher = new ManagementObjectSearcher(root, query);

            try {
                foreach (ManagementObject queryObj in searcher.Get()) {
                    hotfix.Add((string)queryObj["HotFixID"]);
                }
            } catch (Exception e) {
                Console.WriteLine(e.StackTrace);
            } finally {
                searcher = null;
            }
            RegistryKey regKey = null;
            RegistryKey _subRegKey = null;
            try {
                //アプリケーション情報
                string reg = @"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\";
                string regValue = "DisplayName";
                regKey = Registry.LocalMachine.OpenSubKey(reg);
                string[] subkey = regKey.GetSubKeyNames();

                foreach (string keyName in subkey) {

                    _subRegKey = Registry.LocalMachine.OpenSubKey(reg + keyName);
                    string value = (string)_subRegKey.GetValue(regValue);

                    if (value != null) {
                        for (int j = 0; j < hotfix.Count; j++) {
                            if (value.Contains(hotfix[j].ToString())) {
                                ;
                            } else if (value.Contains("KB")) {
                                ;
                            } else {
                                app.Add(value);
                                break;
                            }
                        }
                    }
                    //value = null;
                }
                app.TrimExcess();

                reg = null;
                regValue = null;
                subkey = null;
            } catch (NullReferenceException e) {
                Console.WriteLine(e.StackTrace);
            } finally {
                regKey.Close();
                _subRegKey.Close();
            }

            app.Sort();

            for (int i = 0; i < (app.Count - 1); i++) {
                try {
                    if (app[i].Equals(app[i + 1])) {
                        app.RemoveAt(i);
                    }
                } catch (Exception ex) {
                    Console.WriteLine(ex.Message);
                }
            }
            app.TrimExcess();
            hotfix = null;
            return new ArrayList(app);
        }
    }
}
