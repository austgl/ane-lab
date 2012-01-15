using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HelloLibrary {
    public interface HelloInterface {
        String getHelloString();
    }
    public class HelloClass:HelloInterface {
        
        public HelloClass() { 
        
        }

        public String getHelloString() {
            return "C# DLL talking 'say Hello'!";
        }
    }
}
