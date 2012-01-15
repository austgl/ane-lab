using System;
using System.Collections;

namespace pcInfo {
    
    class ComputerBean {

        private Hashtable pc = null;


        private Processor cpu;
        private Memory memory;
        private Machine computer;
        private Os os;
        private Disk disk;

        //Computer
        private string _computerName;
        private string _computerDomain;
        private string _computerModel;
        private string _computerManufacturer;
        private string _computerRole;

        private string _logonAccount;
        private string _logonTime;

        private string _cpuNumber;
        private string _cpuClock;
        private string _cpuInfo;

        private string _memoryTotal;

        // OS
        private string _osName;
        private string _osVersion;

        private string _C_Total;
        private string _C_Used;
        private string _C_Free;
        private string _C_FreePercent;

        public ComputerBean() {
        }
        public void Run() {
            this.setParameter();
        }
        private void setParameter() {
            cpu = new Processor();
            memory = new Memory();
            computer = new Machine();
            os = new Os();
            disk = new Disk();
            
            // cpu
            this._cpuNumber = cpu.getCpu();
            this._cpuClock = cpu.getCpuClock();
            this._cpuInfo = cpu.getCpuInfo();

            // memory
            this._memoryTotal = memory.getMemory();


            // Computer
            this._computerName = computer.getComputerName();
            this._computerDomain = computer.getWorkGroupName();
            this._computerRole = computer.getRole();
            this._computerManufacturer = computer.getComputerManufacturer(); // ���[�J�[��
            this._computerModel = computer.getComputerModel();

            // OS
            this._osName = os.getOS();
            this._osVersion = os.getOsVersion();

            // disk
            this._C_Total = disk.getC_Total();
            this._C_Used = disk.getC_Used();
            this._C_Free = disk.getC_Free();
            this._C_FreePercent = disk.getC_FreePercent();

            try {
                // user
                string _account = computer.getUserName();
                /* '\\'��������Ȃ�������AActiveDirectory */
                if (_account.IndexOf('\\') == -1) {
                    this._logonAccount = computer.getWorkGroupName() + "\\" + computer.getUserName();

                }
                    /* '\\'������������A���[�N�O���[�v */
                else {
                    this._logonAccount = computer.getUserName();
                }
                this._logonTime = computer.getLogonTime();

                pc = new Hashtable();

                pc.Add("cpuNumber", this._cpuNumber);
                pc.Add("cpuClock", this._cpuClock);
                pc.Add("cpuInfo", this._cpuInfo);

                pc.Add("memoryTotal", this._memoryTotal);

                pc.Add("computerName", this._computerName);
                pc.Add("computerDomain", this._computerDomain);
                pc.Add("computerRole", this._computerRole);
                pc.Add("computerManufacturer", this._computerManufacturer);
                pc.Add("computerModel", this._computerModel);

                // OS
                pc.Add("osName", this._osName);
                pc.Add("osVersion", this._osVersion);

                // disk
                pc.Add("C_Total", this._C_Total);
                pc.Add("C_Used", this._C_Used);
                pc.Add("C_Free", this._C_Free);
                pc.Add("C_FreePercent", this._C_FreePercent);

                // user
                pc.Add("logonAccount", this._logonAccount);
                pc.Add("logonTime", this._logonTime);
            }catch(Exception){
            
            }
        }

        public void show() {
            Console.WriteLine("�R���s���[�^��: " + _computerName);
            Console.WriteLine("���[�N�O���[�v��: " + _computerDomain);
            Console.WriteLine("�R���s���[�^�̖���: " + _computerRole);
            Console.WriteLine("���f��: " + _computerModel);
            Console.WriteLine("���[�J�[: " + _computerManufacturer);

            Console.WriteLine("CPU�̐�: " + _cpuNumber);
            Console.WriteLine("�N���b�N���g��: " + _cpuClock);
            Console.WriteLine("CPU���: " + _cpuInfo);

            Console.WriteLine("�����������[���v: " + _memoryTotal);

            Console.WriteLine("OS: " + _osName);
            Console.WriteLine("OS Version: " + _osVersion);

            Console.WriteLine("C:\\�e��: " + _C_Total);
            Console.WriteLine("C:\\�g�p��: " + _C_Used);
            Console.WriteLine("C:\\�󂫗e��: " + _C_Free);
            Console.WriteLine("C:\\�󂫗e��(%): " + _C_FreePercent);

            Console.WriteLine("���O�I���A�J�E���g: " + _logonAccount);
            Console.WriteLine("���O�I����������: " + _logonTime);

            Console.WriteLine();

        }

        public Hashtable getPcInfo() {
            return pc;
        }
    }
}
