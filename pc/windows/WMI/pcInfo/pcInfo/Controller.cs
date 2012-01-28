using System;

namespace pcInfo {
    class Controller {

        private ComputerBean bean;

        private Processor cpu;
        private Machine computer;
        private Os os;
        private Disk disk;

        public Controller() {

        }
        public ComputerBean GetBean { get { return bean; } }


        public void run() {
            cpu = new Processor();
            computer = new Machine();
            os = new Os();
            disk = new Disk();

            bean = new ComputerBean();

            bean.computerName = computer.GetComputerName;
            bean.computerDomain = computer.GetWorkGroupName;
            bean.computerRole = computer.GetRole;
            bean.computerModel = computer.GetComputerModel;

            bean.memoryTotal = computer.GetMemory;

            bean.logonAccount = computer.GetUserName;
            bean.logonTime = computer.GetLogonTime;

            bean.cpuClock = cpu.GetCpuClock;
            bean.cpuInfo = cpu.GetCpuInfo;


            bean.osName = os.GetOS;
            bean.osVersion = os.GetOsVersion;

            bean.C_Total = disk.GetC_Total;
            bean.C_Used = disk.GetC_Used;
            bean.C_Free = disk.GetC_Free;
            bean.C_FreePercent = disk.GetC_FreePercent;
        }
    }
}
