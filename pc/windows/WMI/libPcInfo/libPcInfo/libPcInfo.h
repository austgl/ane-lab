// libPcInfo.h
#include <gcroot.h>
#include <stdlib.h>
#include <string.h> 
#include <process.h> 

#pragma once
#using <mscorlib.dll>
#using "pcInfo.dll"

using namespace System;
using namespace System::Runtime::InteropServices;
using namespace pcInfo;
using namespace System::Collections;

namespace libPcInfo {
	
	

	public ref class Class1
	{
		// TODO: ���̃N���X�́A���[�U�[�̃��\�b�h�������ɒǉ����Ă��������B
	};
	
	class Hoge{
		public:
			gcroot<pcInfoClass^> info;
	};

}
