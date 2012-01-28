using System;
using System.Collections;

namespace OutlookExpress_CS {
    public class OE_CS {
        
        private IE ie = new IE();

        public ArrayList getDbxFiles() {
            return ie.getDbxInfo();
        }
    }
}
