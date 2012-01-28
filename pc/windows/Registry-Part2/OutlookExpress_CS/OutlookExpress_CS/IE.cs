using System;
using System.Collections;
using System.IO;
using Microsoft.Win32;

namespace OutlookExpress_CS {
    class IE {

        public ArrayList getDbxInfo() {
            RegistryKey rKey = null;
            ArrayList list = new ArrayList();
            

            try {
                string rKeyName = @"Identities";
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
                foreach (string file in files) {
                    FileInfo info = new FileInfo(file);
                    long fileSize = info.Length;

                    OE_Files dbxFile = new OE_Files();

                    //KB
                    if (fileSize >= 1024) {
                        fileSize = fileSize / 1024;
                        dbxFile.fileName = info.Name;
                        dbxFile.fileSize = fileSize + "KB";

                        //MB
                        if (fileSize >= 1024) {
                            fileSize = fileSize / 1024;
                            dbxFile.fileName = info.Name;
                            dbxFile.fileSize = fileSize + "KB";

                            //GB
                            if (fileSize >= 1024) {
                                fileSize = fileSize / 1024;
                                dbxFile.fileName = info.Name;
                                dbxFile.fileSize = fileSize + "KB";

                                //1.5GB以上
                                if (fileSize >= 1.5) {
                                    dbxFile.fileName = info.Name;
                                    dbxFile.fileSize = fileSize + "KB";
                                }
                            }
                        }
                    }
                    list.Add(dbxFile);
                }
                files = null;
                rKeyName = null;
                rValueName = null;
                sValue = null;
                //Console.WriteLine("sValue: " + sValue);

            } catch (Exception) {

            } finally {
                rKey.Close();
            }
            return list;
        }
    }
}
