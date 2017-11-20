unit WebProtocols;

interface
type
  TServerManager = class
       Tasks : array of TTask;
       TaskLen : integer;
       Servers : array of TTaskNode;
       function GetTask(TaskId:Integer):Integer; //create task from getfile
       function InitTask(Task:TTask):Integer; //send task to nodes
       function Update():Integer;
       //protocols
       function HowAU(Node:TTaskNode):string;
       //function HowAUSpec(Node:TTaskNode; Par:Integer=1):string;   //1 ~ HowAU, 0 - ping, 2 - tasks, 3 - Machine stat ...
       //function Ping(Node:TTaskNode):string;
       function HowAYrTsk(Node:TTaskNode; TaskID:integer):string;
       //function StopAllPls(Node:TTaskNode):string;
       //function StopItPls(Node:TTaskNode; TaskId:Integer):string;
       function StartDoItPls(Node:TTaskNode; Frames:TFrames; TaskId:Integer):string;
       //function RestartPls(Node:TTaskNode):string;
       //function DoCustomCodePls(Node:TTaskNode; Code:string):string;


  end;

  TnodeTask = record
      TaskID:Integer;
      State:Integer;                //0 - cleared 1 (start) 2 (Get 1 rez) 3 get ful rez 4 ready 5 nedd destroy .. 20-40..errors
      Lframes: TFrames;
      TbestFr:array of array[0..3] of Real;
  end;

  TNodeManager = class
      Tasks: array of TnodeTask;
      MainServerIP:string;
      MainServerPo:integer;
      //protocols
      function IDoneTask(TaskId:Integer; BestFr:array of Real):string;
      //Answer protocols //generete string answer that sends back, all of them get the cut string(without protocod)
      function OnHowAU(Params:string):string;
      function OnHowAUSpec(Params:string):string;
  end;


implementation

end.
