using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AppList_CS {
    public class AppList {
        public ArrayList getApplicationList() {
            return new App().GetApplications;
        }
    }
}
