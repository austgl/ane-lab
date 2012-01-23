using System;

namespace OutlookExpress_CS {
    public class OE_CS {
        
        private IE ie = new IE();

        public string getDbxFiles() {
            return ie.DbxFiles;
        }
    }
}
