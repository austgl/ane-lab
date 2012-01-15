using System;
//using System.Threading;
using System.Collections;

namespace pcInfo {
    public class pcInfoClass {

        private static ComputerBean bean;

        public pcInfoClass() {
            bean = new ComputerBean();
        }

        public void Run() {
            bean.Run();
        }

        public Hashtable getPcInfo() {
            
            //Thread th = new Thread(new ThreadStart(bean.Run));
            //th.Start();
            return bean.getPcInfo();
        } 
    }
}
