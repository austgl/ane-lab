using System;
using System.Collections;
using System.IO;
using Microsoft.Win32;

namespace OutlookExpress_CS {
    class IE {

        private string dbxFiles;

        public IE() {
            this.setDbxFiles();
        }
 
        public string DbxFiles {
            get {return this.dbxFiles; }
        }

        private void setDbxFiles() {
            RegistryKey rKey = null;
            try {
                string rKeyName = @"Identities";
                //Console.WriteLine(rKeyName);
                string rValueName = "Last User ID";
                rKey = Registry.CurrentUser.OpenSubKey(rKeyName);
                string sValue = (string)rKey.GetValue(rValueName).ToString();
                //Console.WriteLine("sValue: " + sValue);

                rKeyName = @"Identities\" + sValue + @"\Software\Microsoft\Outlook Express\5.0";
                rValueName = "Store Root";

                rKey = Registry.CurrentUser.OpenSubKey(rKeyName);
                sValue = (string)rKey.GetValue(rValueName).ToString();
                string[] files = Directory.GetFiles(sValue);

                //OEの全ファイル容量を調べる
                this.dbxFiles = "";

                foreach (string file in files) {
                    FileInfo info = new FileInfo(file);
                    long fileSize = info.Length;
                    string dbxFiles = "";

                    //KB
                    if (fileSize >= 1024) {
                        fileSize = fileSize / 1024;
                        dbxFiles = info.Name + "/" + fileSize + "KB,";

                        //MB
                        if (fileSize >= 1024) {
                            fileSize = fileSize / 1024;
                            dbxFiles = info.Name + "/" + fileSize + "MB,";

                            //GB
                            if (fileSize >= 1024) {
                                fileSize = fileSize / 1024;
                                dbxFiles = info.Name + "/" + fileSize + "GB,";

                                //1.5GB以上
                                if (fileSize >= 1.5) {
                                    dbxFiles = info.Name + "/" + fileSize + "GB,";
                                }
                            }
                        }
                    }
                    this.dbxFiles += dbxFiles;
                    dbxFiles = "";
                }
                
            } catch (Exception) {

            } finally {
                rKey.Close();
            }
        }
    }
}
