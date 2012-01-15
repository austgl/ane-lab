using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using System.Threading.Tasks;
using IntraMaster;

namespace ThreadTest {
    class Program {
        static void Main(string[] args) {
            //Console.WriteLine("Start!");
            //ctrl.Run(null);
            Parallel.Invoke(() => {
                    Control ctrl = new Control();
                    Stopwatch sw = new Stopwatch();
                    sw.Start();
                    ctrl.Run();
                    sw.Stop();
                    Console.WriteLine("Thread running time:" + sw.Elapsed);
                }
            );
            //Control ctrl2 = new Control();
            //Stopwatch sw2 = new Stopwatch();
            //sw2.Restart();
            //ctrl2.Run(null);
            //sw2.Stop();
            //Console.WriteLine("No Thread running time:" + sw2.Elapsed);

        }
    }
}
