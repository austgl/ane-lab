using System;

namespace pcInfo {
    public class pcInfoClass {

        private Controller ctrl;

        public pcInfoClass() {
            ctrl = new Controller();
        }

        public void Run() {
            ctrl.run();
        }

        public ComputerBean getPcInfo() {
            return ctrl.GetBean;
        } 
    }
}
